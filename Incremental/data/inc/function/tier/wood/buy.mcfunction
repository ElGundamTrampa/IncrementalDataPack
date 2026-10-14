execute if score @s inc.qty1 matches 50.. run return run tellraw @s [{"text":"Límite: 50 generadores de este material.","color":"yellow"}]
execute unless score @s inc.bank0 >= @s inc.price1 run return run tellraw @s [{"text":"Necesitas más Tierra en el almacén.","color":"red"}]
scoreboard players operation @s inc.bank0 -= @s inc.price1
scoreboard players add @s inc.qty1 1
scoreboard players operation @s inc.tmp = @s inc.price1
scoreboard players operation @s inc.tmp /= #four inc.sys
scoreboard players operation @s inc.price1 += @s inc.tmp
scoreboard players operation @s inc.price1 < #cap inc.sys
scoreboard players operation @s inc.rate1 = @s inc.qty1
scoreboard players operation @s inc.rate1 *= @s inc.pow1
scoreboard players set @s inc.sel 1
tellraw @s [{"text":"Generador de Madera comprado. ","color":"green"},{"text":"[Menú]","color":"green","click_event":{"action":"run_command","command":"/trigger inc.ui set 1"}}]
