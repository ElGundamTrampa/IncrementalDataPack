$execute as @e[type=minecraft:text_display,tag=inc.part,distance=..2] if score @s inc.id = #id inc.tmp run data merge entity @s {text:{text:"Jungla · $(total) guardados",color:"aqua"}}
