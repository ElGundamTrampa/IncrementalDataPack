scoreboard players set #clock inc.sys 0
execute as @a run function inc:produce
execute as @a[scores={inc.hud=1}] run function inc:hud
