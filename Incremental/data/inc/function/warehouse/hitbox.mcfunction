tag @s add inc.storage_part
scoreboard players operation @s inc.owner = #owner inc.tmp
scoreboard players operation @s inc.kind = #kind inc.tmp
tag @s add inc.storage
data merge entity @s {width:1.0f,height:1.0f,response:1b}
