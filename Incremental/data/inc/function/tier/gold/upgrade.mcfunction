execute if score @s inc.qty4 matches 0 run return run tellraw @s [{"text":"Primero compra este generador.","color":"red"}]
execute if score @s inc.level4 matches 10.. run return run tellraw @s [{"text":"Mejora máxima: nivel 10.","color":"yellow"}]
execute unless score @s inc.bank4 >= @s inc.up4 run return run tellraw @s [{"text":"No tienes suficiente Oro guardado.","color":"red"}]
scoreboard players operation @s inc.bank4 -= @s inc.up4
scoreboard players operation @s inc.up4 += @s inc.up4
scoreboard players operation @s inc.pow4 += @s inc.pow4
scoreboard players add @s inc.level4 1
scoreboard players operation @s inc.rate4 = @s inc.qty4
scoreboard players operation @s inc.rate4 *= @s inc.pow4
tellraw @s [{"text":"Producción y clic de Oro duplicados. ","color":"green"},{"text":"[Menú]","color":"green","click_event":{"action":"run_command","command":"/trigger inc.ui set 1"}}]
