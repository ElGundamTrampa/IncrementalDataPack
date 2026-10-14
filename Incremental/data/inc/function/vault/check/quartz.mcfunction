data modify storage inc:runtime reference set value {id:"minecraft:quartz"}
execute store success score @s inc.tmp run data modify storage inc:runtime reference set from storage inc:runtime probe
execute if score @s inc.tmp matches 1 run return run function inc:vault/eject with storage inc:runtime
execute if score @s inc.kind matches -1 run scoreboard players set @s inc.kind 13
execute unless score @s inc.kind matches 13 run return run function inc:vault/eject with storage inc:runtime
function inc:vault/deposit with storage inc:runtime
