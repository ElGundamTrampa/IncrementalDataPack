$execute store result score @s inc.amount run data get block ~ ~ ~ Items[{Slot:$(slot)b}].count
scoreboard players operation @s inc.left = @s inc.amount
scoreboard players operation @s inc.space = #cap inc.sys
scoreboard players operation @s inc.space -= @s inc.buf
scoreboard players operation @s inc.amount < @s inc.space
scoreboard players operation @s inc.left -= @s inc.amount
scoreboard players operation @s inc.buf += @s inc.amount
$execute if score @s inc.left matches 0 run return run item replace block ~ ~ ~ container.$(slot) with minecraft:air
execute store result storage inc:runtime left int 1 run scoreboard players get @s inc.left
function inc:vault/left with storage inc:runtime
