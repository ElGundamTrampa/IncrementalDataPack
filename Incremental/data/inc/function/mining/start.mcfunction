scoreboard players set @s inc.tmp 1
execute if score @s inc.mine matches 1.. store success score @s inc.tmp run attribute @s minecraft:block_break_speed modifier value get inc:stone_speed
execute if score @s inc.tmp matches 0 run scoreboard players set @s inc.mine 0
scoreboard players set @s inc.aim 0
scoreboard players set @s inc.trace 46
execute anchored eyes positioned ^ ^ ^ run function inc:mining/ray
execute unless score @s inc.mine = @s inc.aim run function inc:mining/apply
