execute unless block ~ ~ ~ minecraft:chest run return run function inc:vault/break
function inc:vault/reposition_label
function inc:vault/collect
execute store result storage inc:runtime total int 1 run scoreboard players get @s inc.buf
scoreboard players operation @s inc.amount = @s inc.buf
scoreboard players operation @s inc.amount < @s inc.stack
execute if score @s inc.amount matches 1.. unless items block ~ ~ ~ container.0 * run function inc:vault/fill
function inc:vault/label with storage inc:runtime
function inc:vault/save
