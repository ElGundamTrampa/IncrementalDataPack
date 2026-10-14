"""Generate the Incremental datapack and its installable archive (Python 3.12)."""
import json
import re
import zipfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
PACK = ROOT / 'Incremental'
TIERS = [
    ('dirt', 'Tierra', 'dirt', 16, 'gold'),
    ('wood', 'Madera', 'oak_log', 256, 'yellow'),
    ('stone', 'Piedra', 'cobblestone', 512, 'gray'),
    ('iron', 'Hierro', 'iron_ingot', 1024, 'white'),
    ('gold', 'Oro', 'gold_ingot', 2048, 'gold'),
    ('diamond', 'Diamante', 'diamond', 4096, 'aqua'),
    ('nether', 'Netherita', 'netherite_ingot', 8192, 'dark_purple'),
]

def write(path, value):
    target = PACK / path
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(value.rstrip() + '\n', encoding='utf-8')

def js(value):
    return json.dumps(value, ensure_ascii=False, separators=(',', ':'))

def fn(name, lines):
    write(f'data/inc/function/{name}.mcfunction', '\n'.join(lines))

def txt(text, color='white', **extra):
    return dict(text=text, color=color, **extra)

def score(obj):
    return {'score': {'name': '@s', 'objective': obj}}

def button(text, action, color='green'):
    return txt(text, color, click_event={'action': 'run_command', 'command': f'/trigger inc.ui set {action}'})

def tell(parts):
    return 'tellraw @s ' + js(parts)

write('pack.mcmeta', js({'pack': {'description': 'Incremental · cadena de recursos · Java 26.3', 'min_format': [121, 0], 'max_format': [121, 0]}}))
for tag in ('load', 'tick'):
    write(f'data/minecraft/tags/function/{tag}.json', js({'values': [f'inc:{tag}']}))

objectives = {'inc.ui': 'trigger', 'inc.used': 'minecraft.used:minecraft.carrot_on_a_stick'}
for key in ['id', 'sel', 'cd', 'hud', 'amount', 'space', 'tmp', 'sys', 'owner', 'kind']:
    objectives['inc.' + key] = 'dummy'
for i in range(7):
    for key in ['bank', 'qty', 'price', 'pow', 'level', 'up', 'rate']:
        objectives[f'inc.{key}{i}'] = 'dummy'
fn('load', [f'scoreboard objectives add {key} {criterion}' for key, criterion in objectives.items()] + [
    'scoreboard players add #next inc.sys 0',
    'scoreboard players set #clock inc.sys 0',
    'scoreboard players set #cap inc.sys 1000000000',
    'scoreboard players set #four inc.sys 4',
    'tellraw @a ' + js(txt('Incremental cargado. Abre el menú: /trigger inc.ui set 1', 'green')),
])

initial = ['scoreboard players add #next inc.sys 1', 'scoreboard players operation @s inc.id = #next inc.sys',
           'scoreboard players set @s inc.sel 0', 'scoreboard players set @s inc.cd 0',
           'scoreboard players set @s inc.hud 1', 'scoreboard players set @s inc.used 0',
           'scoreboard players set @s inc.ui 0']
for i, (_, _, _, price, _) in enumerate(TIERS):
    for key, value in [('bank', 0), ('qty', int(i == 0)), ('price', price), ('pow', 1), ('level', 0), ('up', 32), ('rate', int(i == 0))]:
        initial.append(f'scoreboard players set @s inc.{key}{i} {value}')
fn('init', initial + ['tag @s add inc.ready', 'function inc:tool', 'function inc:menu'])

fn('tick', [
    'execute as @a[tag=!inc.ready] run function inc:init',
    'scoreboard players remove @a[scores={inc.cd=1..}] inc.cd 1',
    'execute as @a[scores={inc.used=1..}] if items entity @s weapon.mainhand minecraft:carrot_on_a_stick[minecraft:custom_data~{inc_tool:1b}] run function inc:click',
    'execute as @a[scores={inc.used=1..}] if items entity @s weapon.offhand minecraft:carrot_on_a_stick[minecraft:custom_data~{inc_tool:1b}] run function inc:click',
    'scoreboard players set @a inc.used 0',
    'execute as @a unless score @s inc.ui matches 0 run function inc:dispatch',
    'scoreboard players enable @a inc.ui',
    'scoreboard players add #clock inc.sys 1',
    'execute if score #clock inc.sys matches 20.. run function inc:second',
] + [f'execute in {d} as @e[type=minecraft:interaction,tag=inc.storage] at @s if data entity @s interaction run function inc:warehouse/interact' for d in ['minecraft:overworld', 'minecraft:the_nether', 'minecraft:the_end']])
fn('second', ['scoreboard players set #clock inc.sys 0', 'execute as @a run function inc:produce', 'execute as @a[scores={inc.hud=1}] run function inc:hud'])
produce = []
for i in range(7):
    produce += [f'scoreboard players operation @s inc.bank{i} += @s inc.rate{i}', f'scoreboard players operation @s inc.bank{i} < #cap inc.sys']
