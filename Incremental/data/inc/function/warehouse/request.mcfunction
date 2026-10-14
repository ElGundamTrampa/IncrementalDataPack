scoreboard players operation #owner inc.tmp = @s inc.id
scoreboard players operation #kind inc.tmp = @s inc.sel
execute at @s positioned ^ ^ ^2 align xyz if block ~ ~ ~ minecraft:air if block ~ ~1 ~ minecraft:air run return run function inc:warehouse/place
tellraw @s [{"text":"Busca dos bloques de aire delante de ti para colocar el almacén.","color":"yellow"}]
