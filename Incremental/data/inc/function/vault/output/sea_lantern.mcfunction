scoreboard players operation @s inc.amount = @s inc.buf
scoreboard players set @s inc.tmp 64
scoreboard players operation @s inc.amount < @s inc.tmp
execute unless items block ~ ~ ~ container.0 * run function inc:vault/prepare/sea_lantern
function inc:vault/label/sea_lantern with storage inc:runtime
