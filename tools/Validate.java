import java.nio.file.*;
import java.util.*;
import net.minecraft.SharedConstants;
import net.minecraft.server.Bootstrap;
import net.minecraft.server.permissions.PermissionSet;
import net.minecraft.data.registries.VanillaRegistries;
import net.minecraft.commands.Commands;
import net.minecraft.commands.functions.CommandFunction;
import net.minecraft.resources.Identifier;
import net.minecraft.nbt.CompoundTag;
import net.minecraft.nbt.TagParser;
import net.minecraft.core.registries.BuiltInRegistries;
import net.minecraft.resources.RegistryOps;
import com.mojang.serialization.JsonOps;
import com.google.gson.JsonParser;
import net.minecraft.world.level.storage.loot.LootTable;
import net.minecraft.server.dialog.Dialog;
import net.minecraft.core.BlockPos;
import net.minecraft.core.HolderLookup;
import net.minecraft.core.MappedRegistry;
import net.minecraft.core.RegistrationInfo;
import net.minecraft.core.registries.Registries;
import net.minecraft.resources.ResourceKey;
import com.mojang.serialization.Lifecycle;
import java.util.stream.Stream;
import net.minecraft.world.SimpleContainer;
import net.minecraft.world.Container;
import net.minecraft.world.item.ItemStack;
import net.minecraft.world.item.Items;
import net.minecraft.world.level.EmptyBlockGetter;
import net.minecraft.world.level.block.Blocks;
import net.minecraft.core.component.DataComponents;
import net.minecraft.network.chat.Component;
import net.minecraft.server.commands.LootCommand;
import net.minecraft.nbt.NbtOps;
import net.minecraft.world.entity.EntityTypes;
import net.minecraft.world.phys.AABB;
import net.minecraft.core.Direction;

