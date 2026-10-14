scoreboard players operation #id inc.tmp = @s inc.id
execute as @e[type=minecraft:text_display,tag=inc.part,distance=..3] if score @s inc.id = #id inc.tmp run tp @s ~ ~0.3 ~-0.7
