execute if score @s inc.qty3 matches 0 run return run tellraw @s [{"text":"Primero compra este generador.","color":"red"}]
execute if score @s inc.level3 matches 10.. run return run tellraw @s [{"text":"Mejora máxima: nivel 10.","color":"yellow"}]
execute unless score @s inc.bank3 >= @s inc.up3 run return run tellraw @s [{"text":"No tienes suficiente Hierro guardado.","color":"red"}]
scoreboard players operation @s inc.bank3 -= @s inc.up3
scoreboard players operation @s inc.up3 += @s inc.up3
scoreboard players operation @s inc.pow3 += @s inc.pow3
scoreboard players add @s inc.level3 1
scoreboard players operation @s inc.rate3 = @s inc.qty3
scoreboard players operation @s inc.rate3 *= @s inc.pow3
tellraw @s [{"text":"Producción y clic de Hierro duplicados. ","color":"green"},{"text":"[Menú]","color":"green","click_event":{"action":"run_command","command":"/trigger inc.ui set 1"}}]
