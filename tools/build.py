"""Build the physical Incremental datapack for Minecraft Java 26.3."""
import json
import re
import shutil
import zipfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
PACK = ROOT / 'Incremental'
# key, label, output, appearance, currency, price, shop page
CATALOG = [
    ('dirt', 'Tierra', 'dirt', 'dirt', 'dirt', 16, 1),
    ('oak', 'Roble', 'oak_log', 'oak_log', 'dirt', 256, 1),
    ('stone', 'Piedra', 'cobblestone', 'stone', 'oak', 512, 1),
    ('iron', 'Hierro', 'iron_ingot', 'iron_block', 'stone', 1024, 1),
    ('gold', 'Oro', 'gold_ingot', 'gold_block', 'iron', 2048, 1),
    ('diamond', 'Diamante', 'diamond', 'diamond_block', 'gold', 4096, 1),
    ('netherite', 'Netherita', 'netherite_ingot', 'netherite_block', 'diamond', 8192, 1),
    ('coal', 'Carbón', 'coal', 'coal_block', 'stone', 128, 2),
    ('copper', 'Cobre', 'copper_ingot', 'copper_block', 'stone', 256, 2),
    ('redstone', 'Redstone', 'redstone', 'redstone_block', 'iron', 256, 2),
    ('lapis', 'Lapislázuli', 'lapis_lazuli', 'lapis_block', 'iron', 256, 2),
    ('emerald', 'Esmeralda', 'emerald', 'emerald_block', 'diamond', 256, 2),
    ('obsidian', 'Obsidiana', 'obsidian', 'obsidian', 'diamond', 256, 2),
    ('quartz', 'Cuarzo', 'quartz', 'quartz_block', 'obsidian', 128, 2),
    ('glowstone', 'Piedra luminosa', 'glowstone', 'glowstone', 'quartz', 256, 3),
    ('magma', 'Bloque de magma', 'magma_block', 'magma_block', 'obsidian', 128, 3),
    ('sea_lantern', 'Linterna marina', 'sea_lantern', 'sea_lantern', 'emerald', 256, 3),
    ('blue_ice', 'Hielo azul', 'blue_ice', 'blue_ice', 'sea_lantern', 256, 3),
    ('wool', 'Lana', 'white_wool', 'white_wool', 'oak', 64, 3),
    ('string', 'Hilo', 'string', 'white_wool', 'wool', 64, 3),
    ('slime', 'Bloque de slime', 'slime_block', 'slime_block', 'string', 256, 3),
]
WOODS = [('spruce', 'Abeto', 'spruce_log'), ('birch', 'Abedul', 'birch_log'),
         ('jungle', 'Jungla', 'jungle_log'), ('acacia', 'Acacia', 'acacia_log'),
         ('dark_oak', 'Roble oscuro', 'dark_oak_log'), ('mangrove', 'Mangle', 'mangrove_log'),
         ('cherry', 'Cerezo', 'cherry_log'), ('pale_oak', 'Roble pálido', 'pale_oak_log'),
         ('poplar', 'Álamo', 'poplar_log'), ('crimson', 'Carmesí', 'crimson_stem'),
         ('warped', 'Distorsionada', 'warped_stem'), ('bamboo', 'Bambú', 'bamboo_block')]
CATALOG += [(key, label, item, item, 'oak', 256, 4) for key, label, item in WOODS]
# Append new types after existing woods: kind IDs are persisted in placed generators
# and deep chests, so inserting earlier would reinterpret existing machines/reserves.
CATALOG += [
    ('sand', 'Arena', 'sand', 'sand', 'stone', 128, 2),
    ('soul_sand', 'Arena de almas', 'soul_sand', 'soul_sand', 'obsidian', 128, 3),
    ('blaze_rod', 'Varas de blaze', 'blaze_rod', 'magma_block', 'magma', 256, 3),
    ('wither_skull', 'Cráneos de esqueleto wither', 'wither_skeleton_skull', 'wither_skeleton_skull', 'soul_sand', 4096, 3),
]
BY_KEY = {row[0]: row for row in CATALOG}
DIMENSIONS = ['minecraft:overworld', 'minecraft:the_nether', 'minecraft:the_end']

# Only this generated directory is recreated, never the workspace or hand-edited files.
generated = (PACK / 'data').resolve()
assert generated == ROOT / 'Incremental' / 'data' and generated.is_relative_to(ROOT)
if generated.exists():
    shutil.rmtree(generated)

def js(value):
    return json.dumps(value, ensure_ascii=False, separators=(',', ':'))

def write(path, value):
    p = PACK / path
    p.parent.mkdir(parents=True, exist_ok=True)
    p.write_text(value.rstrip() + '\n', encoding='utf-8')

def fn(name, lines):
    write(f'data/inc/function/{name}.mcfunction', '\n'.join(lines))

def txt(text, color='white', **extra):
    return dict(text=text, color=color, **extra)

def tell(text, color='white'):
    return 'tellraw @s ' + js(txt(text, color))

def button(text, action, color='green'):
    return txt(text, color, click_event={'action': 'run_command', 'command': f'/trigger inc.shop set {action}'})

