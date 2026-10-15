scoreboard players operation #id inc.tmp = @s inc.id
execute if block ~ ~ ~ minecraft:chest[facing=north] as @e[type=minecraft:text_display,tag=inc.part,distance=..3] if score @s inc.id = #id inc.tmp run tp @s ~ ~0.3 ~-0.7
execute if block ~ ~ ~ minecraft:chest[facing=south] as @e[type=minecraft:text_display,tag=inc.part,distance=..3] if score @s inc.id = #id inc.tmp run tp @s ~ ~0.3 ~0.7
execute if block ~ ~ ~ minecraft:chest[facing=east] as @e[type=minecraft:text_display,tag=inc.part,distance=..3] if score @s inc.id = #id inc.tmp run tp @s ~0.7 ~0.3 ~
execute if block ~ ~ ~ minecraft:chest[facing=west] as @e[type=minecraft:text_display,tag=inc.part,distance=..3] if score @s inc.id = #id inc.tmp run tp @s ~-0.7 ~0.3 ~
