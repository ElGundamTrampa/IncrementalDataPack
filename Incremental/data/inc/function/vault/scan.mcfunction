execute unless data storage inc:runtime prototype run function inc:vault/bind_slot with storage inc:runtime
data modify storage inc:runtime reference set from storage inc:runtime prototype
execute store success score @s inc.tmp run data modify storage inc:runtime reference set from storage inc:runtime probe
execute if score @s inc.tmp matches 1 run return run function inc:vault/eject with storage inc:runtime
function inc:vault/deposit with storage inc:runtime
