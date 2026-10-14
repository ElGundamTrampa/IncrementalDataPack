# Incremental  — Java 26.3 · v1.0.0

Generadores físicos que depositan objetos reales en el cofre de debajo. El menú se
utiliza únicamente como tienda: no hay clicker, reservas personales ni barra permanente.
No requiere mods ni resource pack. Datapack format **121.0**.

## Instalación y primeros pasos

1. Copia `dist/Incremental-26.3.zip` a `datapacks` de tu mundo de **Minecraft Java 26.3**.
   También puedes instalar la carpeta `Incremental`, pero no ambas copias.
2. Ejecuta `/reload` con permisos de operador.
3. Recibes una vez un generador de tierra, un cofre profundo y un cofre normal.
4. Coloca el cofre profundo en el suelo con su objeto, agachado. Después coloca el
   generador de tierra encima del cofre, agachado y haciendo clic en su cara superior.
   Deja dos bloques de aire sobre el cofre para colocar el generador.
5. Abre el cofre normalmente: va recibiendo tierra. Puedes retirarla con clic o
   Mayús + clic, depositar pilas y utilizar tolvas.
6. Abre **Tienda de generadores** desde las opciones personalizadas del menú de pausa,
   desde las acciones rápidas, o con `/trigger inc.shop set 1`.

La tienda es una ventana nativa de Minecraft con botones, cuatro categorías y precios.
Las compras funcionan sin ser operador. Pagan primero con objetos de tu inventario y
después con el cofre profundo más cercano de ese material, a un máximo de **8 bloques**.
Así puedes pagar los precios superiores a la capacidad del inventario. Los cofres normales
no se cobran automáticamente: retira sus materiales para pagar con ellos.

## Generadores

Cada máquina produce **un objeto por segundo**. Compra más para aumentar la producción.
Los precios son fijos; se paga con materiales reales, no con puntuaciones del jugador.

| Generador | Precio | Objeto producido |
| --- | ---: | --- |
| Tierra | 16 tierra | Tierra |
| Roble | 256 tierra | Tronco de roble |
| Piedra | 512 roble | Roca (`cobblestone`) |
| Hierro | 1.024 piedra | Lingote de hierro |
| Oro | 2.048 hierro | Lingote de oro |
| Diamante | 4.096 oro | Diamante |
| Netherita | 8.192 diamante | Lingote de netherita |
| Carbón | 128 piedra | Carbón |
| Cobre | 256 piedra | Lingote de cobre |
| Redstone | 256 hierro | Polvo de redstone |
| Lapislázuli | 256 hierro | Lapislázuli |
| Esmeralda | 256 diamante | Esmeralda |
| Obsidiana | 256 diamante | Obsidiana |
| Cuarzo | 128 obsidiana | Cuarzo |
| Piedra luminosa | 256 cuarzo | Bloque de piedra luminosa |
| Bloque de magma | 128 obsidiana | Bloque de magma |
| Linterna marina | 256 esmeralda | Linterna marina |
| Hielo azul | 256 linternas marinas | Hielo azul |
| Lana | 64 roble | Lana blanca, que se puede teñir |
| Hilo | 64 lana | Hilo |
| Bloque de slime | 256 hilo | Bloque de slime |

Los otros doce generadores de madera cuestan **256 troncos de roble** cada uno:
abeto, abedul, jungla, acacia, roble oscuro, mangle, cerezo, roble pálido, álamo,
carmesí, distorsionada y bambú. Generan el tronco, tallo o bloque de bambú de su
tipo. Puedes transformarlos en las correspondientes tablas y otras variantes.
En total hay **33 tipos de generadores**. El cobre está incluido una sola vez.

El generador tiene una base de cristal con un bloque del material dentro. Es un bloque
rompible y permite abrir el cofre inferior. Rompe el cristal para recuperar el generador;
su objeto aparece en hasta un segundo. Si lo colocas fuera de un cofre, se devuelve.
Si quitas el cofre inferior, el generador se pausa hasta que pongas otro.

Funcionan sobre cofres normales, cofres trampa y cofres profundos. Con un cofre doble
llenan la mitad situada directamente debajo. Un cofre normal lleno detiene la producción:
no sustituye sus objetos ni tira la producción al suelo. Las máquinas funcionan mientras
sus chunks estén cargados y el mundo avance, incluso si su comprador no está conectado.

