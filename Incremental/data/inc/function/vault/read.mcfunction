execute store result storage inc:runtime id int 1 run scoreboard players get @s inc.id
data remove storage inc:runtime prototype
scoreboard players set @s inc.stack 64
function inc:vault/read_state with storage inc:runtime
