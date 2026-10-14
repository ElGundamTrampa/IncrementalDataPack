execute if score @s inc.mine matches 1.. run attribute @s minecraft:block_break_speed modifier remove inc:stone_speed
scoreboard players operation @s inc.mine = @s inc.aim
execute if score @s inc.aim matches 1 run attribute @s minecraft:block_break_speed modifier add inc:stone_speed -0.1666666667 add_multiplied_total
execute if score @s inc.aim matches 3 run attribute @s minecraft:block_break_speed modifier add inc:stone_speed 0.3333333333 add_multiplied_total
execute if score @s inc.aim matches 4 run attribute @s minecraft:block_break_speed modifier add inc:stone_speed 1.0000000000 add_multiplied_total
execute if score @s inc.aim matches 5 run attribute @s minecraft:block_break_speed modifier add inc:stone_speed 1.3333333333 add_multiplied_total
