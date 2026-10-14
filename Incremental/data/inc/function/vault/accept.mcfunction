execute if score @s inc.kind matches -1 run scoreboard players operation @s inc.kind = #kind inc.tmp
execute unless score @s inc.kind = #kind inc.tmp run return 0
execute if score @s inc.buf < #cap inc.sys run scoreboard players add @s inc.buf 1
