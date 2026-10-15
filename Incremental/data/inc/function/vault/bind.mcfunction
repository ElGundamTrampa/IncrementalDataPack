data modify storage inc:runtime prototype set from storage inc:runtime probe
scoreboard players set @s inc.kind -2
execute if data storage inc:runtime {probe:{id:"minecraft:dirt"}} run function inc:vault/canonical/dirt
execute if data storage inc:runtime {probe:{id:"minecraft:oak_log"}} run function inc:vault/canonical/oak
execute if data storage inc:runtime {probe:{id:"minecraft:cobblestone"}} run function inc:vault/canonical/stone
execute if data storage inc:runtime {probe:{id:"minecraft:iron_ingot"}} run function inc:vault/canonical/iron
execute if data storage inc:runtime {probe:{id:"minecraft:gold_ingot"}} run function inc:vault/canonical/gold
execute if data storage inc:runtime {probe:{id:"minecraft:diamond"}} run function inc:vault/canonical/diamond
execute if data storage inc:runtime {probe:{id:"minecraft:netherite_ingot"}} run function inc:vault/canonical/netherite
execute if data storage inc:runtime {probe:{id:"minecraft:coal"}} run function inc:vault/canonical/coal
execute if data storage inc:runtime {probe:{id:"minecraft:copper_ingot"}} run function inc:vault/canonical/copper
execute if data storage inc:runtime {probe:{id:"minecraft:redstone"}} run function inc:vault/canonical/redstone
execute if data storage inc:runtime {probe:{id:"minecraft:lapis_lazuli"}} run function inc:vault/canonical/lapis
execute if data storage inc:runtime {probe:{id:"minecraft:emerald"}} run function inc:vault/canonical/emerald
execute if data storage inc:runtime {probe:{id:"minecraft:obsidian"}} run function inc:vault/canonical/obsidian
execute if data storage inc:runtime {probe:{id:"minecraft:quartz"}} run function inc:vault/canonical/quartz
execute if data storage inc:runtime {probe:{id:"minecraft:glowstone"}} run function inc:vault/canonical/glowstone
execute if data storage inc:runtime {probe:{id:"minecraft:magma_block"}} run function inc:vault/canonical/magma
execute if data storage inc:runtime {probe:{id:"minecraft:sea_lantern"}} run function inc:vault/canonical/sea_lantern
execute if data storage inc:runtime {probe:{id:"minecraft:blue_ice"}} run function inc:vault/canonical/blue_ice
execute if data storage inc:runtime {probe:{id:"minecraft:white_wool"}} run function inc:vault/canonical/wool
execute if data storage inc:runtime {probe:{id:"minecraft:string"}} run function inc:vault/canonical/string
execute if data storage inc:runtime {probe:{id:"minecraft:slime_block"}} run function inc:vault/canonical/slime
execute if data storage inc:runtime {probe:{id:"minecraft:spruce_log"}} run function inc:vault/canonical/spruce
execute if data storage inc:runtime {probe:{id:"minecraft:birch_log"}} run function inc:vault/canonical/birch
execute if data storage inc:runtime {probe:{id:"minecraft:jungle_log"}} run function inc:vault/canonical/jungle
execute if data storage inc:runtime {probe:{id:"minecraft:acacia_log"}} run function inc:vault/canonical/acacia
execute if data storage inc:runtime {probe:{id:"minecraft:dark_oak_log"}} run function inc:vault/canonical/dark_oak
execute if data storage inc:runtime {probe:{id:"minecraft:mangrove_log"}} run function inc:vault/canonical/mangrove
execute if data storage inc:runtime {probe:{id:"minecraft:cherry_log"}} run function inc:vault/canonical/cherry
execute if data storage inc:runtime {probe:{id:"minecraft:pale_oak_log"}} run function inc:vault/canonical/pale_oak
execute if data storage inc:runtime {probe:{id:"minecraft:poplar_log"}} run function inc:vault/canonical/poplar
execute if data storage inc:runtime {probe:{id:"minecraft:crimson_stem"}} run function inc:vault/canonical/crimson
execute if data storage inc:runtime {probe:{id:"minecraft:warped_stem"}} run function inc:vault/canonical/warped
execute if data storage inc:runtime {probe:{id:"minecraft:bamboo_block"}} run function inc:vault/canonical/bamboo
execute if data storage inc:runtime {probe:{id:"minecraft:sand"}} run function inc:vault/canonical/sand
execute if data storage inc:runtime {probe:{id:"minecraft:soul_sand"}} run function inc:vault/canonical/soul_sand
execute if data storage inc:runtime {probe:{id:"minecraft:blaze_rod"}} run function inc:vault/canonical/blaze_rod
execute if data storage inc:runtime {probe:{id:"minecraft:wither_skeleton_skull"}} run function inc:vault/canonical/wither_skull
execute store result storage inc:runtime maximum int 1 run scoreboard players get @s inc.stack
function inc:vault/write_prototype with storage inc:runtime
