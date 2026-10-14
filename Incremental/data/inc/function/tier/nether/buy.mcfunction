execute if score @s inc.qty6 matches 50.. run return run tellraw @s [{"text":"Límite: 50 generadores de este material.","color":"yellow"}]
execute unless score @s inc.bank5 >= @s inc.price6 run return run tellraw @s [{"text":"Necesitas más Diamante en el almacén.","color":"red"}]
scoreboard players operation @s inc.bank5 -= @s inc.price6
scoreboard players add @s inc.qty6 1
scoreboard players operation @s inc.tmp = @s inc.price6
scoreboard players operation @s inc.tmp /= #four inc.sys
scoreboard players operation @s inc.price6 += @s inc.tmp
scoreboard players operation @s inc.price6 < #cap inc.sys
scoreboard players operation @s inc.rate6 = @s inc.qty6
scoreboard players operation @s inc.rate6 *= @s inc.pow6
scoreboard players set @s inc.sel 6
tellraw @s [{"text":"Generador de Netherita comprado. ","color":"green"},{"text":"[Menú]","color":"green","click_event":{"action":"run_command","command":"/trigger inc.ui set 1"}}]
