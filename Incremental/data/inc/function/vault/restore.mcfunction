$execute if data storage inc:vaults v$(id){placed:1b} run return run kill @s
$scoreboard players set @s inc.id $(id)
$execute store result score @s inc.kind run data get storage inc:vaults v$(id).kind
$execute store result score @s inc.buf run data get storage inc:vaults v$(id).amount
function inc:vault/setup
