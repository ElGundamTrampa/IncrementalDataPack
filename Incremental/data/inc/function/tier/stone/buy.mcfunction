execute if score @s inc.qty2 matches 50.. run return run tellraw @s [{"text":"Límite: 50 generadores de este material.","color":"yellow"}]
execute unless score @s inc.bank1 >= @s inc.price2 run return run tellraw @s [{"text":"Necesitas más Madera en el almacén.","color":"red"}]
scoreboard players operation @s inc.bank1 -= @s inc.price2
scoreboard players add @s inc.qty2 1
scoreboard players operation @s inc.tmp = @s inc.price2
scoreboard players operation @s inc.tmp /= #four inc.sys
scoreboard players operation @s inc.price2 += @s inc.tmp
scoreboard players operation @s inc.price2 < #cap inc.sys
scoreboard players operation @s inc.rate2 = @s inc.qty2
scoreboard players operation @s inc.rate2 *= @s inc.pow2
scoreboard players set @s inc.sel 2
tellraw @s [{"text":"Generador de Piedra comprado. ","color":"green"},{"text":"[Menú]","color":"green","click_event":{"action":"run_command","command":"/trigger inc.ui set 1"}}]
