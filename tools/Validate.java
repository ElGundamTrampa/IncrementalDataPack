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

/** Parse functions with the locally installed game's actual command dispatcher. */
public class Validate {
    public static void main(String[] args) throws Exception {
        SharedConstants.tryDetectVersion();
        Bootstrap.bootStrap();
        var registries = VanillaRegistries.createWorldLookup();
        var context = Commands.createValidationContext(registries);
        var commands = new Commands(Commands.CommandSelection.ALL, context);
        var source = Commands.createCompilationContext(PermissionSet.ALL_PERMISSIONS);
        int count = 0;
        int errors = 0;
        Path base = Path.of(args[0]);
        try (var files = Files.walk(base)) {
            for (Path file : files.filter(p -> p.toString().endsWith(".mcfunction")).sorted().toList()) {
                String name = base.relativize(file).toString().replace('\\', '/').replace(".mcfunction", "");
                try {
                    var fn = CommandFunction.fromLines(Identifier.parse("inc:" + name), commands.getDispatcher(), source, Files.readAllLines(file));
                    var params = new CompoundTag();
                    params.putInt("amount", 64);
                    fn.instantiate(params, commands.getDispatcher());
                    count++;
                } catch (Exception error) {
                    System.out.println("FAIL " + name + ": " + error.getMessage());
                    errors++;
                }
            }
        }
        System.out.println("RESULT: " + count + " functions passed; " + errors + " errors");
        System.exit(errors == 0 ? 0 : 1);
    }
}
