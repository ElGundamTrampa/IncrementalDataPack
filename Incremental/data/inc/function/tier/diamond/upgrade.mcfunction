execute if score @s inc.qty5 matches 0 run return run tellraw @s [{"text":"Primero compra este generador.","color":"red"}]
execute if score @s inc.level5 matches 10.. run return run tellraw @s [{"text":"Mejora máxima: nivel 10.","color":"yellow"}]
execute unless score @s inc.bank5 >= @s inc.up5 run return run tellraw @s [{"text":"No tienes suficiente Diamante guardado.","color":"red"}]
scoreboard players operation @s inc.bank5 -= @s inc.up5
scoreboard players operation @s inc.up5 += @s inc.up5
scoreboard players operation @s inc.pow5 += @s inc.pow5
scoreboard players add @s inc.level5 1
scoreboard players operation @s inc.rate5 = @s inc.qty5
scoreboard players operation @s inc.rate5 *= @s inc.pow5
tellraw @s [{"text":"Producción y clic de Diamante duplicados. ","color":"green"},{"text":"[Menú]","color":"green","click_event":{"action":"run_command","command":"/trigger inc.ui set 1"}}]
