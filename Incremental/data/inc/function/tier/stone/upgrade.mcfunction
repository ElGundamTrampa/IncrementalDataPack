execute if score @s inc.qty2 matches 0 run return run tellraw @s [{"text":"Primero compra este generador.","color":"red"}]
execute if score @s inc.level2 matches 10.. run return run tellraw @s [{"text":"Mejora máxima: nivel 10.","color":"yellow"}]
execute unless score @s inc.bank2 >= @s inc.up2 run return run tellraw @s [{"text":"No tienes suficiente Piedra guardado.","color":"red"}]
scoreboard players operation @s inc.bank2 -= @s inc.up2
scoreboard players operation @s inc.up2 += @s inc.up2
scoreboard players operation @s inc.pow2 += @s inc.pow2
scoreboard players add @s inc.level2 1
scoreboard players operation @s inc.rate2 = @s inc.qty2
scoreboard players operation @s inc.rate2 *= @s inc.pow2
tellraw @s [{"text":"Producción y clic de Piedra duplicados. ","color":"green"},{"text":"[Menú]","color":"green","click_event":{"action":"run_command","command":"/trigger inc.ui set 1"}}]
