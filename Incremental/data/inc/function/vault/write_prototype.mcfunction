$execute unless data storage inc:vaults v$(id) run data modify storage inc:vaults v$(id) set value {}
$data modify storage inc:vaults v$(id).prototype set from storage inc:runtime prototype
$data modify storage inc:vaults v$(id).max set value $(maximum)