## Cofre profundo: un material y grandes cantidades

Es un cofre físico que se abre con la interfaz normal de cofres. Su reserva interna
admite **1.000.000.000 unidades**, además de los objetos visibles que quepan en el cofre.
No es literalmente infinito. El primer material depositado o generado fija su tipo.
Acepta los 33 materiales del catálogo; los objetos de otro tipo o con componentes
especiales se expulsan al suelo intactos. El filtrado y la reposición ocurren cada segundo.

Mantiene una pila de hasta 64 en la primera casilla. Cuando la retiras, repone otra desde
la reserva. Al depositar pilas normales del mismo material, las incorpora a la reserva.
El texto sobre el cofre muestra su material y total antes de reponer la pila visible.
Las tolvas también pueden introducir y extraer objetos normalmente.

Al romperlo, los objetos visibles caen como en un cofre normal y recibes un objeto
«Cofre profundo recuperado» que conserva la reserva interna. Recógelo y vuelve a
colocarlo para recuperarla. **Guarda ese objeto**: si se quema o desaparece, pierdes
la posibilidad de recuperar su reserva en supervivencia. Los cofres no son privados;
cualquier jugador cercano puede abrirlos y pagar desde ellos.

Mantén cada cofre profundo separado, sin unirlo a otro cofre doble, para que su interfaz
represente una única reserva. También conserva un tipo mientras esté vacío; para otro
material compra un cofre profundo nuevo por 64 lingotes de hierro.

## Picado de piedra negra, basalto y pizarra profunda

Se iguala el progreso de picado con el de **piedra normal**, usando la misma herramienta,
Eficiencia, Prisa y condiciones ambientales. Incluye los tres basaltos y las variantes
de construcción de piedra negra y pizarra profunda. No cambia las menas de pizarra profunda.

La piedra negra natural ya tiene la misma dureza que la piedra. Basalto es algo menos
duro, por lo que igualarlo a piedra implica ralentizarlo ligeramente. Pizarra profunda
y las variantes más duras reciben el multiplicador correspondiente a su dureza real.

Se aplica un modificador temporal mientras miras estos bloques, dentro del alcance
normal de supervivencia, y se retira al mirar otros. No se modifican los picos ni sus
encantamientos. Al mirar a través de bloques de forma parcial, el muestreo puede detenerse
en ese bloque: está pensado principalmente para bloques completos al excavar chunks.
Antes de desactivar el datapack, retira su modificador con
`/execute as @a run function inc:mining/clear`.

## Actualización desde v0.1

Sustituye el ZIP anterior y ejecuta `/reload`. Se eliminan los barriles visuales antiguos
cuando sus chunks estén cargados y recibes el nuevo equipo inicial una sola vez.
Los antiguos contadores se conservan para recuperarlos manualmente: un operador puede
ejecutar `/execute as NOMBRE run function inc:legacy/claim` para entregar hasta 64 de cada
reserva antigua. Repite hasta vaciarlas; no se generan miles de objetos automáticamente.

## Desarrollo y validación

`python tools/build.py` reconstruye las funciones, recursos y el ZIP. Edita ese archivo,
no las funciones generadas. `tools/Validate.java` usa el JAR y las bibliotecas de tu
instalación de 26.3 para compilar funciones y macros, decodificar las tablas de botín y
los diálogos, comprobar las durezas reales y probar la inserción en contenedores.

Las pruebas del motor incluyen cofres vacíos, pilas parciales, cofres llenos y objetos
renombrados, además del formato NBT de los objetos y la normalización del picado.
Resultado: **418 funciones y 72 tablas de botín/diálogos válidos, sin errores**.
No sustituyen una prueba de juego de colocación, tolvas, recuperación
del cofre profundo y multijugador. No se han abierto ni modificado tus mundos.

La versión 0.2.1 corrige la colocación sobre la tapa del cofre y mueve el texto al
frente para que no bloquee la colocación del generador. Sustituye el ZIP y ejecuta
`/reload`: los cofres profundos existentes se corrigen al cargar sus chunks y los
generadores que ya tengas en el inventario siguen sirviendo.

Los diálogos nativos y el formato del pack se documentan en las notas oficiales de
[Java 1.21.6](https://www.minecraft.net/en-us/article/minecraft-java-edition-1-21-6) y
[Java 26.3](https://www.minecraft.net/en-us/article/minecraft-java-edition-26-3).