def token(kind, label, extra_tags=()):
    return {'minecraft:entity_data': {'id': 'minecraft:armor_stand', 'Invisible': True,
        'Marker': True, 'NoGravity': True, 'Invulnerable': True, 'Silent': True,
        'Tags': ['inc.new.' + kind, *extra_tags]}, 'minecraft:custom_data': {'inc_token': True},
        'minecraft:custom_name': txt(label, 'gold', italic=False), 'minecraft:max_stack_size': 1,
        'minecraft:lore': [txt('Colócalo agachado con clic derecho.', 'gray', italic=False)]}

def token_loot(name, components):
    write(f'data/inc/loot_table/{name}.json', js({'type': 'minecraft:generic', 'pools': [
        {'rolls': 1, 'entries': [{'type': 'minecraft:item', 'name': 'minecraft:armor_stand',
            'modifier': {'type': 'minecraft:set_components', 'components': components}}]}]}))

write('pack.mcmeta', js({'pack': {'description': 'Incremental físico · Java 26.3 · v1.1.1',
                                'min_format': [121, 0], 'max_format': [121, 0]}}))
for tag in ['load', 'tick']:
    write(f'data/minecraft/tags/function/{tag}.json', js({'values': [f'inc:{tag}']}))
for tag in ['pause_screen_additions', 'quick_actions']:
    write(f'data/minecraft/tags/dialog/{tag}.json', js({'values': ['inc:shop/page1']}))
write('data/inc/tags/block/chests.json', js({'values': ['minecraft:chest', 'minecraft:trapped_chest']}))
write('data/inc/tags/block/generator_outputs.json', js({'values': ['#inc:chests', 'minecraft:hopper']}))
# Deep chests drop their restorable token through our controller. Suppress only the
# ordinary chest drop for this exact custom component to avoid producing two chests.
write('data/minecraft/loot_table/blocks/chest.json', js({'type': 'minecraft:block', 'pools': [{
    'rolls': 1, 'condition': {'type': 'minecraft:all_of', 'terms': [
        {'type': 'minecraft:survives_explosion'}, {'type': 'minecraft:inverted', 'term': {
            'type': 'minecraft:match_block', 'blocks': 'minecraft:chest',
            'components': {'minecraft:custom_name': {'text': 'Cofre profundo', 'color': 'aqua'}}}}]},
    'entries': [{'type': 'minecraft:item', 'name': 'minecraft:chest', 'modifier': {
        'type': 'minecraft:copy_components', 'include': ['minecraft:custom_name'], 'source': 'block_entity'}}]}],
    'random_sequence': 'minecraft:blocks/chest'}))

fn('setup', ['scoreboard objectives add inc.shop trigger'] +
   [f'scoreboard objectives add inc.{obj} dummy' for obj in ['sys', 'id', 'kind', 'buf', 'amount', 'space', 'left', 'tmp', 'trace', 'mine', 'aim']] +
   ['scoreboard players add #next inc.sys 0', 'data modify storage inc:meta physical set value 2'])
fn('load', ['execute unless data storage inc:meta {physical:2} run function inc:setup',
    'execute unless data storage inc:meta {universal:1b} run function inc:vault/bootstrap', 'scoreboard players set #clock inc.sys 0', 'scoreboard players set #cap inc.sys 1000000000'] +
    [f'execute in {dim} run kill @e[tag=inc.storage_part]' for dim in DIMENSIONS] +
    [f'execute in {dim} as @e[type=minecraft:armor_stand,tag=inc.vault] at @s run function inc:vault/reposition_label' for dim in DIMENSIONS])
fn('init', ['clear @s minecraft:carrot_on_a_stick[minecraft:custom_data~{inc_tool:1b}]',
    'scoreboard players set @s inc.shop 0', 'scoreboard players set @s inc.mine 0', 'tag @s add inc.physical',
    'loot give @s loot inc:tokens/gen/dirt', 'loot give @s loot inc:tokens/vault', 'give @s minecraft:chest 1',
    tell('Coloca el cofre profundo en el suelo y el generador de tierra sobre él, agachado. Tienda: /trigger inc.shop set 1', 'green')])
fn('tick', ['execute as @a[tag=!inc.physical] run function inc:init',
    'execute as @a at @s unless score @s inc.shop matches 0 run function inc:shop/dispatch',
    'scoreboard players enable @a inc.shop',
    'execute as @a[tag=inc.physical,gamemode=!spectator] at @s run function inc:mining/start',
    'execute as @a[tag=inc.physical,gamemode=spectator] run function inc:mining/clear'] +
    [f'execute in {dim} as @e[type=minecraft:armor_stand,tag=inc.new.gen] at @s run function inc:gen/new' for dim in DIMENSIONS] +
    [f'execute in {dim} as @e[type=minecraft:armor_stand,tag=inc.new.vault] at @s run function inc:vault/new' for dim in DIMENSIONS] +
    [f'execute in {dim} as @e[type=minecraft:item_display,tag=inc.icon] at @s run tp @s ~ ~ ~ ~6 ~' for dim in DIMENSIONS] + ['scoreboard players add #clock inc.sys 1', 'execute if score #clock inc.sys matches 20.. run function inc:second'])
