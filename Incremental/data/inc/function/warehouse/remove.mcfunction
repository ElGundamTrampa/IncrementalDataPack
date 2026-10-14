scoreboard players operation #owner inc.tmp = @s inc.id
execute at @s as @e[tag=inc.storage_part,distance=..32] if score @s inc.owner = #owner inc.tmp run kill @s
tellraw @s [{"text":"Almacenes cercanos recogidos. Los recursos se conservan.","color":"green"}]
