$execute store success score @s inc.tmp run item replace block ~ ~ ~ container.0 with minecraft:pale_oak_log $(amount)
execute if score @s inc.tmp matches 1 run scoreboard players operation @s inc.buf -= @s inc.amount