fn('second', ['scoreboard players set #clock inc.sys 0'] +
    [f'execute in {dim} as @e[type=minecraft:armor_stand,tag=inc.gen] at @s run function inc:gen/tick' for dim in DIMENSIONS] +
    [f'execute in {dim} as @e[type=minecraft:armor_stand,tag=inc.vault] at @s run function inc:vault/tick' for dim in DIMENSIONS] +
    [f'execute in {dim} run kill @e[tag=inc.storage_part]' for dim in DIMENSIONS])

fn('shop/dispatch', [f'execute if score @s inc.shop matches {page} run function inc:shop/page{page}' for page in range(1, 5)] +
    [f'execute if score @s inc.shop matches {100+i} run function inc:shop/buy/{row[0]}' for i, row in enumerate(CATALOG)] +
    ['execute if score @s inc.shop matches 10 run function inc:shop/vault', 'scoreboard players set @s inc.shop 0'])
def dialog_button(label, action, tooltip=None):
    result = {'label': label, 'width': 210, 'action': {'type': 'minecraft:run_command', 'command': f'trigger inc.shop set {action}'}}
    if tooltip:
        result['tooltip'] = tooltip
    return result

for page, title in enumerate(['Progresión', 'Recursos 1', 'Recursos 2', 'Maderas'], 1):
    body = [{'type': 'minecraft:plain_message', 'width': 430, 'contents': 'Compra pulsando el nombre junto al icono. Pago con inventario o cofre profundo a 8 bloques.'}]
    actions = [dialog_button(label, number) for number, label in enumerate(['Principal', 'Recursos 1', 'Recursos 2', 'Maderas'], 1)]
    for i, row in enumerate(CATALOG):
        key, label, item, block, currency, price, category = row
        if category == page:
            body.append({'type': 'minecraft:item', 'item': {'id': 'minecraft:' + item, 'count': 1}, 'description': {'width': 390, 'contents': button('[Comprar ' + label + '] · ' + f'{price:,}'.replace(',', '.') + ' ' + BY_KEY[currency][1], 100+i)}, 'show_tooltip': True})
    actions.append(dialog_button('Cofre profundo · 64 hierro', 10))
    write(f'data/inc/dialog/shop/page{page}.json', js({'type': 'minecraft:multi_action', 'title': 'Tienda · ' + title,
        'external_title': 'Tienda de generadores', 'pause': False, 'after_action': 'close', 'columns': 2,
        'body': body,
        'actions': actions, 'exit_action': {'label': 'Cerrar', 'width': 210}}))
    fn('shop/page' + str(page), [f'dialog show @s inc:shop/page{page}'])

def purchase(name, item, price, loot, confirmation):
    currency_kind = next(i for i, row in enumerate(CATALOG) if row[2] == item)
    bank = f'@e[type=minecraft:armor_stand,tag=inc.vault,scores={{inc.kind={currency_kind}}},distance=..8,sort=nearest,limit=1]'
    fn(name, [f'execute store result score @s inc.amount run clear @s minecraft:{item} 0',
        'scoreboard players set #reserve inc.tmp 0',
        f'execute as {bank} at @s if block ~ ~ ~ minecraft:chest run function inc:vault/collect',
        f'execute as {bank} at @s if block ~ ~ ~ minecraft:chest run scoreboard players operation #reserve inc.tmp = @s inc.buf',
        'scoreboard players operation #funds inc.tmp = @s inc.amount', 'scoreboard players operation #funds inc.tmp += #reserve inc.tmp',
        f'execute if score #funds inc.tmp matches ..{price-1} run return run function inc:{name}_fail',
        f'scoreboard players set @s inc.tmp {price}', 'scoreboard players operation @s inc.amount < @s inc.tmp',
        'execute store result storage inc:runtime amount int 1 run scoreboard players get @s inc.amount',
        f'execute if score @s inc.amount matches 1.. run function inc:{name}_pay with storage inc:runtime',
        f'scoreboard players set #due inc.tmp {price}', 'scoreboard players operation #due inc.tmp -= @s inc.amount',
        f'execute if score #due inc.tmp matches 1.. run scoreboard players operation {bank} inc.buf -= #due inc.tmp',
        f'execute as {bank} at @s if block ~ ~ ~ minecraft:chest run function inc:vault/tick',
        'loot give @s loot inc:' + loot, tell(confirmation, 'green')])
    fn(name + '_pay', [f'$execute store result score @s inc.amount run clear @s minecraft:{item} $(amount)'])
    fn(name + '_fail', [f'execute as {bank} at @s if block ~ ~ ~ minecraft:chest run function inc:vault/tick',
        tell(f'Necesitas {price} de minecraft:{item} entre tu inventario y un cofre profundo cercano.', 'red')])

