execute as @a[tag=!inc.physical] run function inc:init
execute as @a at @s unless score @s inc.shop matches 0 run function inc:shop/dispatch
scoreboard players enable @a inc.shop
execute as @a[tag=inc.physical,gamemode=!spectator] at @s run function inc:mining/start
execute as @a[tag=inc.physical,gamemode=spectator] run function inc:mining/clear
execute in minecraft:overworld as @e[type=minecraft:armor_stand,tag=inc.new.gen] at @s run function inc:gen/new
execute in minecraft:the_nether as @e[type=minecraft:armor_stand,tag=inc.new.gen] at @s run function inc:gen/new
execute in minecraft:the_end as @e[type=minecraft:armor_stand,tag=inc.new.gen] at @s run function inc:gen/new
execute in minecraft:overworld as @e[type=minecraft:armor_stand,tag=inc.new.vault] at @s run function inc:vault/new
execute in minecraft:the_nether as @e[type=minecraft:armor_stand,tag=inc.new.vault] at @s run function inc:vault/new
execute in minecraft:the_end as @e[type=minecraft:armor_stand,tag=inc.new.vault] at @s run function inc:vault/new
scoreboard players add #clock inc.sys 1
execute if score #clock inc.sys matches 20.. run function inc:second
