execute if block ~ ~ ~ #inc:mining/g1 run return run scoreboard players set @s inc.aim 1
execute if block ~ ~ ~ #inc:mining/g2 run return run scoreboard players set @s inc.aim 0
execute if block ~ ~ ~ #inc:mining/g3 run return run scoreboard players set @s inc.aim 3
execute if block ~ ~ ~ #inc:mining/g4 run return run scoreboard players set @s inc.aim 4
execute if block ~ ~ ~ #inc:mining/g5 run return run scoreboard players set @s inc.aim 5
execute unless block ~ ~ ~ #inc:mining/pass_through run return 0
scoreboard players remove @s inc.trace 1
execute if score @s inc.trace matches 1.. positioned ^ ^ ^0.1 run function inc:mining/ray