for key, label, item, block, currency, price, page in CATALOG:
    token_loot('tokens/gen/' + key, token('gen', 'Generador de ' + label, ['inc.type.' + key]))
    write(f'data/inc/loot_table/output/{key}.json', js({'type': 'minecraft:generic', 'pools': [
        {'rolls': 1, 'entries': [{'type': 'minecraft:item', 'name': 'minecraft:' + item}]}]}))
    purchase('shop/buy/' + key, BY_KEY[currency][2], price, 'tokens/gen/' + key,
             'Generador comprado. Colócalo sobre un cofre o una tolva, agachado.')
token_loot('tokens/vault', token('vault', 'Cofre profundo'))
purchase('shop/vault', 'iron_ingot', 64, 'tokens/vault', 'Cofre profundo comprado. Colócalo en el suelo, agachado.')

fn('entity/id', ['scoreboard players add #next inc.sys 1', 'scoreboard players operation @s inc.id = #next inc.sys'])
fn('entity/display_id', ['tag @s add inc.part', 'scoreboard players operation @s inc.id = #id inc.tmp'])
fn('entity/cleanup', ['scoreboard players operation #id inc.tmp = @s inc.id',
    'execute as @e[tag=inc.part,distance=..3] if score @s inc.id = #id inc.tmp run kill @s'])
# The item places an invisible armor stand. Its exact placement avoids guessing the
# target with a raycast or overwriting another player's nearby block.
fn('gen/new', ['function inc:entity/id'] + [f'execute if entity @s[tag=inc.type.{key}] run scoreboard players set @s inc.kind {i}' for i, (key, *_) in enumerate(CATALOG)] +
    ['execute if block ~ ~ ~ #inc:generator_outputs align xyz positioned ~0.5 ~1 ~0.5 run return run function inc:gen/place',
     'execute if block ~ ~-1 ~ #inc:generator_outputs align xyz positioned ~0.5 ~ ~0.5 run return run function inc:gen/place',
     'function inc:gen/refund'])
# Native armor stand placement can put its feet on the lid, Y + 0.875.
# Snap both the execution position and entity to the block above the chest.
fn('gen/place', ['execute unless block ~ ~ ~ minecraft:air run return run function inc:gen/refund',
     'tp @s ~ ~ ~',
     'tag @s remove inc.new.gen', 'tag @s add inc.gen', 'setblock ~ ~ ~ minecraft:glass',
     'scoreboard players operation #id inc.tmp = @s inc.id'] +
    [f'execute if score @s inc.kind matches {i} run function inc:gen/setup/{key}' for i, (key, *_) in enumerate(CATALOG)])
for key, label, item, block, *_ in CATALOG:
    fn('gen/setup/' + key, ['execute positioned ~ ~0.5 ~ summon minecraft:item_display run function inc:gen/display/' + key, 'tag @s add inc.visual2'])
    fn('gen/display/' + key, ['function inc:entity/display_id', 'tag @s add inc.icon',
        'data merge entity @s {item:{id:"minecraft:' + item + '",count:1},item_display:"ground",teleport_duration:1,transformation:{translation:[0f,0f,0f],scale:[0.65f,0.65f,0.65f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f]}}'])
fn('gen/upgrade_visual', ['function inc:entity/cleanup', 'scoreboard players operation #id inc.tmp = @s inc.id'] +
    [f'execute if score @s inc.kind matches {i} run function inc:gen/setup/{key}' for i, (key, *_) in enumerate(CATALOG)])
fn('gen/refund', [f'execute if score @s inc.kind matches {i} run loot spawn ~ ~ ~ loot inc:tokens/gen/{key}' for i, (key, *_) in enumerate(CATALOG)] +
    ['function inc:entity/cleanup', 'kill @s'])
fn('gen/tick', ['execute unless entity @s[tag=inc.visual2] run function inc:gen/upgrade_visual', 'execute unless block ~ ~ ~ minecraft:glass run return run function inc:gen/refund',
    'execute unless block ~ ~-1 ~ #inc:generator_outputs run return 0', 'scoreboard players operation #kind inc.tmp = @s inc.kind',
    'execute positioned ~ ~-1 ~ if entity @e[type=minecraft:armor_stand,tag=inc.vault,distance=..0.1] run return run function inc:gen/to_vault'] +
    [f'execute if score @s inc.kind matches {i} run function inc:gen/output/{key}' for i, (key, *_) in enumerate(CATALOG)])
for key, *_ in CATALOG:
    fn('gen/output/' + key, [f'data modify storage inc:runtime output set value "{key}"',
        'execute positioned ~ ~-1 ~ run function inc:gen/insert with storage inc:runtime'])
# /loot insert can report success for a full matching stack without inserting it.
# Compare actual inventory data so a double chest never gains two items per cycle.
insert = ['data modify storage inc:runtime before set from block ~ ~ ~ Items',
    '$loot insert ~ ~ ~ loot inc:output/$(output)',
    'execute store success score @s inc.tmp run data modify storage inc:runtime before set from block ~ ~ ~ Items',
    'execute if score @s inc.tmp matches 1 run return 1']
