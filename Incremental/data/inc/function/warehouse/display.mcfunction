tag @s add inc.storage_part
scoreboard players operation @s inc.owner = #owner inc.tmp
scoreboard players operation @s inc.kind = #kind inc.tmp
data merge entity @s {block_state:{Name:"minecraft:barrel",Properties:{facing:"up",open:"false"}}}