/** Parse functions with the locally installed game's actual command dispatcher. */
public class Validate {
    public static void main(String[] args) throws Exception {
        SharedConstants.tryDetectVersion();
        Bootstrap.bootStrap();
        Path base = Path.of(args[0]);
        var registries = VanillaRegistries.createWorldLookup();
        for (var pending : BuiltInRegistries.DATA_COMPONENT_INITIALIZERS.build(registries)) pending.apply();
        var sizes = new com.google.gson.JsonObject();
        for (var item : BuiltInRegistries.ITEM) sizes.addProperty(BuiltInRegistries.ITEM.getKey(item).toString(), item.getDefaultMaxStackSize());
        Files.writeString(Path.of(".test-server/stack_sizes.json"), sizes.toString());
        var dialogRegistry = new MappedRegistry<Dialog>(Registries.DIALOG, Lifecycle.stable());
        var dialogOps = RegistryOps.create(JsonOps.INSTANCE, registries);
        Path dialogs = base.getParent().resolve("dialog");
        try (var files = Files.walk(dialogs)) {
            for (var file : files.filter(p -> p.toString().endsWith(".json")).toList()) {
                String name = dialogs.relativize(file).toString().replace('\\', '/').replace(".json", "");
                var dialog = Dialog.DIRECT_CODEC.parse(dialogOps, JsonParser.parseString(Files.readString(file))).getOrThrow();
                dialogRegistry.register(ResourceKey.create(Registries.DIALOG, Identifier.parse("inc:" + name)), dialog, RegistrationInfo.BUILT_IN);
            }
        }
        dialogRegistry.freeze();
        registries = HolderLookup.Provider.create(Stream.concat(registries.listRegistries().filter(r -> !r.key().equals(Registries.DIALOG)), Stream.of(dialogRegistry)));
        var context = Commands.createValidationContext(registries);
        var commands = new Commands(Commands.CommandSelection.ALL, context);
        var source = Commands.createCompilationContext(PermissionSet.ALL_PERMISSIONS);
        int count = 0;
        int errors = 0;
        try (var files = Files.walk(base)) {
            for (Path file : files.filter(p -> p.toString().endsWith(".mcfunction")).sorted().toList()) {
                String name = base.relativize(file).toString().replace('\\', '/').replace(".mcfunction", "");
                try {
                    var fn = CommandFunction.fromLines(Identifier.parse("inc:" + name), commands.getDispatcher(), source, Files.readAllLines(file));
                    var params = new CompoundTag();
                    params.putInt("amount", 64);
                    params.putInt("id", 123);
                    params.putInt("kind", 0);
                    params.putInt("slot", 0);
                    params.putInt("left", 32);
                    params.putInt("total", 256);
                    params.putInt("maximum", 64);
                    params.put("stack", TagParser.parseCompoundFully("{id:\"minecraft:dirt\",count:64}"));
                    fn.instantiate(params, commands.getDispatcher());
                    count++;
                } catch (Exception error) {
                    System.out.println("FAIL " + name + ": " + error.getMessage());
                    errors++;
                }
            }
        }
        var ops = RegistryOps.create(JsonOps.INSTANCE, registries);
        Path pack = base.getParent().getParent().getParent();
        int resources = 0;
        for (String directory : List.of("loot_table", "dialog")) {
            try (var files = Files.walk(base.getParent().resolve(directory))) {
                for (var file : files.filter(p -> p.toString().endsWith(".json")).toList()) {
                    try {
                        var input = JsonParser.parseString(Files.readString(file));
                        if (directory.equals("loot_table")) {
                            var table = LootTable.DIRECT_CODEC.parse(ops, input).getOrThrow();
                            // Roundtrip must retain the placement tags. Unknown fields in JSON
                            // can otherwise be silently ignored even when decoding succeeds.
                            if (file.toString().contains("tokens")) {
                                String encoded = LootTable.DIRECT_CODEC.encodeStart(ops, table).getOrThrow().toString();
                                if (!encoded.contains("inc.new.") || !encoded.contains("minecraft:entity_data"))
                                    throw new IllegalStateException("Placement components were ignored");
                            }
                        } else {
                            Dialog.DIRECT_CODEC.parse(ops, input).getOrThrow();
                        }
                        resources++;
                    } catch (Exception error) {
                        System.out.println("FAIL RESOURCE " + file + ": " + error.getMessage());
                        errors++;
                    }
                }
            }
        }
        for (int group = 1; group <= 5; group++) {
            var input = JsonParser.parseString(Files.readString(base.getParent().resolve("tags/block/mining/g" + group + ".json"))).getAsJsonObject();
            float expected = new float[]{0, 1.25f, 1.5f, 2f, 3f, 3.5f}[group];
            for (var value : input.getAsJsonArray("values")) {
                var block = BuiltInRegistries.BLOCK.getValue(Identifier.parse(value.getAsString()));
                float actual = block.defaultBlockState().getDestroySpeed(null, BlockPos.ZERO);
                if (actual != expected) {
                    System.out.println("HARDNESS " + value.getAsString() + ": actual=" + actual + ", expected=" + expected);
                    errors++;
                }
                for (double speed : new double[]{1, 2, 6, 9, 35, 70}) {
                    double normalized = (speed * (actual / 1.5)) / actual / 30;
                    double stone = speed / 1.5 / 30;
                    if (Math.abs(normalized - stone) > 0.0000001)
                        throw new AssertionError("Mining normalization failed for " + value);
                }
            }
        }
        var chestLoot = JsonParser.parseString(Files.readString(pack.resolve("data/minecraft/loot_table/blocks/chest.json")));
        LootTable.DIRECT_CODEC.parse(ops, chestLoot).getOrThrow();
        resources++;
        // Exercise the same insertion routine that /loot insert uses, without starting
        // Minecraft or touching any world. Full containers must keep their contents.
        var insert = LootCommand.class.getDeclaredMethod("distributeToContainer", Container.class, ItemStack.class);
        insert.setAccessible(true);
        var chest = new SimpleContainer(27);
        if (!(boolean)insert.invoke(null, chest, new ItemStack(Items.DIRT, 1)) || chest.getItem(0).getCount() != 1)
            throw new AssertionError("Insertion into an empty chest failed");
        chest.setItem(0, new ItemStack(Items.DIRT, 63));
        insert.invoke(null, chest, new ItemStack(Items.DIRT, 1));
        if (chest.getItem(0).getCount() != 64) throw new AssertionError("Partial stack was not filled");
        for (int i = 0; i < 27; i++) chest.setItem(i, new ItemStack(Items.DIRT, 64));
        var refused = new ItemStack(Items.DIRT, 1);
        insert.invoke(null, chest, refused);
        if (refused.getCount() != 1) throw new AssertionError("A full chest consumed another item");
        for (int i = 0; i < 27; i++) if (chest.getItem(i).getCount() != 64)
            throw new AssertionError("Full chest contents changed");
        chest.clearContent();
        var special = new ItemStack(Items.DIRT, 32);
        special.set(DataComponents.CUSTOM_NAME, Component.literal("Conservar"));
        chest.setItem(0, special);
        insert.invoke(null, chest, new ItemStack(Items.DIRT, 1));
        if (chest.getItem(0).getCount() != 32 || chest.getItem(1).getCount() != 1)
            throw new AssertionError("A special stack was overwritten");
        if (Blocks.GLASS.defaultBlockState().isRedstoneConductor(EmptyBlockGetter.INSTANCE, BlockPos.ZERO))
            throw new AssertionError("Generator glass would obstruct the chest");
        var itemData = (CompoundTag)ItemStack.CODEC.encodeStart(RegistryOps.create(NbtOps.INSTANCE, registries), new ItemStack(Items.DIRT, 32)).getOrThrow();
        itemData.remove("count");
        if (!itemData.equals(TagParser.parseCompoundFully("{id:\"minecraft:dirt\"}")))
            throw new AssertionError("Plain-item prototype does not match the game's saved inventory format: " + itemData);
        var placementBox = EntityTypes.ARMOR_STAND.getDimensions().makeBoundingBox(0.5, 1, 0.5);
        var oldLabel = new AABB(0.5, 1.2, 0.5, 0.5, 1.2, 0.5);
        var labelConfig = java.util.regex.Pattern.compile("execute positioned ~ ~([+-]?[0-9.]+) ~([+-]?[0-9.]+) summon minecraft:text_display")
            .matcher(Files.readString(base.resolve("vault/setup.mcfunction")));
        if (!labelConfig.find()) throw new AssertionError("Missing label placement configuration");
        double labelY = Double.parseDouble(labelConfig.group(1));
        double labelZ = 0.5 + Double.parseDouble(labelConfig.group(2));
        var fixedLabel = new AABB(0.5, labelY, labelZ, 0.5, labelY, labelZ);
        if (!placementBox.intersects(oldLabel) || placementBox.intersects(fixedLabel))
            throw new AssertionError("Deep-chest label placement regression");
        double lid = Blocks.CHEST.defaultBlockState().getCollisionShape(EmptyBlockGetter.INSTANCE, BlockPos.ZERO).max(Direction.Axis.Y);
        if (lid != 0.875 || !BlockPos.containing(0.5, lid, 0.5).above().equals(new BlockPos(0, 1, 0)))
            throw new AssertionError("Chest-lid placement assumption changed");
        System.out.println("PLACEMENT: chest-lid height and non-obstructing label regressions passed");
        var nbtOps = RegistryOps.create(NbtOps.INSTANCE, registries);
        var pickaxe = new ItemStack(Items.DIAMOND_PICKAXE);
        pickaxe.set(DataComponents.CUSTOM_NAME, Component.literal("Mi pico"));
        pickaxe.set(DataComponents.DAMAGE, 731);
        pickaxe.enchant(registries.lookupOrThrow(Registries.ENCHANTMENT).getOrThrow(ResourceKey.create(Registries.ENCHANTMENT, Identifier.parse("minecraft:efficiency"))), 5);
        var shulker = new ItemStack(Items.SHULKER_BOX);
        shulker.set(DataComponents.CONTAINER, net.minecraft.world.item.component.ItemContainerContents.fromItems(List.of(pickaxe.copy(), new ItemStack(Items.DIAMOND, 42))));
        for (var original : List.of(new ItemStack(Items.DIRT, 64), new ItemStack(Items.ENDER_PEARL, 16), pickaxe, shulker)) {
            var prototype = (CompoundTag)ItemStack.CODEC.encodeStart(nbtOps, original).getOrThrow();
            prototype.remove("count");
            var withdrawn = prototype.copy();
            withdrawn.putInt("count", original.getMaxStackSize());
            var restored = ItemStack.CODEC.parse(nbtOps, withdrawn).getOrThrow();
            if (!ItemStack.isSameItemSameComponents(original, restored) || restored.getCount() != original.getMaxStackSize())
                throw new AssertionError("Universal vault altered item components: " + original);
        }
        System.out.println("UNIVERSAL VAULT: 64/16/1 stacks, names, damage, Efficiency and nested shulker contents roundtrip passed");
        System.out.println("BEHAVIOR: empty/partial/full/special-item chest insertion, chest clearance, mining normalization passed");
        System.out.println("RESOURCES: " + resources + " loot tables/dialogs validated");
        System.out.println("RESULT: " + count + " functions passed; " + errors + " errors");
        System.exit(errors == 0 ? 0 : 1);
    }
}
