execute if score @s inc.qty5 matches 50.. run return run tellraw @s [{"text":"Límite: 50 generadores de este material.","color":"yellow"}]
execute unless score @s inc.bank4 >= @s inc.price5 run return run tellraw @s [{"text":"Necesitas más Oro en el almacén.","color":"red"}]
scoreboard players operation @s inc.bank4 -= @s inc.price5
scoreboard players add @s inc.qty5 1
scoreboard players operation @s inc.tmp = @s inc.price5
scoreboard players operation @s inc.tmp /= #four inc.sys
scoreboard players operation @s inc.price5 += @s inc.tmp
scoreboard players operation @s inc.price5 < #cap inc.sys
scoreboard players operation @s inc.rate5 = @s inc.qty5
scoreboard players operation @s inc.rate5 *= @s inc.pow5
scoreboard players set @s inc.sel 5
tellraw @s [{"text":"Generador de Diamante comprado. ","color":"green"},{"text":"[Menú]","color":"green","click_event":{"action":"run_command","command":"/trigger inc.ui set 1"}}]
