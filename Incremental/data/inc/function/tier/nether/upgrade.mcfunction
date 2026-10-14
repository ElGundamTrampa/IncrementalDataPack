execute if score @s inc.qty6 matches 0 run return run tellraw @s [{"text":"Primero compra este generador.","color":"red"}]
execute if score @s inc.level6 matches 10.. run return run tellraw @s [{"text":"Mejora máxima: nivel 10.","color":"yellow"}]
execute unless score @s inc.bank6 >= @s inc.up6 run return run tellraw @s [{"text":"No tienes suficiente Netherita guardado.","color":"red"}]
scoreboard players operation @s inc.bank6 -= @s inc.up6
scoreboard players operation @s inc.up6 += @s inc.up6
scoreboard players operation @s inc.pow6 += @s inc.pow6
scoreboard players add @s inc.level6 1
scoreboard players operation @s inc.rate6 = @s inc.qty6
scoreboard players operation @s inc.rate6 *= @s inc.pow6
tellraw @s [{"text":"Producción y clic de Netherita duplicados. ","color":"green"},{"text":"[Menú]","color":"green","click_event":{"action":"run_command","command":"/trigger inc.ui set 1"}}]
