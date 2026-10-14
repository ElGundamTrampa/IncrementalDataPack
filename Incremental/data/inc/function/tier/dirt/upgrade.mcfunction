execute if score @s inc.qty0 matches 0 run return run tellraw @s [{"text":"Primero compra este generador.","color":"red"}]
execute if score @s inc.level0 matches 10.. run return run tellraw @s [{"text":"Mejora máxima: nivel 10.","color":"yellow"}]
execute unless score @s inc.bank0 >= @s inc.up0 run return run tellraw @s [{"text":"No tienes suficiente Tierra guardado.","color":"red"}]
scoreboard players operation @s inc.bank0 -= @s inc.up0
scoreboard players operation @s inc.up0 += @s inc.up0
scoreboard players operation @s inc.pow0 += @s inc.pow0
scoreboard players add @s inc.level0 1
scoreboard players operation @s inc.rate0 = @s inc.qty0
scoreboard players operation @s inc.rate0 *= @s inc.pow0
tellraw @s [{"text":"Producción y clic de Tierra duplicados. ","color":"green"},{"text":"[Menú]","color":"green","click_event":{"action":"run_command","command":"/trigger inc.ui set 1"}}]
