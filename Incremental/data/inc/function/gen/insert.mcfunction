data modify storage inc:runtime before set from block ~ ~ ~ Items
$loot insert ~ ~ ~ loot inc:output/$(output)
execute store success score @s inc.tmp run data modify storage inc:runtime before set from block ~ ~ ~ Items
execute if score @s inc.tmp matches 1 run return 1
execute if block ~ ~ ~ minecraft:chest[facing=north,type=left] positioned ~1 ~ ~0 if block ~ ~ ~ minecraft:chest[facing=north,type=right] run return run function inc:gen/insert_partner with storage inc:runtime
execute if block ~ ~ ~ minecraft:chest[facing=north,type=right] positioned ~-1 ~ ~0 if block ~ ~ ~ minecraft:chest[facing=north,type=left] run return run function inc:gen/insert_partner with storage inc:runtime
execute if block ~ ~ ~ minecraft:chest[facing=east,type=left] positioned ~0 ~ ~1 if block ~ ~ ~ minecraft:chest[facing=east,type=right] run return run function inc:gen/insert_partner with storage inc:runtime
execute if block ~ ~ ~ minecraft:chest[facing=east,type=right] positioned ~0 ~ ~-1 if block ~ ~ ~ minecraft:chest[facing=east,type=left] run return run function inc:gen/insert_partner with storage inc:runtime
execute if block ~ ~ ~ minecraft:chest[facing=south,type=left] positioned ~-1 ~ ~0 if block ~ ~ ~ minecraft:chest[facing=south,type=right] run return run function inc:gen/insert_partner with storage inc:runtime
execute if block ~ ~ ~ minecraft:chest[facing=south,type=right] positioned ~1 ~ ~0 if block ~ ~ ~ minecraft:chest[facing=south,type=left] run return run function inc:gen/insert_partner with storage inc:runtime
execute if block ~ ~ ~ minecraft:chest[facing=west,type=left] positioned ~0 ~ ~-1 if block ~ ~ ~ minecraft:chest[facing=west,type=right] run return run function inc:gen/insert_partner with storage inc:runtime
execute if block ~ ~ ~ minecraft:chest[facing=west,type=right] positioned ~0 ~ ~1 if block ~ ~ ~ minecraft:chest[facing=west,type=left] run return run function inc:gen/insert_partner with storage inc:runtime
execute if block ~ ~ ~ minecraft:trapped_chest[facing=north,type=left] positioned ~1 ~ ~0 if block ~ ~ ~ minecraft:trapped_chest[facing=north,type=right] run return run function inc:gen/insert_partner with storage inc:runtime
execute if block ~ ~ ~ minecraft:trapped_chest[facing=north,type=right] positioned ~-1 ~ ~0 if block ~ ~ ~ minecraft:trapped_chest[facing=north,type=left] run return run function inc:gen/insert_partner with storage inc:runtime
execute if block ~ ~ ~ minecraft:trapped_chest[facing=east,type=left] positioned ~0 ~ ~1 if block ~ ~ ~ minecraft:trapped_chest[facing=east,type=right] run return run function inc:gen/insert_partner with storage inc:runtime
execute if block ~ ~ ~ minecraft:trapped_chest[facing=east,type=right] positioned ~0 ~ ~-1 if block ~ ~ ~ minecraft:trapped_chest[facing=east,type=left] run return run function inc:gen/insert_partner with storage inc:runtime
execute if block ~ ~ ~ minecraft:trapped_chest[facing=south,type=left] positioned ~-1 ~ ~0 if block ~ ~ ~ minecraft:trapped_chest[facing=south,type=right] run return run function inc:gen/insert_partner with storage inc:runtime
execute if block ~ ~ ~ minecraft:trapped_chest[facing=south,type=right] positioned ~1 ~ ~0 if block ~ ~ ~ minecraft:trapped_chest[facing=south,type=left] run return run function inc:gen/insert_partner with storage inc:runtime
execute if block ~ ~ ~ minecraft:trapped_chest[facing=west,type=left] positioned ~0 ~ ~-1 if block ~ ~ ~ minecraft:trapped_chest[facing=west,type=right] run return run function inc:gen/insert_partner with storage inc:runtime
execute if block ~ ~ ~ minecraft:trapped_chest[facing=west,type=right] positioned ~0 ~ ~1 if block ~ ~ ~ minecraft:trapped_chest[facing=west,type=left] run return run function inc:gen/insert_partner with storage inc:runtime
