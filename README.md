# ase251s3_massielGomez_be

## Descripción
API REST con Spring Boot que implementa un endpoint GET que retorna "¡Hola Mundo!"

## Pasos que seguí

Entré a Spring Initializr.

Configuré el proyecto con Maven, Java 17 y agregué la dependencia Spring Web.

Descargué y abrí el proyecto en mi IDE.

Creé una clase llamada HolaController.

Agregué @RestController para indicar que es un controlador web.

Creé el endpoint con @GetMapping("/hola").

Hice un método que devuelve el texto "Hola Mundo!".

Ejecuté la aplicación y probé en el navegador:
http://localhost:8080/hola
