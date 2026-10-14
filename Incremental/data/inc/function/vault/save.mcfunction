execute store result storage inc:runtime id int 1 run scoreboard players get @s inc.id
execute store result storage inc:runtime amount int 1 run scoreboard players get @s inc.buf
execute store result storage inc:runtime kind int 1 run scoreboard players get @s inc.kind
function inc:vault/save_values with storage inc:runtime
