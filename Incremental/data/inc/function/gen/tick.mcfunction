execute unless entity @s[tag=inc.visual2] run function inc:gen/upgrade_visual
execute unless block ~ ~ ~ minecraft:glass run return run function inc:gen/refund
execute unless block ~ ~-1 ~ #inc:generator_outputs run return 0
scoreboard players operation #kind inc.tmp = @s inc.kind
execute positioned ~ ~-1 ~ if entity @e[type=minecraft:armor_stand,tag=inc.vault,distance=..0.1] run return run function inc:gen/to_vault
execute if score @s inc.kind matches 0 run function inc:gen/output/dirt
execute if score @s inc.kind matches 1 run function inc:gen/output/oak
execute if score @s inc.kind matches 2 run function inc:gen/output/stone
execute if score @s inc.kind matches 3 run function inc:gen/output/iron
execute if score @s inc.kind matches 4 run function inc:gen/output/gold
execute if score @s inc.kind matches 5 run function inc:gen/output/diamond
execute if score @s inc.kind matches 6 run function inc:gen/output/netherite
execute if score @s inc.kind matches 7 run function inc:gen/output/coal
execute if score @s inc.kind matches 8 run function inc:gen/output/copper
execute if score @s inc.kind matches 9 run function inc:gen/output/redstone
execute if score @s inc.kind matches 10 run function inc:gen/output/lapis
execute if score @s inc.kind matches 11 run function inc:gen/output/emerald
execute if score @s inc.kind matches 12 run function inc:gen/output/obsidian
execute if score @s inc.kind matches 13 run function inc:gen/output/quartz
execute if score @s inc.kind matches 14 run function inc:gen/output/glowstone
execute if score @s inc.kind matches 15 run function inc:gen/output/magma
execute if score @s inc.kind matches 16 run function inc:gen/output/sea_lantern
execute if score @s inc.kind matches 17 run function inc:gen/output/blue_ice
execute if score @s inc.kind matches 18 run function inc:gen/output/wool
execute if score @s inc.kind matches 19 run function inc:gen/output/string
execute if score @s inc.kind matches 20 run function inc:gen/output/slime
execute if score @s inc.kind matches 21 run function inc:gen/output/spruce
execute if score @s inc.kind matches 22 run function inc:gen/output/birch
execute if score @s inc.kind matches 23 run function inc:gen/output/jungle
execute if score @s inc.kind matches 24 run function inc:gen/output/acacia
execute if score @s inc.kind matches 25 run function inc:gen/output/dark_oak
execute if score @s inc.kind matches 26 run function inc:gen/output/mangrove
execute if score @s inc.kind matches 27 run function inc:gen/output/cherry
execute if score @s inc.kind matches 28 run function inc:gen/output/pale_oak
execute if score @s inc.kind matches 29 run function inc:gen/output/poplar
execute if score @s inc.kind matches 30 run function inc:gen/output/crimson
execute if score @s inc.kind matches 31 run function inc:gen/output/warped
execute if score @s inc.kind matches 32 run function inc:gen/output/bamboo
execute if score @s inc.kind matches 33 run function inc:gen/output/sand
execute if score @s inc.kind matches 34 run function inc:gen/output/soul_sand
execute if score @s inc.kind matches 35 run function inc:gen/output/blaze_rod
execute if score @s inc.kind matches 36 run function inc:gen/output/wither_skull