clockwise = {'north': (1, 0), 'east': (0, 1), 'south': (-1, 0), 'west': (0, -1)}
for block in ['chest', 'trapped_chest']:
    for facing, (dx, dz) in clockwise.items():
        for half, sign, partner in [('left', 1, 'right'), ('right', -1, 'left')]:
            x, z = dx * sign, dz * sign
            insert.append(f'execute if block ~ ~ ~ minecraft:{block}[facing={facing},type={half}] positioned ~{x} ~ ~{z} if block ~ ~ ~ minecraft:{block}[facing={facing},type={partner}] run return run function inc:gen/insert_partner with storage inc:runtime')
fn('gen/insert', insert)
fn('gen/insert_partner', ['$loot insert ~ ~ ~ loot inc:output/$(output)'])
fn('gen/to_vault', [f'execute if score #kind inc.tmp matches {i} run data modify storage inc:runtime generated set value {{id:"minecraft:{item}"}}' for i, (_, _, item, *_) in enumerate(CATALOG)] + ['execute as @e[type=minecraft:armor_stand,tag=inc.vault,distance=..0.1,limit=1] run function inc:vault/accept'])
fn('vault/accept', ['function inc:vault/collect',
    'execute unless data storage inc:runtime prototype run function inc:vault/bind_generated',
    'data modify storage inc:runtime reference set from storage inc:runtime prototype',
    'execute store success score @s inc.tmp run data modify storage inc:runtime reference set from storage inc:runtime generated',
    'execute if score @s inc.tmp matches 1 run return 0',
    'execute if score @s inc.buf < #cap inc.sys run scoreboard players add @s inc.buf 1'])
fn('vault/bind_generated', ['data modify storage inc:runtime probe set from storage inc:runtime generated',
    'scoreboard players set @s inc.stack 64', 'function inc:vault/bind'])
fn('vault/bootstrap', ['scoreboard objectives add inc.stack dummy', 'data modify storage inc:meta universal set value 1b'])
sizes = json.loads((ROOT / 'tools/stack_sizes.json').read_text(encoding='utf-8'))
for maximum in sorted(set(sizes.values())):
    write(f'data/inc/tags/item/stack_{maximum}.json', js({'values': [item for item, count in sizes.items() if count == maximum]}))

fn('vault/new', ['execute store result score @s inc.tmp run data get entity @s DisabledSlots',
    'execute unless block ~ ~ ~ minecraft:air run return run function inc:vault/refund_new',
    'execute if score @s inc.tmp matches 1.. run return run function inc:vault/restore_start',
    'function inc:entity/id', 'scoreboard players set @s inc.kind -1', 'scoreboard players set @s inc.buf 0', 'function inc:vault/setup'])
fn('vault/refund_new', ['execute if score @s inc.tmp matches 1.. run return run function inc:vault/refund_restored',
    'loot spawn ~ ~ ~ loot inc:tokens/vault', 'kill @s'])
fn('vault/refund_restored', ['execute store result storage inc:runtime id int 1 run scoreboard players get @s inc.tmp',
    'function inc:vault/drop_token with storage inc:runtime', 'kill @s'])
fn('vault/restore_start', ['execute store result storage inc:runtime id int 1 run scoreboard players get @s inc.tmp', 'function inc:vault/restore with storage inc:runtime'])
fn('vault/restore', ['$execute if data storage inc:vaults v$(id){placed:1b} run return run kill @s',
    '$scoreboard players set @s inc.id $(id)', '$execute store result score @s inc.kind run data get storage inc:vaults v$(id).kind',
    '$execute store result score @s inc.buf run data get storage inc:vaults v$(id).amount', 'function inc:vault/setup'])
fn('vault/setup', ['tag @s remove inc.new.vault', 'tag @s add inc.vault',
    'function inc:vault/orient',
    'data merge block ~ ~ ~ {CustomName:{text:"Cofre profundo",color:"aqua"}}', 'scoreboard players operation #id inc.tmp = @s inc.id',
    'execute positioned ~ ~0.3 ~-0.7 summon minecraft:text_display run function inc:vault/display', 'function inc:vault/save'])
fn('vault/display', ['function inc:entity/display_id', 'data merge entity @s {billboard:"center",background:0,shadow:1b,text:{text:"0",color:"aqua"}}'])
fn('vault/orient', ['execute store result score @s inc.tmp run data get entity @s Rotation[0]',
    'execute if score @s inc.tmp matches -45..44 run setblock ~ ~ ~ minecraft:chest[facing=south,type=single,waterlogged=false]',
    'execute if score @s inc.tmp matches 45..134 run setblock ~ ~ ~ minecraft:chest[facing=west,type=single,waterlogged=false]',
    'execute if score @s inc.tmp matches -134..-46 run setblock ~ ~ ~ minecraft:chest[facing=east,type=single,waterlogged=false]',
    'execute if score @s inc.tmp matches 135.. run setblock ~ ~ ~ minecraft:chest[facing=north,type=single,waterlogged=false]',
    'execute if score @s inc.tmp matches ..-135 run setblock ~ ~ ~ minecraft:chest[facing=north,type=single,waterlogged=false]'])
