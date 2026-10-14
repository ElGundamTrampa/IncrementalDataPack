# Incremental — Minecraft Java 26.3

Primera versión de un clicker con una cadena de materiales y almacenes personales.
No requiere mods ni un resource pack.

## Instalación

1. Copia `dist/Incremental-26.3.zip` en la carpeta `datapacks` de tu mundo.
   También puedes copiar la carpeta `Incremental` completa, sin el ZIP.
2. Entra con Minecraft **Java 26.3** y ejecuta `/reload` con permisos de operador.
3. Abre el menú con `/trigger inc.ui set 1`.

Después de instalarlo, los jugadores pueden utilizar todas las opciones del menú
sin permisos de operador. No instales la carpeta y el ZIP a la vez.

## Cómo jugar

Empiezas con un generador de tierra que produce **1 tierra por segundo**.
La herramienta «Generador incremental» permite generar más con clic derecho:
produce el material seleccionado, con un máximo de cuatro clics por segundo.
Puedes recuperarla desde el menú si la pierdes.

| Generador | Coste inicial | Material real que se puede retirar |
| --- | ---: | --- |
| Tierra adicional | 16 de tierra | Tierra |
| Madera | 256 de tierra | Tronco de roble |
| Piedra | 512 de madera | Roca (`cobblestone`) |
| Hierro | 1.024 de piedra | Lingote de hierro |
| Oro | 2.048 de hierro | Lingote de oro |
| Diamante | 4.096 de oro | Diamante |
| Netherita | 8.192 de diamante | Lingote de netherita |

Comprar un generador añade una unidad de producción por segundo y selecciona
su material. Cada compra encarece el siguiente generador de ese material un 25 %,
redondeando hacia abajo. Puedes tener hasta 50 de cada tipo.

Las mejoras se pagan con el propio material: empiezan en 32 unidades y duplican
su precio cada vez. Cada mejora duplica la producción de todos los generadores de
ese material y la cantidad por clic. Hay diez mejoras por material.

Todos los niveles desbloqueados producen a la vez. La producción funciona mientras
el jugador está conectado y el mundo avanza; no genera durante una pausa ni calcula
producción de tiempo desconectado. Los recursos y las mejoras se conservan al morir,
salir y ejecutar `/reload`.

## Almacenes de un solo material

Cada jugador tiene siete reservas, una por material. Los generadores envían ahí su
producción. Las compras y mejoras gastan recursos de estas reservas.

- **Depositar** convierte los objetos reales de tu inventario en unidades guardadas.
  Solo acepta el objeto exacto de la tabla: otros tipos de troncos y piedra no sirven.
- **Retirar 64** entrega hasta una pila de objetos reales y descuenta esa cantidad.
  Si no tienes espacio, Minecraft deja los objetos en el suelo: recógelos.
- **Colocar almacén** crea un barril visible del material seleccionado delante de ti.
  Deja dos bloques de aire delante. Clic derecho abre el menú de sus reservas.
- Cada barril representa un solo material. Otro jugador no puede acceder a tu reserva.
- Puedes recoger tus almacenes a 32 bloques desde el menú. Retirarlos o volver a
  colocarlos conserva todos los recursos. Puedes acceder a la reserva desde el menú
  aunque el barril esté lejos.

Estos barriles usan entidades `block_display` e `interaction`; su interfaz es el menú
del chat y no las 27 casillas de un barril normal. No tienen colisión ni se rompen
como un bloque normal. La reserva se guarda en el scoreboard, no en las casillas.
Cada material admite **1.000.000.000 unidades por jugador**. Al alcanzar el límite,
la producción adicional se descarta; los depósitos solo consumen los objetos que caben.

El depósito toma todos los objetos del tipo indicado, incluidos los renombrados o
con componentes especiales. Al retirarlos se entregan objetos normales. No deposites
un objeto especial que quieras conservar con sus componentes.

## Controles

| Comando | Acción |
| --- | --- |
| `/trigger inc.ui set 1` | Menú completo |
| `/trigger inc.ui set 2` | Generar material seleccionado |
| `/trigger inc.ui set 3` | Recuperar herramienta |
| `/trigger inc.ui set 4` | Mostrar u ocultar la barra de estado |
| `/trigger inc.ui set 60` | Colocar almacén del material seleccionado |
| `/trigger inc.ui set 61` | Recoger tus almacenes cercanos |

El menú ofrece botones para seleccionar, comprar, mejorar, depositar y retirar cada
material. Los números son unidades de recursos, no puntos abstractos. La barra de estado
puede competir con la de otros datapacks; puedes ocultarla.

## Desarrollo y comprobación

`python tools/build.py` genera las funciones y el ZIP. La configuración de materiales,
costes y textos está en `tools/build.py`; edita ese archivo y vuelve a generar el pack.

El formato 121.0 se comprobó tanto en las
[notas oficiales de Java 26.3](https://www.minecraft.net/en-us/article/minecraft-java-edition-26-3)
como en `version.json` del JAR instalado.

`tools/Validate.java` permite compilar las funciones con el parser de comandos de esa
instalación, incluidas las macros de depósito y retirada. No arranca un servidor ni
modifica mundos. Resultado de esta versión: **75 funciones válidas, sin errores**,
incluidas las macros instanciadas con cantidades reales.
La comprobación del parser no sustituye una prueba jugable: conviene
probar la interacción con los barriles, las retiradas con inventario lleno y el acceso
con dos jugadores dentro de Minecraft.
