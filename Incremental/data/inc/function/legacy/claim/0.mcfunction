scoreboard players operation @s inc.amount = @s inc.bank0
scoreboard players set @s inc.tmp 64
scoreboard players operation @s inc.amount < @s inc.tmp
execute store result storage inc:runtime amount int 1 run scoreboard players get @s inc.amount
function inc:legacy/give/0 with storage inc:runtime
