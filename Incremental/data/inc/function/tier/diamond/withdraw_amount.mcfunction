$execute store success score @s inc.tmp run give @s minecraft:diamond $(amount)
execute if score @s inc.tmp matches 1 run scoreboard players operation @s inc.bank5 -= @s inc.amount
tellraw @s [{"text":"Retirada solicitada: ","color":"aqua"},{"score":{"name":"@s","objective":"inc.amount"}},{"text":" de Diamante. ","color":"white"},{"text":"[Menú]","color":"green","click_event":{"action":"run_command","command":"/trigger inc.ui set 1"}}]
