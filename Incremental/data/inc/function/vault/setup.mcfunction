tag @s remove inc.new.vault
tag @s add inc.vault
setblock ~ ~ ~ minecraft:chest[facing=north,type=single,waterlogged=false]
data merge block ~ ~ ~ {CustomName:{text:"Cofre profundo",color:"aqua"}}
scoreboard players operation #id inc.tmp = @s inc.id
execute positioned ~ ~0.3 ~-0.7 summon minecraft:text_display run function inc:vault/display
function inc:vault/save
