clear @s minecraft:carrot_on_a_stick[minecraft:custom_data~{inc_tool:1b}]
scoreboard players set @s inc.shop 0
scoreboard players set @s inc.mine 0
tag @s add inc.physical
loot give @s loot inc:tokens/gen/dirt
loot give @s loot inc:tokens/vault
give @s minecraft:chest 1
tellraw @s {"text":"Coloca el cofre profundo en el suelo y el generador de tierra sobre él, agachado. Tienda: /trigger inc.shop set 1","color":"green"}
