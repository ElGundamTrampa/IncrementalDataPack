$data modify storage inc:runtime stack set from block ~ ~ ~ Items[{Slot:$(slot)b}]
function inc:vault/eject_stack with storage inc:runtime
$item replace block ~ ~ ~ container.$(slot) with minecraft:air
