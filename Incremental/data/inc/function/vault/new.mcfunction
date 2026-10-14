execute store result score @s inc.tmp run data get entity @s DisabledSlots
execute unless block ~ ~ ~ minecraft:air run return run function inc:vault/refund_new
execute if score @s inc.tmp matches 1.. run return run function inc:vault/restore_start
function inc:entity/id
scoreboard players set @s inc.kind -1
scoreboard players set @s inc.buf 0
function inc:vault/setup
