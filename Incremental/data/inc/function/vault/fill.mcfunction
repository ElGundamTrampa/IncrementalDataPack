data modify storage inc:runtime outgoing set from storage inc:runtime prototype
execute store result storage inc:runtime outgoing.count int 1 run scoreboard players get @s inc.amount
data modify storage inc:runtime outgoing.Slot set value 0b
execute store success score @s inc.tmp run data modify block ~ ~ ~ Items append from storage inc:runtime outgoing
execute if score @s inc.tmp matches 1 run scoreboard players operation @s inc.buf -= @s inc.amount
