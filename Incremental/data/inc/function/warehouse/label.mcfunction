tag @s add inc.storage_part
scoreboard players operation @s inc.owner = #owner inc.tmp
scoreboard players operation @s inc.kind = #kind inc.tmp
data merge entity @s {billboard:"center",background:0,shadow:1b}
execute if score @s inc.kind matches 0 run data merge entity @s {text:{"text":"Almacén de Tierra","color":"gold"}}
execute if score @s inc.kind matches 1 run data merge entity @s {text:{"text":"Almacén de Madera","color":"yellow"}}
execute if score @s inc.kind matches 2 run data merge entity @s {text:{"text":"Almacén de Piedra","color":"gray"}}
execute if score @s inc.kind matches 3 run data merge entity @s {text:{"text":"Almacén de Hierro","color":"white"}}
execute if score @s inc.kind matches 4 run data merge entity @s {text:{"text":"Almacén de Oro","color":"gold"}}
execute if score @s inc.kind matches 5 run data merge entity @s {text:{"text":"Almacén de Diamante","color":"aqua"}}
execute if score @s inc.kind matches 6 run data merge entity @s {text:{"text":"Almacén de Netherita","color":"dark_purple"}}
