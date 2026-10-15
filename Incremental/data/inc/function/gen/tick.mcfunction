execute unless entity @s[tag=inc.visual2] run function inc:gen/upgrade_visual
execute unless block ~ ~ ~ minecraft:glass run return run function inc:gen/refund
execute unless block ~ ~-1 ~ #inc:chests run return 0
scoreboard players operation #kind inc.tmp = @s inc.kind
execute positioned ~ ~-1 ~ if entity @e[type=minecraft:armor_stand,tag=inc.vault,distance=..0.1] run return run function inc:gen/to_vault
execute if score @s inc.kind matches 0 run loot insert ~ ~-1 ~ loot inc:output/dirt
execute if score @s inc.kind matches 1 run loot insert ~ ~-1 ~ loot inc:output/oak
execute if score @s inc.kind matches 2 run loot insert ~ ~-1 ~ loot inc:output/stone
execute if score @s inc.kind matches 3 run loot insert ~ ~-1 ~ loot inc:output/iron
execute if score @s inc.kind matches 4 run loot insert ~ ~-1 ~ loot inc:output/gold
execute if score @s inc.kind matches 5 run loot insert ~ ~-1 ~ loot inc:output/diamond
execute if score @s inc.kind matches 6 run loot insert ~ ~-1 ~ loot inc:output/netherite
execute if score @s inc.kind matches 7 run loot insert ~ ~-1 ~ loot inc:output/coal
execute if score @s inc.kind matches 8 run loot insert ~ ~-1 ~ loot inc:output/copper
execute if score @s inc.kind matches 9 run loot insert ~ ~-1 ~ loot inc:output/redstone
execute if score @s inc.kind matches 10 run loot insert ~ ~-1 ~ loot inc:output/lapis
execute if score @s inc.kind matches 11 run loot insert ~ ~-1 ~ loot inc:output/emerald
execute if score @s inc.kind matches 12 run loot insert ~ ~-1 ~ loot inc:output/obsidian
execute if score @s inc.kind matches 13 run loot insert ~ ~-1 ~ loot inc:output/quartz
execute if score @s inc.kind matches 14 run loot insert ~ ~-1 ~ loot inc:output/glowstone
execute if score @s inc.kind matches 15 run loot insert ~ ~-1 ~ loot inc:output/magma
execute if score @s inc.kind matches 16 run loot insert ~ ~-1 ~ loot inc:output/sea_lantern
execute if score @s inc.kind matches 17 run loot insert ~ ~-1 ~ loot inc:output/blue_ice
execute if score @s inc.kind matches 18 run loot insert ~ ~-1 ~ loot inc:output/wool
execute if score @s inc.kind matches 19 run loot insert ~ ~-1 ~ loot inc:output/string
execute if score @s inc.kind matches 20 run loot insert ~ ~-1 ~ loot inc:output/slime
execute if score @s inc.kind matches 21 run loot insert ~ ~-1 ~ loot inc:output/spruce
execute if score @s inc.kind matches 22 run loot insert ~ ~-1 ~ loot inc:output/birch
execute if score @s inc.kind matches 23 run loot insert ~ ~-1 ~ loot inc:output/jungle
execute if score @s inc.kind matches 24 run loot insert ~ ~-1 ~ loot inc:output/acacia
execute if score @s inc.kind matches 25 run loot insert ~ ~-1 ~ loot inc:output/dark_oak
execute if score @s inc.kind matches 26 run loot insert ~ ~-1 ~ loot inc:output/mangrove
execute if score @s inc.kind matches 27 run loot insert ~ ~-1 ~ loot inc:output/cherry
execute if score @s inc.kind matches 28 run loot insert ~ ~-1 ~ loot inc:output/pale_oak
execute if score @s inc.kind matches 29 run loot insert ~ ~-1 ~ loot inc:output/poplar
execute if score @s inc.kind matches 30 run loot insert ~ ~-1 ~ loot inc:output/crimson
execute if score @s inc.kind matches 31 run loot insert ~ ~-1 ~ loot inc:output/warped
execute if score @s inc.kind matches 32 run loot insert ~ ~-1 ~ loot inc:output/bamboo
execute if score @s inc.kind matches 33 run loot insert ~ ~-1 ~ loot inc:output/sand
execute if score @s inc.kind matches 34 run loot insert ~ ~-1 ~ loot inc:output/soul_sand
execute if score @s inc.kind matches 35 run loot insert ~ ~-1 ~ loot inc:output/blaze_rod
execute if score @s inc.kind matches 36 run loot insert ~ ~-1 ~ loot inc:output/wither_skull
