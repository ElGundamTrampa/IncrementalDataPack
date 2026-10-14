scoreboard players operation #id inc.tmp = @s inc.id
execute as @e[tag=inc.part,distance=..3] if score @s inc.id = #id inc.tmp run kill @s