fn('vault/reposition_label', ['scoreboard players operation #id inc.tmp = @s inc.id'] +
    [f'execute if block ~ ~ ~ minecraft:chest[facing={direction}] as @e[type=minecraft:text_display,tag=inc.part,distance=..3] if score @s inc.id = #id inc.tmp run tp @s {offset}' for direction, offset in [('north','~ ~0.3 ~-0.7'),('south','~ ~0.3 ~0.7'),('east','~0.7 ~0.3 ~'),('west','~-0.7 ~0.3 ~')]])
fn('vault/read', ['execute store result storage inc:runtime id int 1 run scoreboard players get @s inc.id',
    'data remove storage inc:runtime prototype', 'scoreboard players set @s inc.stack 64',
    'function inc:vault/read_state with storage inc:runtime'])
fn('vault/read_state', ['$execute if data storage inc:vaults v$(id).prototype run data modify storage inc:runtime prototype set from storage inc:vaults v$(id).prototype',
    '$execute if data storage inc:vaults v$(id).max run execute store result score @s inc.stack run data get storage inc:vaults v$(id).max'] +
    [f'execute unless data storage inc:runtime prototype if score @s inc.kind matches {i} run data modify storage inc:runtime prototype set value {{id:"minecraft:{item}"}}' for i, (_, _, item, *_) in enumerate(CATALOG)])
fn('vault/collect', ['function inc:vault/read',
    'execute if score @s inc.buf matches 0 if data storage inc:runtime prototype run function inc:vault/reconsider'] +
    [f'execute if items block ~ ~ ~ container.{slot} * run function inc:vault/slot/{slot}' for slot in range(27)])
fn('vault/reconsider', ['scoreboard players set #old inc.tmp 0'] +
    [f'execute if items block ~ ~ ~ container.{slot} * run function inc:vault/peek/{slot}' for slot in range(27)] +
    ['execute if score #old inc.tmp matches 0 run function inc:vault/reset'])
fn('vault/reset', ['scoreboard players set @s inc.kind -1', 'data remove storage inc:runtime prototype',
    'function inc:vault/clear_prototype with storage inc:runtime'])
fn('vault/clear_prototype', ['$data remove storage inc:vaults v$(id).prototype', '$data remove storage inc:vaults v$(id).max'])
for slot in range(27):
    probe = [f'data modify storage inc:runtime probe set from block ~ ~ ~ Items[{{Slot:{slot}b}}]',
        'data remove storage inc:runtime probe.Slot', 'data remove storage inc:runtime probe.count',
        'scoreboard players set @s inc.tmp 0', 'execute store result score @s inc.tmp run data get storage inc:runtime probe.components',
        'execute if score @s inc.tmp matches 0 run data remove storage inc:runtime probe.components']
    fn(f'vault/peek/{slot}', probe + ['data modify storage inc:runtime reference set from storage inc:runtime prototype',
        'execute store success score @s inc.tmp run data modify storage inc:runtime reference set from storage inc:runtime probe',
        'execute if score @s inc.tmp matches 0 run scoreboard players set #old inc.tmp 1'])
    fn(f'vault/slot/{slot}', probe + [f'data modify storage inc:runtime slot set value {slot}', 'function inc:vault/scan with storage inc:runtime'])
fn('vault/scan', ['execute unless data storage inc:runtime prototype run function inc:vault/bind_slot with storage inc:runtime',
    'data modify storage inc:runtime reference set from storage inc:runtime prototype',
    'execute store success score @s inc.tmp run data modify storage inc:runtime reference set from storage inc:runtime probe',
    'execute if score @s inc.tmp matches 1 run return run function inc:vault/eject with storage inc:runtime',
    'function inc:vault/deposit with storage inc:runtime'])
fn('vault/bind_slot', ['scoreboard players set @s inc.stack 64'] +
    [f'$execute if items block ~ ~ ~ container.$(slot) #inc:stack_{maximum} run scoreboard players set @s inc.stack {maximum}' for maximum in sorted(set(sizes.values()))] +
    ['execute if data storage inc:runtime probe.components."minecraft:max_stack_size" run execute store result score @s inc.stack run data get storage inc:runtime probe.components."minecraft:max_stack_size"', 'function inc:vault/bind'])
fn('vault/bind', ['data modify storage inc:runtime prototype set from storage inc:runtime probe', 'scoreboard players set @s inc.kind -2'] +
    [f'execute if data storage inc:runtime {{probe:{{id:"minecraft:{item}"}}}} run function inc:vault/canonical/{key}' for key, _, item, *_ in CATALOG] +
    ['execute store result storage inc:runtime maximum int 1 run scoreboard players get @s inc.stack', 'function inc:vault/write_prototype with storage inc:runtime'])
for i, (key, _, item, *_) in enumerate(CATALOG):
    fn('vault/canonical/' + key, [f'data modify storage inc:runtime reference set value {{id:"minecraft:{item}"}}',
        'execute store success score @s inc.tmp run data modify storage inc:runtime reference set from storage inc:runtime prototype',
        f'execute if score @s inc.tmp matches 0 run scoreboard players set @s inc.kind {i}'])
