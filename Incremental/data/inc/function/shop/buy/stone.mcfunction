execute store result score @s inc.amount run clear @s minecraft:oak_log 0
scoreboard players set #reserve inc.tmp 0
execute as @e[type=minecraft:armor_stand,tag=inc.vault,scores={inc.kind=1},distance=..8,sort=nearest,limit=1] at @s if block ~ ~ ~ minecraft:chest run function inc:vault/collect
execute as @e[type=minecraft:armor_stand,tag=inc.vault,scores={inc.kind=1},distance=..8,sort=nearest,limit=1] at @s if block ~ ~ ~ minecraft:chest run scoreboard players operation #reserve inc.tmp = @s inc.buf
scoreboard players operation #funds inc.tmp = @s inc.amount
scoreboard players operation #funds inc.tmp += #reserve inc.tmp
execute if score #funds inc.tmp matches ..511 run return run function inc:shop/buy/stone_fail
scoreboard players set @s inc.tmp 512
scoreboard players operation @s inc.amount < @s inc.tmp
execute store result storage inc:runtime amount int 1 run scoreboard players get @s inc.amount
execute if score @s inc.amount matches 1.. run function inc:shop/buy/stone_pay with storage inc:runtime
scoreboard players set #due inc.tmp 512
scoreboard players operation #due inc.tmp -= @s inc.amount
execute if score #due inc.tmp matches 1.. run scoreboard players operation @e[type=minecraft:armor_stand,tag=inc.vault,scores={inc.kind=1},distance=..8,sort=nearest,limit=1] inc.buf -= #due inc.tmp
execute as @e[type=minecraft:armor_stand,tag=inc.vault,scores={inc.kind=1},distance=..8,sort=nearest,limit=1] at @s if block ~ ~ ~ minecraft:chest run function inc:vault/tick
loot give @s loot inc:tokens/gen/stone
tellraw @s {"text":"Generador comprado. Colócalo sobre un cofre, agachado.","color":"green"}
