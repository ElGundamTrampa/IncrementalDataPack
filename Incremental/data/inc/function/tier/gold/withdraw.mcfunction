execute if score @s inc.bank4 matches 0 run return run tellraw @s [{"text":"El almacén está vacío.","color":"yellow"}]
scoreboard players operation @s inc.amount = @s inc.bank4
scoreboard players set @s inc.tmp 64
scoreboard players operation @s inc.amount < @s inc.tmp
execute store result storage inc:runtime amount int 1 run scoreboard players get @s inc.amount
function inc:tier/gold/withdraw_amount with storage inc:runtime
