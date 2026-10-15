execute unless block ~ ~ ~ minecraft:air run return run function inc:gen/refund
tp @s ~ ~ ~
tag @s remove inc.new.gen
tag @s add inc.gen
setblock ~ ~ ~ minecraft:glass
scoreboard players operation #id inc.tmp = @s inc.id
execute if score @s inc.kind matches 0 run function inc:gen/setup/dirt
execute if score @s inc.kind matches 1 run function inc:gen/setup/oak
execute if score @s inc.kind matches 2 run function inc:gen/setup/stone
execute if score @s inc.kind matches 3 run function inc:gen/setup/iron
execute if score @s inc.kind matches 4 run function inc:gen/setup/gold
execute if score @s inc.kind matches 5 run function inc:gen/setup/diamond
execute if score @s inc.kind matches 6 run function inc:gen/setup/netherite
execute if score @s inc.kind matches 7 run function inc:gen/setup/coal
execute if score @s inc.kind matches 8 run function inc:gen/setup/copper
execute if score @s inc.kind matches 9 run function inc:gen/setup/redstone
execute if score @s inc.kind matches 10 run function inc:gen/setup/lapis
execute if score @s inc.kind matches 11 run function inc:gen/setup/emerald
execute if score @s inc.kind matches 12 run function inc:gen/setup/obsidian
execute if score @s inc.kind matches 13 run function inc:gen/setup/quartz
execute if score @s inc.kind matches 14 run function inc:gen/setup/glowstone
execute if score @s inc.kind matches 15 run function inc:gen/setup/magma
execute if score @s inc.kind matches 16 run function inc:gen/setup/sea_lantern
execute if score @s inc.kind matches 17 run function inc:gen/setup/blue_ice
execute if score @s inc.kind matches 18 run function inc:gen/setup/wool
execute if score @s inc.kind matches 19 run function inc:gen/setup/string
execute if score @s inc.kind matches 20 run function inc:gen/setup/slime
execute if score @s inc.kind matches 21 run function inc:gen/setup/spruce
execute if score @s inc.kind matches 22 run function inc:gen/setup/birch
execute if score @s inc.kind matches 23 run function inc:gen/setup/jungle
execute if score @s inc.kind matches 24 run function inc:gen/setup/acacia
execute if score @s inc.kind matches 25 run function inc:gen/setup/dark_oak
execute if score @s inc.kind matches 26 run function inc:gen/setup/mangrove
execute if score @s inc.kind matches 27 run function inc:gen/setup/cherry
execute if score @s inc.kind matches 28 run function inc:gen/setup/pale_oak
execute if score @s inc.kind matches 29 run function inc:gen/setup/poplar
execute if score @s inc.kind matches 30 run function inc:gen/setup/crimson
execute if score @s inc.kind matches 31 run function inc:gen/setup/warped
execute if score @s inc.kind matches 32 run function inc:gen/setup/bamboo
execute if score @s inc.kind matches 33 run function inc:gen/setup/sand
execute if score @s inc.kind matches 34 run function inc:gen/setup/soul_sand
execute if score @s inc.kind matches 35 run function inc:gen/setup/blaze_rod
execute if score @s inc.kind matches 36 run function inc:gen/setup/wither_skull
