execute if score @s inc.qty6 matches 0 run return run tellraw @s [{"text":"Primero compra este generador.","color":"red"}]
scoreboard players set @s inc.sel 6
function inc:hud
