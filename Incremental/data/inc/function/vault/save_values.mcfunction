$execute unless data storage inc:vaults v$(id) run data modify storage inc:vaults v$(id) set value {}
$data modify storage inc:vaults v$(id) merge value {amount:$(amount),kind:$(kind),placed:1b}
