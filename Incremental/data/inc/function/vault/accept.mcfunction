function inc:vault/collect
execute unless data storage inc:runtime prototype run function inc:vault/bind_generated
data modify storage inc:runtime reference set from storage inc:runtime prototype
execute store success score @s inc.tmp run data modify storage inc:runtime reference set from storage inc:runtime generated
execute if score @s inc.tmp matches 1 run return 0
execute if score @s inc.buf < #cap inc.sys run scoreboard players add @s inc.buf 1
