data modify storage inc:runtime reference set value {id:"minecraft:gold_ingot"}
execute store success score @s inc.tmp run data modify storage inc:runtime reference set from storage inc:runtime probe
execute if score @s inc.tmp matches 1 run return run function inc:vault/eject with storage inc:runtime
execute if score @s inc.kind matches -1 run scoreboard players set @s inc.kind 4
execute unless score @s inc.kind matches 4 run return run function inc:vault/eject with storage inc:runtime
function inc:vault/deposit with storage inc:runtime
