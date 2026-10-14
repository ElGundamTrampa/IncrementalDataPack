execute if score @s inc.qty1 matches 0 run return run tellraw @s [{"text":"Primero compra este generador.","color":"red"}]
execute if score @s inc.level1 matches 10.. run return run tellraw @s [{"text":"Mejora máxima: nivel 10.","color":"yellow"}]
execute unless score @s inc.bank1 >= @s inc.up1 run return run tellraw @s [{"text":"No tienes suficiente Madera guardado.","color":"red"}]
scoreboard players operation @s inc.bank1 -= @s inc.up1
scoreboard players operation @s inc.up1 += @s inc.up1
scoreboard players operation @s inc.pow1 += @s inc.pow1
scoreboard players add @s inc.level1 1
scoreboard players operation @s inc.rate1 = @s inc.qty1
scoreboard players operation @s inc.rate1 *= @s inc.pow1
tellraw @s [{"text":"Producción y clic de Madera duplicados. ","color":"green"},{"text":"[Menú]","color":"green","click_event":{"action":"run_command","command":"/trigger inc.ui set 1"}}]