fn('produce', produce)

dispatch = []
for action, name in [(1, 'menu'), (2, 'click'), (3, 'tool'), (4, 'toggle_hud'), (60, 'warehouse/request'), (61, 'warehouse/remove')]:
    dispatch.append(f'execute if score @s inc.ui matches {action} run function inc:{name}')
for i, (key, *_) in enumerate(TIERS):
    for start, operation in [(10, 'select'), (20, 'buy'), (30, 'upgrade'), (40, 'deposit'), (50, 'withdraw')]:
        dispatch.append(f'execute if score @s inc.ui matches {start+i} run function inc:tier/{key}/{operation}')
fn('dispatch', dispatch + ['scoreboard players set @s inc.ui 0'])
fn('toggle_hud', ['scoreboard players add @s inc.hud 1', 'execute if score @s inc.hud matches 2.. run scoreboard players set @s inc.hud 0', 'title @s actionbar ""'])
fn('tool', [
    'clear @s minecraft:carrot_on_a_stick[minecraft:custom_data~{inc_tool:1b}]',
    'give @s minecraft:carrot_on_a_stick[minecraft:custom_data={inc_tool:1b},minecraft:custom_name={text:"Generador incremental",color:"green",italic:false},minecraft:lore=[{text:"Clic derecho: genera el recurso seleccionado.",italic:false},{text:"Menú: /trigger inc.ui set 1",italic:false}],minecraft:unbreakable={}] 1',
])
fn('click', ['execute if score @s inc.cd matches 1.. run return 0', 'scoreboard players set @s inc.cd 5'] + [f'execute if score @s inc.sel matches {i} run function inc:tier/{key}/click' for i, (key, *_) in enumerate(TIERS)])
fn('hud', [f'execute if score @s inc.sel matches {i} run title @s actionbar ' + js([txt(name + ' · ', color), score(f'inc.bank{i}'), txt(' guardados | +'), score(f'inc.rate{i}'), txt('/s | Menú: /trigger inc.ui set 1', 'gray')]) for i, (_, name, _, _, color) in enumerate(TIERS)])

menu = [tell([txt('━━ INCREMENTAL · ALMACENES ━━', 'gold')]),
        tell([button('[GENERAR] ', 2), button('[HERRAMIENTA] ', 3, 'aqua'), button('[HUD] ', 4, 'gray')]),
        tell([txt('Compra productores con el recurso anterior. Mejora con el propio.', 'gray')])]
for i, (_, name, _, _, color) in enumerate(TIERS):
    currency = TIERS[max(0, i-1)][1]
    menu.append(tell([txt(name + ': ', color), score(f'inc.bank{i}'), txt(' | Generadores: '), score(f'inc.qty{i}'), txt(' | +'), score(f'inc.rate{i}'), txt('/s\n'),
        button('[Seleccionar] ', 10+i, color), button('[Comprar: ', 20+i), score(f'inc.price{i}'), button(f' {currency}] ', 20+i),
        button('[Mejorar: ', 30+i, 'yellow'), score(f'inc.up{i}'), button(f' {name}] ', 30+i, 'yellow'),
        button('[Depositar] ', 40+i, 'aqua'), button('[Retirar 64]', 50+i, 'white')]))
menu += [tell([button('[Colocar almacén del recurso seleccionado] ', 60, 'gold'), button('[Recoger tus almacenes cercanos]', 61, 'gray')]),
         tell([txt('Clic derecho en el almacén: menú. Sus reservas son personales.\nRetirar deja objetos reales; deja espacio en el inventario.', 'gray')])]
fn('menu', menu)

