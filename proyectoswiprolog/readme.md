# Sistema Experto para la Elección de Cursos - ISC

Este sistema experto, desarrollado en **SWI-Prolog**, actúa como un asistente para alumnos, tutores y gestores del programa educativo de Ingeniería en Sistemas Computacionales (ISC). El sistema evalúa el historial académico del estudiante, controla la seriación de materias, detecta alertas escolares (bajas o alto rendimiento) y expone los resultados mediante un servidor HTTP con endpoints en formato JSON.

## Estructura del Proyecto
* `/baseconocimiento/base_conocimiento.pl`: Base de datos con las materias, seriación de ISC e historial de calificaciones.
* `/servidor/servidor.pl`: Servidor web HTTP y definición de los endpoints de consulta.

---

## Instrucciones de Ejecución

1. Abre tu terminal (Git Bash o terminal de VS Code) y colócate en la carpeta del servidor:
   ```bash
   cd servidor


Inicia SWI-Prolog cargando el archivo del servidor:

Bash
swipl servidor.pl
En la consola interactiva de Prolog (?-), levanta el servidor web ejecutando:

Prolog
?- iniciar_servidor(8080).

Guía de Endpoints y Criterios EvaluadosUna vez encendido el servidor, puedes realizar las consultas desde tu navegador web o cliente HTTP utilizando las siguientes rutas:

1. Mapa Curricular (Materias por Semestre y Área)URL: http://localhost:8080/materiasDescripción: Muestra la lista completa de las materias cargadas en el sistema, organizadas por su semestre correspondiente y su área de conocimiento.

2. Historial, Restricciones de Carga y Bajas por AlumnoURL: http://localhost:8080/alumno?matricula=202602Criterios que resuelve:Muestra cuántas veces se ha cursado una materia y sus respectivas calificaciones.Valida que no pueda cargar más de 4 materias si su promedio general es menor a 80 o si cuenta con más de una materia reprobada (de lo contrario, permite hasta 7).URL para Caso de Baja: http://localhost:8080/alumno?matricula=202603Criterios que resuelve: Determina e indica con un estado de alerta (dado_de_baja: true) si el alumno reprobó 3 veces una misma materia.

3. Alumnos de Alto RendimientoURL: http://localhost:8080/altorendimientoDescripción: Filtra y devuelve la lista de todas las matrículas de los alumnos que mantienen un promedio general mayor o igual a 90 ($\ge 90$).

4. Aspirantes Potenciales para Apertura de CursosURL: http://localhost:8080/aspirantes?materia=prog2Criterios que resuelve: Analiza la base de datos completa y calcula cuántos alumnos son candidatos aptos para abrir un curso específico (aquellos que ya aprobaron el prerrequisito por seriación y que aún no han acreditado la materia en cuestión).

Tecnologías UtilizadasSWI-Prolog (Lógica y Servidor HTTP)Markdown (Documentación)