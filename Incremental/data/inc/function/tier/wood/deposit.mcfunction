execute store result score @s inc.amount run clear @s minecraft:oak_log 0
scoreboard players operation @s inc.space = #cap inc.sys
scoreboard players operation @s inc.space -= @s inc.bank1
scoreboard players operation @s inc.amount < @s inc.space
execute if score @s inc.amount matches 0 run return run tellraw @s [{"text":"No hay objetos que depositar o el almacén está lleno.","color":"yellow"}]
execute store result storage inc:runtime amount int 1 run scoreboard players get @s inc.amount
function inc:tier/wood/deposit_amount with storage inc:runtime
scoreboard players operation @s inc.bank1 += @s inc.amount
tellraw @s [{"text":"Depositado: ","color":"aqua"},{"score":{"name":"@s","objective":"inc.amount"}},{"text":" de Madera. ","color":"white"},{"text":"[Menú]","color":"green","click_event":{"action":"run_command","command":"/trigger inc.ui set 1"}}]