for i, (key, name, item, _, color) in enumerate(TIERS):
    base = f'tier/{key}'
    prev = max(0, i-1)
    fn(base + '/select', [f'execute if score @s inc.qty{i} matches 0 run return run ' + tell([txt('Primero compra este generador.', 'red')]), f'scoreboard players set @s inc.sel {i}', 'function inc:hud'])
    fn(base + '/click', [f'scoreboard players operation @s inc.bank{i} += @s inc.pow{i}', f'scoreboard players operation @s inc.bank{i} < #cap inc.sys', 'function inc:hud'])
    fn(base + '/buy', [
        f'execute if score @s inc.qty{i} matches 50.. run return run ' + tell([txt('Límite: 50 generadores de este material.', 'yellow')]),
        f'execute unless score @s inc.bank{prev} >= @s inc.price{i} run return run ' + tell([txt('Necesitas más ' + TIERS[prev][1] + ' en el almacén.', 'red')]),
        f'scoreboard players operation @s inc.bank{prev} -= @s inc.price{i}',
        f'scoreboard players add @s inc.qty{i} 1',
        f'scoreboard players operation @s inc.tmp = @s inc.price{i}',
        'scoreboard players operation @s inc.tmp /= #four inc.sys',
        f'scoreboard players operation @s inc.price{i} += @s inc.tmp',
        f'scoreboard players operation @s inc.price{i} < #cap inc.sys',
        f'scoreboard players operation @s inc.rate{i} = @s inc.qty{i}',
        f'scoreboard players operation @s inc.rate{i} *= @s inc.pow{i}',
        f'scoreboard players set @s inc.sel {i}',
        tell([txt('Generador de ' + name + ' comprado. ', 'green'), button('[Menú]', 1)]),
    ])
    fn(base + '/upgrade', [
        f'execute if score @s inc.qty{i} matches 0 run return run ' + tell([txt('Primero compra este generador.', 'red')]),
        f'execute if score @s inc.level{i} matches 10.. run return run ' + tell([txt('Mejora máxima: nivel 10.', 'yellow')]),
        f'execute unless score @s inc.bank{i} >= @s inc.up{i} run return run ' + tell([txt('No tienes suficiente ' + name + ' guardado.', 'red')]),
        f'scoreboard players operation @s inc.bank{i} -= @s inc.up{i}',
        f'scoreboard players operation @s inc.up{i} += @s inc.up{i}',
        f'scoreboard players operation @s inc.pow{i} += @s inc.pow{i}',
        f'scoreboard players add @s inc.level{i} 1',
        f'scoreboard players operation @s inc.rate{i} = @s inc.qty{i}',
        f'scoreboard players operation @s inc.rate{i} *= @s inc.pow{i}',
        tell([txt('Producción y clic de ' + name + ' duplicados. ', 'green'), button('[Menú]', 1)]),
    ])
    fn(base + '/deposit', [
        f'execute store result score @s inc.amount run clear @s minecraft:{item} 0',
        'scoreboard players operation @s inc.space = #cap inc.sys',
        f'scoreboard players operation @s inc.space -= @s inc.bank{i}',
        'scoreboard players operation @s inc.amount < @s inc.space',
        'execute if score @s inc.amount matches 0 run return run ' + tell([txt('No hay objetos que depositar o el almacén está lleno.', 'yellow')]),
        'execute store result storage inc:runtime amount int 1 run scoreboard players get @s inc.amount',
        f'function inc:{base}/deposit_amount with storage inc:runtime',
        f'scoreboard players operation @s inc.bank{i} += @s inc.amount',
        tell([txt('Depositado: ', 'aqua'), score('inc.amount'), txt(' de ' + name + '. '), button('[Menú]', 1)]),
    ])
    fn(base + '/deposit_amount', [f'$execute store result score @s inc.amount run clear @s minecraft:{item} $(amount)'])
    fn(base + '/withdraw', [
        f'execute if score @s inc.bank{i} matches 0 run return run ' + tell([txt('El almacén está vacío.', 'yellow')]),
        f'scoreboard players operation @s inc.amount = @s inc.bank{i}',
        'scoreboard players set @s inc.tmp 64',
        'scoreboard players operation @s inc.amount < @s inc.tmp',
        'execute store result storage inc:runtime amount int 1 run scoreboard players get @s inc.amount',
        f'function inc:{base}/withdraw_amount with storage inc:runtime',
    ])
    fn(base + '/withdraw_amount', [f'$execute store success score @s inc.tmp run give @s minecraft:{item} $(amount)', f'execute if score @s inc.tmp matches 1 run scoreboard players operation @s inc.bank{i} -= @s inc.amount', tell([txt('Retirada solicitada: ', 'aqua'), score('inc.amount'), txt(' de ' + name + '. '), button('[Menú]', 1)])])

