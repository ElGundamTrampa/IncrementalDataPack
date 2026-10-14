execute if score @s inc.bank1 matches 0 run return run tellraw @s [{"text":"El almacén está vacío.","color":"yellow"}]
scoreboard players operation @s inc.amount = @s inc.bank1
scoreboard players set @s inc.tmp 64
scoreboard players operation @s inc.amount < @s inc.tmp
execute store result storage inc:runtime amount int 1 run scoreboard players get @s inc.amount
function inc:tier/wood/withdraw_amount with storage inc:runtime
