scoreboard players operation #owner inc.tmp = @s inc.owner
scoreboard players operation #kind inc.tmp = @s inc.kind
execute on target if score @s inc.id = #owner inc.tmp run function inc:warehouse/open
execute on target unless score @s inc.id = #owner inc.tmp run tellraw @s [{"text":"Este almacén pertenece a otro jugador.","color":"yellow"}]
data remove entity @s interaction
