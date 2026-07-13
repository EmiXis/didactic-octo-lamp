# Sistema Experto para la Elección de Cursos - ISC

Este sistema experto, desarrollado en **SWI-Prolog**, actúa como un asistente para alumnos, tutores y gestores del programa educativo de Ingeniería en Sistemas Computacionales (ISC). El sistema evalúa el historial académico del estudiante, controla la seriación de materias y detecta alertas escolares exponiendo los resultados mediante una API HTTP con 7 endpoints en formato JSON.

## Estructura del Proyecto
* `/baseconocimiento/base_conocimiento.pl`: Base de datos con las materias, seriación de ISC e historial de calificaciones.
* `/servidor/servidor.pl`: Servidor web HTTP y definición de los 7 manejadores de rutas.

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

Una vez encendido el servidor, puedes realizar las consultas desde tu navegador web o cliente HTTP utilizando las siguientes rutas dedicadas:


1. Mostrar las materias por semestre y por áreaURL: http://localhost:8080/materiasDescripción: Devuelve la lista completa de las materias cargadas en el sistema, organizadas por su semestre correspondiente y su área de conocimiento.2. Validación de Seriación AcadémicaURL: http://localhost:8080/validar_seriacion?matricula=202602&materia=mat
   
2. Descripción: Valida si un alumno cumple con los requisitos lógicos para cursar una materia (por ejemplo, no puede llevar Matemáticas II si no aprobó Matemáticas I).

3. Restricción de Carga Máxima por AprovechamientoURL: http://localhost:8080/limite_carga?matricula=202602Descripción: Restringe la carga a un máximo de 4 materias si el promedio general del alumno es menor a 80 o si cuenta con más de una materia reprobada en su historial.

4. Contador de Oportunidades e Historial DetalladoURL: http://localhost:8080/historial_alumno?matricula=202602Descripción: Indica de forma desglosada cuántas veces el alumno ha cursado cada materia y las calificaciones obtenidas en cada curso.
   
5. Verificación de Alumnos Candidatos a BajaURL: http://localhost:8080/verificar_baja?matricula=202603Descripción: Identifica y reporta si el alumno debe ser dado de baja del programa educativo por haber reprobado 3 veces una misma materia.

6. Reporte de Alumnos de Alto RendimientoURL: http://localhost:8080/
alto_rendimientoDescripción: Encuentra y lista a los estudiantes destacados que cuentan con un promedio general acumulado mayor o igual a 90 ($\ge 90$).

7. Aspirantes Potenciales para Apertura de un CursoURL: http://localhost:8080/aspirantes_curso?materia=prog2Descripción: Analiza la plantilla escolar y calcula el total de aspirantes idóneos para abrir un curso específico (alumnos que no lo han aprobado pero que ya cubrieron su seriación previa).

Tecnologías UtilizadasSWI-Prolog (Motor lógico y Servidor HTTP)Markdown (Documentación técnica del proyecto)