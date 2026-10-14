scoreboard players set #clock inc.sys 0
execute in minecraft:overworld as @e[type=minecraft:armor_stand,tag=inc.gen] at @s run function inc:gen/tick
execute in minecraft:the_nether as @e[type=minecraft:armor_stand,tag=inc.gen] at @s run function inc:gen/tick
execute in minecraft:the_end as @e[type=minecraft:armor_stand,tag=inc.gen] at @s run function inc:gen/tick
execute in minecraft:overworld as @e[type=minecraft:armor_stand,tag=inc.vault] at @s run function inc:vault/tick
execute in minecraft:the_nether as @e[type=minecraft:armor_stand,tag=inc.vault] at @s run function inc:vault/tick
execute in minecraft:the_end as @e[type=minecraft:armor_stand,tag=inc.vault] at @s run function inc:vault/tick
execute in minecraft:overworld run kill @e[tag=inc.storage_part]
execute in minecraft:the_nether run kill @e[tag=inc.storage_part]
execute in minecraft:the_end run kill @e[tag=inc.storage_part]
