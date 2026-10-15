execute unless data storage inc:meta {physical:2} run function inc:setup
execute unless data storage inc:meta {universal:1b} run function inc:vault/bootstrap
scoreboard players set #clock inc.sys 0
scoreboard players set #cap inc.sys 1000000000
execute in minecraft:overworld run kill @e[tag=inc.storage_part]
execute in minecraft:the_nether run kill @e[tag=inc.storage_part]
execute in minecraft:the_end run kill @e[tag=inc.storage_part]
execute in minecraft:overworld as @e[type=minecraft:armor_stand,tag=inc.vault] at @s run function inc:vault/reposition_label
execute in minecraft:the_nether as @e[type=minecraft:armor_stand,tag=inc.vault] at @s run function inc:vault/reposition_label
execute in minecraft:the_end as @e[type=minecraft:armor_stand,tag=inc.vault] at @s run function inc:vault/reposition_label
