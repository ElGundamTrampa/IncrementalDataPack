execute as @e[tag=inc.storage_part] if score @s inc.owner = #owner inc.tmp if score @s inc.kind = #kind inc.tmp run kill @s
execute summon minecraft:block_display run function inc:warehouse/display
execute positioned ~0.5 ~ ~0.5 summon minecraft:interaction run function inc:warehouse/hitbox
execute positioned ~0.5 ~1.15 ~0.5 summon minecraft:text_display run function inc:warehouse/label
tellraw @s [{"text":"Almacén colocado. Clic derecho para abrirlo. ","color":"green"},{"text":"[Menú]","color":"green","click_event":{"action":"run_command","command":"/trigger inc.ui set 1"}}]
