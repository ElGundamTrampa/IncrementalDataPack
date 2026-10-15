scoreboard players set @s inc.stack 64
$execute if items block ~ ~ ~ container.$(slot) #inc:stack_1 run scoreboard players set @s inc.stack 1
$execute if items block ~ ~ ~ container.$(slot) #inc:stack_16 run scoreboard players set @s inc.stack 16
$execute if items block ~ ~ ~ container.$(slot) #inc:stack_64 run scoreboard players set @s inc.stack 64
execute if data storage inc:runtime probe.components."minecraft:max_stack_size" run execute store result score @s inc.stack run data get storage inc:runtime probe.components."minecraft:max_stack_size"
function inc:vault/bind