fn('vault/write_prototype', ['$execute unless data storage inc:vaults v$(id) run data modify storage inc:vaults v$(id) set value {}',
    '$data modify storage inc:vaults v$(id).prototype set from storage inc:runtime prototype', '$data modify storage inc:vaults v$(id).max set value $(maximum)'])
fn('vault/deposit', ['$execute store result score @s inc.amount run data get block ~ ~ ~ Items[{Slot:$(slot)b}].count',
    'scoreboard players operation @s inc.left = @s inc.amount', 'scoreboard players operation @s inc.space = #cap inc.sys',
    'scoreboard players operation @s inc.space -= @s inc.buf', 'scoreboard players operation @s inc.amount < @s inc.space',
    'scoreboard players operation @s inc.left -= @s inc.amount', 'scoreboard players operation @s inc.buf += @s inc.amount',
    '$execute if score @s inc.left matches 0 run return run item replace block ~ ~ ~ container.$(slot) with minecraft:air',
    'execute store result storage inc:runtime left int 1 run scoreboard players get @s inc.left', 'function inc:vault/left with storage inc:runtime'])
fn('vault/left', ['$data modify block ~ ~ ~ Items[{Slot:$(slot)b}].count set value $(left)'])
fn('vault/eject', ['$data modify storage inc:runtime stack set from block ~ ~ ~ Items[{Slot:$(slot)b}]',
    'function inc:vault/eject_stack with storage inc:runtime', '$item replace block ~ ~ ~ container.$(slot) with minecraft:air'])
fn('vault/eject_stack', ['$summon minecraft:item ~ ~1 ~ {PickupDelay:20s,Item:$(stack)}'])
fn('vault/tick', ['execute unless block ~ ~ ~ minecraft:chest run return run function inc:vault/break',
    'function inc:vault/reposition_label', 'function inc:vault/collect',
    'execute store result storage inc:runtime total int 1 run scoreboard players get @s inc.buf',
    'scoreboard players operation @s inc.amount = @s inc.buf', 'scoreboard players operation @s inc.amount < @s inc.stack',
    'execute if score @s inc.amount matches 1.. unless items block ~ ~ ~ container.0 * run function inc:vault/fill',
    'function inc:vault/label with storage inc:runtime', 'function inc:vault/save'])
fn('vault/fill', ['data modify storage inc:runtime outgoing set from storage inc:runtime prototype',
    'execute store result storage inc:runtime outgoing.count int 1 run scoreboard players get @s inc.amount',
    'data modify storage inc:runtime outgoing.Slot set value 0b',
    'execute store success score @s inc.tmp run data modify block ~ ~ ~ Items append from storage inc:runtime outgoing',
    'execute if score @s inc.tmp matches 1 run scoreboard players operation @s inc.buf -= @s inc.amount'])
fn('vault/label', ['$execute as @e[type=minecraft:text_display,tag=inc.part,distance=..2] if score @s inc.id = #id inc.tmp run data merge entity @s {text:{text:"$(total)",color:"aqua"}}'])
fn('vault/save', ['execute store result storage inc:runtime id int 1 run scoreboard players get @s inc.id',
    'execute store result storage inc:runtime amount int 1 run scoreboard players get @s inc.buf',
    'execute store result storage inc:runtime kind int 1 run scoreboard players get @s inc.kind', 'function inc:vault/save_values with storage inc:runtime'])
fn('vault/save_values', ['$execute unless data storage inc:vaults v$(id) run data modify storage inc:vaults v$(id) set value {}',
    '$data modify storage inc:vaults v$(id) merge value {amount:$(amount),kind:$(kind),placed:1b}'])
fn('vault/break', ['function inc:vault/save', 'function inc:vault/unplace with storage inc:runtime',
    'function inc:vault/drop_token with storage inc:runtime', 'function inc:entity/cleanup', 'kill @s'])
fn('vault/unplace', ['$data modify storage inc:vaults v$(id).placed set value 0b'])
fn('vault/drop_token', ['$summon minecraft:item ~ ~ ~ {PickupDelay:20s,Item:{id:"minecraft:armor_stand",count:1,components:{"minecraft:max_stack_size":1,"minecraft:custom_data":{inc_token:1b},"minecraft:custom_name":{text:"Cofre profundo recuperado",color:"aqua",italic:0b},"minecraft:entity_data":{id:"minecraft:armor_stand",Invisible:1b,Marker:1b,NoGravity:1b,Invulnerable:1b,Silent:1b,DisabledSlots:$(id),Tags:["inc.new.vault"]}}}}'])

