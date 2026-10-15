data modify storage inc:runtime reference set value {id:"minecraft:dirt"}
execute store success score @s inc.tmp run data modify storage inc:runtime reference set from storage inc:runtime prototype
execute if score @s inc.tmp matches 0 run scoreboard players set @s inc.kind 0
