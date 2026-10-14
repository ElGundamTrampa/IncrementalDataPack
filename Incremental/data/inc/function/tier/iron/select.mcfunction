execute if score @s inc.qty3 matches 0 run return run tellraw @s [{"text":"Primero compra este generador.","color":"red"}]
scoreboard players set @s inc.sel 3
function inc:hud
