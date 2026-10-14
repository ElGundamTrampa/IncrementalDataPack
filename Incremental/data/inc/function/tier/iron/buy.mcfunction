execute if score @s inc.qty3 matches 50.. run return run tellraw @s [{"text":"Límite: 50 generadores de este material.","color":"yellow"}]
execute unless score @s inc.bank2 >= @s inc.price3 run return run tellraw @s [{"text":"Necesitas más Piedra en el almacén.","color":"red"}]
scoreboard players operation @s inc.bank2 -= @s inc.price3
scoreboard players add @s inc.qty3 1
scoreboard players operation @s inc.tmp = @s inc.price3
scoreboard players operation @s inc.tmp /= #four inc.sys
scoreboard players operation @s inc.price3 += @s inc.tmp
scoreboard players operation @s inc.price3 < #cap inc.sys
scoreboard players operation @s inc.rate3 = @s inc.qty3
scoreboard players operation @s inc.rate3 *= @s inc.pow3
scoreboard players set @s inc.sel 3
tellraw @s [{"text":"Generador de Hierro comprado. ","color":"green"},{"text":"[Menú]","color":"green","click_event":{"action":"run_command","command":"/trigger inc.ui set 1"}}]
