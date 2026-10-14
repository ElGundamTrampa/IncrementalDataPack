execute if score @s inc.cd matches 1.. run return 0
scoreboard players set @s inc.cd 5
execute if score @s inc.sel matches 0 run function inc:tier/dirt/click
execute if score @s inc.sel matches 1 run function inc:tier/wood/click
execute if score @s inc.sel matches 2 run function inc:tier/stone/click
execute if score @s inc.sel matches 3 run function inc:tier/iron/click
execute if score @s inc.sel matches 4 run function inc:tier/gold/click
execute if score @s inc.sel matches 5 run function inc:tier/diamond/click
execute if score @s inc.sel matches 6 run function inc:tier/nether/click
