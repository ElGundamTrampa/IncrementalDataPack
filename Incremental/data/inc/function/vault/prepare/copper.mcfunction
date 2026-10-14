execute store result storage inc:runtime amount int 1 run scoreboard players get @s inc.amount
execute if score @s inc.amount matches 1.. run function inc:vault/fill/copper with storage inc:runtime
