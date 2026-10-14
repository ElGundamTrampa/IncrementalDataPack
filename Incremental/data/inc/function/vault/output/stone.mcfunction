scoreboard players operation @s inc.amount = @s inc.buf
scoreboard players set @s inc.tmp 64
scoreboard players operation @s inc.amount < @s inc.tmp
execute unless items block ~ ~ ~ container.0 * run function inc:vault/prepare/stone
function inc:vault/label/stone with storage inc:runtime
