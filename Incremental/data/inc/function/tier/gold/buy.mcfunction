execute if score @s inc.qty4 matches 50.. run return run tellraw @s [{"text":"Límite: 50 generadores de este material.","color":"yellow"}]
execute unless score @s inc.bank3 >= @s inc.price4 run return run tellraw @s [{"text":"Necesitas más Hierro en el almacén.","color":"red"}]
scoreboard players operation @s inc.bank3 -= @s inc.price4
scoreboard players add @s inc.qty4 1
scoreboard players operation @s inc.tmp = @s inc.price4
scoreboard players operation @s inc.tmp /= #four inc.sys
scoreboard players operation @s inc.price4 += @s inc.tmp
scoreboard players operation @s inc.price4 < #cap inc.sys
scoreboard players operation @s inc.rate4 = @s inc.qty4
scoreboard players operation @s inc.rate4 *= @s inc.pow4
scoreboard players set @s inc.sel 4
tellraw @s [{"text":"Generador de Oro comprado. ","color":"green"},{"text":"[Menú]","color":"green","click_event":{"action":"run_command","command":"/trigger inc.ui set 1"}}]
