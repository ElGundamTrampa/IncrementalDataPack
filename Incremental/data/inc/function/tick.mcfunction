execute as @a[tag=!inc.ready] run function inc:init
scoreboard players remove @a[scores={inc.cd=1..}] inc.cd 1
execute as @a[scores={inc.used=1..}] if items entity @s weapon.mainhand minecraft:carrot_on_a_stick[minecraft:custom_data~{inc_tool:1b}] run function inc:click
execute as @a[scores={inc.used=1..}] if items entity @s weapon.offhand minecraft:carrot_on_a_stick[minecraft:custom_data~{inc_tool:1b}] run function inc:click
scoreboard players set @a inc.used 0
execute as @a unless score @s inc.ui matches 0 run function inc:dispatch
scoreboard players enable @a inc.ui
scoreboard players add #clock inc.sys 1
execute if score #clock inc.sys matches 20.. run function inc:second
execute in minecraft:overworld as @e[type=minecraft:interaction,tag=inc.storage] at @s if data entity @s interaction run function inc:warehouse/interact
execute in minecraft:the_nether as @e[type=minecraft:interaction,tag=inc.storage] at @s if data entity @s interaction run function inc:warehouse/interact
execute in minecraft:the_end as @e[type=minecraft:interaction,tag=inc.storage] at @s if data entity @s interaction run function inc:warehouse/interact
