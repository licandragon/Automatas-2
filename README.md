# Proyecto Automatas 2: Bot de refaccionaria
Autor: Justino Daniel Guerrero Rivera

Estado: Borrador

Ultima actualización: 2024-05-24

## Contenido
- Objetivo
- Metas
- Metas no prioritarias
- Dependencias y sus versiones
- Descripcion a Alto Nivel
- Detalles de Diseño


## Objetivo
Se pretende crear un bot de Telegram que ayuden en la cotiazacion de la refacción que requiera el cliente sin la necesidad de ir directamente a refaccionaria, se limitara el alcance a solo refacciones para tractocamiones de la marca Kenworth, en futuro se podria amplear a otras marcas.


### Metas
- Diseño e implemtacion de bot
  - se crearan varios comandos que ayuden para la busqueda especificas
    - ofrecer opciones a elegir en caso de contar con mas de un resultados.
  - Boton par ver promociones existentes (pendiente)
- Diseñar la base de datos

## Metas no prioritarias
- Interaccion con inteligencia artificial (IA) y reconocimiento de piezas por imgenes
- Compras dentro del bot, dependiendo de lo avanzado del proyecto se va a considerar integrar las compras de momento solo es consulta e interaccion con el bot.

## Dependencias y sus versiones
_Para este proyecto se utilizo los siguientes:_
- **Python 3.10.11**
  - python-telegram-bot V21.2, dependencia adicional ***"python-telegram-bot[job-queue]"***
  - mysql-connector-python
  >pip install -r requeriment.txt

-MariaDB 10.4.32 en servidor Apache o XAMPP 8.2.12 / PHP 8.2.12
  
## Descripcion General a Alto Nivel
El bot se realizara en Python con la liberia para telegram **[python-telegram-bot](https://python-telegram-bot.org/)**, para poder implementar el bot es requierido crearlo desde el bot de telegram **[@botFather](https://telegram.me/BotFather)** y contar con la llave secreta para poder programar al bot.

Sera necesario crear una base de datos donde donde estara alamcenada la informacion las refacciones y promociones.
 
## Detalles del Diseño
_**1. Interfaz de Usuario**: bot de telegram con el que el usuario va a interactuar, contara con botones para comandos y navegacion entre resultados_

_**2. Base de datos**: fuente donde se consultara los datos de las busqeudas_

