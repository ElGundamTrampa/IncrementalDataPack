execute as @e[type=minecraft:armor_stand,tag=inc.vault,scores={inc.kind=1},distance=..8,sort=nearest,limit=1] at @s if block ~ ~ ~ minecraft:chest run function inc:vault/tick
tellraw @s {"text":"Necesitas 256 de minecraft:oak_log entre tu inventario y un cofre profundo cercano.","color":"red"}