fn('warehouse/request', [
    'scoreboard players operation #owner inc.tmp = @s inc.id',
    'scoreboard players operation #kind inc.tmp = @s inc.sel',
    'execute at @s positioned ^ ^ ^2 align xyz if block ~ ~ ~ minecraft:air if block ~ ~1 ~ minecraft:air run return run function inc:warehouse/place',
    tell([txt('Busca dos bloques de aire delante de ti para colocar el almacén.', 'yellow')]),
])
fn('warehouse/place', [
    'execute as @e[tag=inc.storage_part] if score @s inc.owner = #owner inc.tmp if score @s inc.kind = #kind inc.tmp run kill @s',
    'execute summon minecraft:block_display run function inc:warehouse/display',
    'execute positioned ~0.5 ~ ~0.5 summon minecraft:interaction run function inc:warehouse/hitbox',
    'execute positioned ~0.5 ~1.15 ~0.5 summon minecraft:text_display run function inc:warehouse/label',
    tell([txt('Almacén colocado. Clic derecho para abrirlo. ', 'green'), button('[Menú]', 1)]),
])
owner = ['tag @s add inc.storage_part', 'scoreboard players operation @s inc.owner = #owner inc.tmp', 'scoreboard players operation @s inc.kind = #kind inc.tmp']
fn('warehouse/display', owner + ['data merge entity @s {block_state:{Name:"minecraft:barrel",Properties:{facing:"up",open:"false"}}}'])
fn('warehouse/hitbox', owner + ['tag @s add inc.storage', 'data merge entity @s {width:1.0f,height:1.0f,response:1b}'])
fn('warehouse/label', owner + ['data merge entity @s {billboard:"center",background:0,shadow:1b}'] + [f'execute if score @s inc.kind matches {i} run data merge entity @s ' + '{text:' + js(txt('Almacén de ' + name, color)) + '}' for i, (_, name, _, _, color) in enumerate(TIERS)])
fn('warehouse/interact', [
    'scoreboard players operation #owner inc.tmp = @s inc.owner',
    'scoreboard players operation #kind inc.tmp = @s inc.kind',
    'execute on target if score @s inc.id = #owner inc.tmp run function inc:warehouse/open',
    'execute on target unless score @s inc.id = #owner inc.tmp run ' + tell([txt('Este almacén pertenece a otro jugador.', 'yellow')]),
    'data remove entity @s interaction',
])
fn('warehouse/open', ['scoreboard players operation @s inc.sel = #kind inc.tmp', 'function inc:menu'])
fn('warehouse/remove', ['scoreboard players operation #owner inc.tmp = @s inc.id', 'execute at @s as @e[tag=inc.storage_part,distance=..32] if score @s inc.owner = #owner inc.tmp run kill @s', tell([txt('Almacenes cercanos recogidos. Los recursos se conservan.', 'green')])])

# Fail before packaging if a function/tag references a missing resource.
for path in PACK.rglob('*.json'):
    json.loads(path.read_text(encoding='utf-8'))
for path in PACK.rglob('*.mcfunction'):
    for target in re.findall(r'\bfunction inc:([a-z0-9_/]+)', path.read_text(encoding='utf-8')):
        assert (PACK / f'data/inc/function/{target}.mcfunction').exists(), (path, target)
assert all(len(key) <= 16 for key in objectives)
archive = ROOT / 'dist' / 'Incremental-26.3.zip'
archive.parent.mkdir(exist_ok=True)
if (ROOT / 'README.md').exists():
    write('README.md', (ROOT / 'README.md').read_text(encoding='utf-8'))
with zipfile.ZipFile(archive, 'w', zipfile.ZIP_DEFLATED) as zipped:
    for path in sorted(PACK.rglob('*')):
        if path.is_file():
            zipped.write(path, path.relative_to(PACK).as_posix())
print(f'Built {archive}: {len(list(PACK.rglob("*.mcfunction")))} functions')
