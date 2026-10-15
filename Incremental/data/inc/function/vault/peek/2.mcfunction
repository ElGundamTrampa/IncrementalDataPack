data modify storage inc:runtime probe set from block ~ ~ ~ Items[{Slot:2b}]
data remove storage inc:runtime probe.Slot
data remove storage inc:runtime probe.count
scoreboard players set @s inc.tmp 0
execute store result score @s inc.tmp run data get storage inc:runtime probe.components
execute if score @s inc.tmp matches 0 run data remove storage inc:runtime probe.components
data modify storage inc:runtime reference set from storage inc:runtime prototype
execute store success score @s inc.tmp run data modify storage inc:runtime reference set from storage inc:runtime probe
execute if score @s inc.tmp matches 0 run scoreboard players set #old inc.tmp 1