# Hardness groups are checked against the installed 26.3 engine by Validate.java.
MINING = {
    1: (1.25, ['basalt', 'polished_basalt', 'smooth_basalt']),
    2: (1.5, ['blackstone', 'blackstone_stairs', 'blackstone_wall', 'gilded_blackstone', 'polished_blackstone_bricks', 'polished_blackstone_brick_stairs', 'polished_blackstone_brick_wall', 'cracked_polished_blackstone_bricks', 'chiseled_polished_blackstone']),
    3: (2.0, ['blackstone_slab', 'polished_blackstone', 'polished_blackstone_slab', 'polished_blackstone_stairs', 'polished_blackstone_wall', 'polished_blackstone_brick_slab']),
    4: (3.0, ['deepslate']),
    5: (3.5, ['polished_deepslate', 'polished_deepslate_slab', 'polished_deepslate_stairs', 'polished_deepslate_wall', 'chiseled_deepslate', 'cobbled_deepslate', 'cobbled_deepslate_slab', 'cobbled_deepslate_stairs', 'cobbled_deepslate_wall', 'deepslate_bricks', 'deepslate_brick_slab', 'deepslate_brick_stairs', 'deepslate_brick_wall', 'cracked_deepslate_bricks', 'deepslate_tiles', 'deepslate_tile_slab', 'deepslate_tile_stairs', 'deepslate_tile_wall', 'cracked_deepslate_tiles']),
}
for group, (hardness, blocks) in MINING.items():
    write(f'data/inc/tags/block/mining/g{group}.json', js({'values': ['minecraft:' + b for b in blocks]}))
write('data/inc/tags/block/mining/pass_through.json', js({'values': ['minecraft:air', 'minecraft:cave_air', 'minecraft:void_air', 'minecraft:water', 'minecraft:lava']}))
fn('mining/start', ['scoreboard players set @s inc.tmp 1',
    'execute if score @s inc.mine matches 1.. store success score @s inc.tmp run attribute @s minecraft:block_break_speed modifier value get inc:stone_speed',
    'execute if score @s inc.tmp matches 0 run scoreboard players set @s inc.mine 0',
    'scoreboard players set @s inc.aim 0', 'scoreboard players set @s inc.trace 46',
    'execute anchored eyes positioned ^ ^ ^ run function inc:mining/ray', 'execute unless score @s inc.mine = @s inc.aim run function inc:mining/apply'])
fn('mining/ray', [f'execute if block ~ ~ ~ #inc:mining/g{g} run return run scoreboard players set @s inc.aim {g if h != 1.5 else 0}' for g, (h, _) in MINING.items()] +
    ['execute unless block ~ ~ ~ #inc:mining/pass_through run return 0', 'scoreboard players remove @s inc.trace 1',
     'execute if score @s inc.trace matches 1.. positioned ^ ^ ^0.1 run function inc:mining/ray'])
fn('mining/apply', ['execute if score @s inc.mine matches 1.. run attribute @s minecraft:block_break_speed modifier remove inc:stone_speed',
    'scoreboard players operation @s inc.mine = @s inc.aim'] +
    [f'execute if score @s inc.aim matches {g} run attribute @s minecraft:block_break_speed modifier add inc:stone_speed {h/1.5-1:.10f} add_multiplied_total' for g, (h, _) in MINING.items() if h != 1.5])
fn('mining/clear', ['execute if score @s inc.mine matches 1.. run attribute @s minecraft:block_break_speed modifier remove inc:stone_speed', 'scoreboard players set @s inc.mine 0'])

legacy = []
for i, (_, label, item, *_) in enumerate(CATALOG[:7]):
    legacy.append(f'execute if score @s inc.bank{i} matches 1.. run function inc:legacy/claim/{i}')
    fn(f'legacy/claim/{i}', [f'scoreboard players operation @s inc.amount = @s inc.bank{i}',
        'scoreboard players set @s inc.tmp 64', 'scoreboard players operation @s inc.amount < @s inc.tmp',
        'execute store result storage inc:runtime amount int 1 run scoreboard players get @s inc.amount', f'function inc:legacy/give/{i} with storage inc:runtime'])
    fn(f'legacy/give/{i}', [f'$give @s minecraft:{item} $(amount)', f'scoreboard players operation @s inc.bank{i} -= @s inc.amount'])
fn('legacy/claim', legacy)

for p in PACK.rglob('*.json'):
    json.loads(p.read_text(encoding='utf-8'))
for p in PACK.rglob('*.mcfunction'):
    for target in re.findall(r'\bfunction inc:([a-z0-9_/]+)', p.read_text(encoding='utf-8')):
        assert (PACK / f'data/inc/function/{target}.mcfunction').exists(), (p, target)
assert len(CATALOG) == 37 and len(BY_KEY) == len(CATALOG)
assert all(row[4] in BY_KEY for row in CATALOG)
if (ROOT / 'README.md').exists():
    write('README.md', (ROOT / 'README.md').read_text(encoding='utf-8'))
archive = ROOT / 'dist' / 'Incremental-26.3.zip'
archive.parent.mkdir(exist_ok=True)
with zipfile.ZipFile(archive, 'w', zipfile.ZIP_DEFLATED) as z:
    for p in sorted(PACK.rglob('*')):
        if p.is_file():
            z.write(p, p.relative_to(PACK).as_posix())
print(f'Built {len(CATALOG)} generators, {len(list(PACK.rglob("*.mcfunction")))} functions: {archive}')
