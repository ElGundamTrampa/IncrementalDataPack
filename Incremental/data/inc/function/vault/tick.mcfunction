execute unless block ~ ~ ~ minecraft:chest run return run function inc:vault/break
function inc:vault/reposition_label
function inc:vault/collect
execute if score @s inc.kind matches -1 run return 0
scoreboard players operation #id inc.tmp = @s inc.id
execute store result storage inc:runtime total int 1 run scoreboard players get @s inc.buf
execute if score @s inc.kind matches 0 run function inc:vault/output/dirt
execute if score @s inc.kind matches 1 run function inc:vault/output/oak
execute if score @s inc.kind matches 2 run function inc:vault/output/stone
execute if score @s inc.kind matches 3 run function inc:vault/output/iron
execute if score @s inc.kind matches 4 run function inc:vault/output/gold
execute if score @s inc.kind matches 5 run function inc:vault/output/diamond
execute if score @s inc.kind matches 6 run function inc:vault/output/netherite
execute if score @s inc.kind matches 7 run function inc:vault/output/coal
execute if score @s inc.kind matches 8 run function inc:vault/output/copper
execute if score @s inc.kind matches 9 run function inc:vault/output/redstone
execute if score @s inc.kind matches 10 run function inc:vault/output/lapis
execute if score @s inc.kind matches 11 run function inc:vault/output/emerald
execute if score @s inc.kind matches 12 run function inc:vault/output/obsidian
execute if score @s inc.kind matches 13 run function inc:vault/output/quartz
execute if score @s inc.kind matches 14 run function inc:vault/output/glowstone
execute if score @s inc.kind matches 15 run function inc:vault/output/magma
execute if score @s inc.kind matches 16 run function inc:vault/output/sea_lantern
execute if score @s inc.kind matches 17 run function inc:vault/output/blue_ice
execute if score @s inc.kind matches 18 run function inc:vault/output/wool
execute if score @s inc.kind matches 19 run function inc:vault/output/string
execute if score @s inc.kind matches 20 run function inc:vault/output/slime
execute if score @s inc.kind matches 21 run function inc:vault/output/spruce
execute if score @s inc.kind matches 22 run function inc:vault/output/birch
execute if score @s inc.kind matches 23 run function inc:vault/output/jungle
execute if score @s inc.kind matches 24 run function inc:vault/output/acacia
execute if score @s inc.kind matches 25 run function inc:vault/output/dark_oak
execute if score @s inc.kind matches 26 run function inc:vault/output/mangrove
execute if score @s inc.kind matches 27 run function inc:vault/output/cherry
execute if score @s inc.kind matches 28 run function inc:vault/output/pale_oak
execute if score @s inc.kind matches 29 run function inc:vault/output/poplar
execute if score @s inc.kind matches 30 run function inc:vault/output/crimson
execute if score @s inc.kind matches 31 run function inc:vault/output/warped
execute if score @s inc.kind matches 32 run function inc:vault/output/bamboo
function inc:vault/save
