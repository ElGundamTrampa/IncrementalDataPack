function inc:entity/id
execute if entity @s[tag=inc.type.dirt] run scoreboard players set @s inc.kind 0
execute if entity @s[tag=inc.type.oak] run scoreboard players set @s inc.kind 1
execute if entity @s[tag=inc.type.stone] run scoreboard players set @s inc.kind 2
execute if entity @s[tag=inc.type.iron] run scoreboard players set @s inc.kind 3
execute if entity @s[tag=inc.type.gold] run scoreboard players set @s inc.kind 4
execute if entity @s[tag=inc.type.diamond] run scoreboard players set @s inc.kind 5
execute if entity @s[tag=inc.type.netherite] run scoreboard players set @s inc.kind 6
execute if entity @s[tag=inc.type.coal] run scoreboard players set @s inc.kind 7
execute if entity @s[tag=inc.type.copper] run scoreboard players set @s inc.kind 8
execute if entity @s[tag=inc.type.redstone] run scoreboard players set @s inc.kind 9
execute if entity @s[tag=inc.type.lapis] run scoreboard players set @s inc.kind 10
execute if entity @s[tag=inc.type.emerald] run scoreboard players set @s inc.kind 11
execute if entity @s[tag=inc.type.obsidian] run scoreboard players set @s inc.kind 12
execute if entity @s[tag=inc.type.quartz] run scoreboard players set @s inc.kind 13
execute if entity @s[tag=inc.type.glowstone] run scoreboard players set @s inc.kind 14
execute if entity @s[tag=inc.type.magma] run scoreboard players set @s inc.kind 15
execute if entity @s[tag=inc.type.sea_lantern] run scoreboard players set @s inc.kind 16
execute if entity @s[tag=inc.type.blue_ice] run scoreboard players set @s inc.kind 17
execute if entity @s[tag=inc.type.wool] run scoreboard players set @s inc.kind 18
execute if entity @s[tag=inc.type.string] run scoreboard players set @s inc.kind 19
execute if entity @s[tag=inc.type.slime] run scoreboard players set @s inc.kind 20
execute if entity @s[tag=inc.type.spruce] run scoreboard players set @s inc.kind 21
execute if entity @s[tag=inc.type.birch] run scoreboard players set @s inc.kind 22
execute if entity @s[tag=inc.type.jungle] run scoreboard players set @s inc.kind 23
execute if entity @s[tag=inc.type.acacia] run scoreboard players set @s inc.kind 24
execute if entity @s[tag=inc.type.dark_oak] run scoreboard players set @s inc.kind 25
execute if entity @s[tag=inc.type.mangrove] run scoreboard players set @s inc.kind 26
execute if entity @s[tag=inc.type.cherry] run scoreboard players set @s inc.kind 27
execute if entity @s[tag=inc.type.pale_oak] run scoreboard players set @s inc.kind 28
execute if entity @s[tag=inc.type.poplar] run scoreboard players set @s inc.kind 29
execute if entity @s[tag=inc.type.crimson] run scoreboard players set @s inc.kind 30
execute if entity @s[tag=inc.type.warped] run scoreboard players set @s inc.kind 31
execute if entity @s[tag=inc.type.bamboo] run scoreboard players set @s inc.kind 32
execute if entity @s[tag=inc.type.sand] run scoreboard players set @s inc.kind 33
execute if entity @s[tag=inc.type.soul_sand] run scoreboard players set @s inc.kind 34
execute if entity @s[tag=inc.type.blaze_rod] run scoreboard players set @s inc.kind 35
execute if entity @s[tag=inc.type.wither_skull] run scoreboard players set @s inc.kind 36
execute if block ~ ~ ~ #inc:chests align xyz positioned ~0.5 ~1 ~0.5 run return run function inc:gen/place
execute if block ~ ~-1 ~ #inc:chests align xyz positioned ~0.5 ~ ~0.5 run return run function inc:gen/place
function inc:gen/refund
