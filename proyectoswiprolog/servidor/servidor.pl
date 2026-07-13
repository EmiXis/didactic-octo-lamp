:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_parameters)).

% Ruta relativa corregida para cargar la base de conocimiento
:- consult('../baseconocimiento/base_conocimiento.pl').

% ==========================================
%  DECLARACIÓN DE LOS 7 ENDPOINTS
% ==========================================
:- http_handler(root(materias), endpoint_materias, []).                     % Endpoint 1
:- http_handler(root(validar_seriacion), endpoint_validar_seriacion, []).   % Endpoint 2
:- http_handler(root(limite_carga), endpoint_limite_carga, []).             % Endpoint 3
:- http_handler(root(historial_alumno), endpoint_historial_alumno, []).     % Endpoint 4
:- http_handler(root(verificar_baja), endpoint_verificar_baja, []).         % Endpoint 5
:- http_handler(root(alto_rendimiento), endpoint_alto_rendimiento, []).     % Endpoint 6
:- http_handler(root(aspirantes_curso), endpoint_aspirantes_curso, []).     % Endpoint 7

% Iniciar servidor
iniciar_servidor(Puerto) :-
    http_server(http_dispatch, [port(Puerto)]),
    format('Servidor activo con los 7 endpoints en el puerto ~d~n', [Puerto]).

% ==========================================
%  MANEJADORES DE ENDPOINTS
% ==========================================

% 1. Mostrar las materias por semestre y por área
% URL: http://localhost:8080/materias
endpoint_materias(_Request) :-
    findall(json([id=Id, nombre=Nom, semestre=Sem, area=Area]), materia(Id, Nom, Sem, Area), Lista),
    reply_json(Lista).

% 2. Verificar seriación (Ej: Saber si puede llevar mat2 si aprobó mat1)
% URL: http://localhost:8080/validar_seriacion?matricula=202602&materia=mat2
endpoint_validar_seriacion(Request) :-
    http_parameters(Request, [matricula(Mat, [atom]), materia(MatId, [atom])]),
    (   puede_llevar_por_seriacion(Mat, MatId)
    ->  reply_json(json([matricula=Mat, materia=MatId, acceso_permitido=true, motivo='Cumple con la seriacion o no tiene prerrequisitos']))
    ;   reply_json(json([matricula=Mat, materia=MatId, acceso_permitido=false, motivo='Bloqueado por seriacion: No aprobo el prerrequisito']))
    ).

% 3. Validar límite de carga académica (< 80 promedio o > 1 reprobada = 4 materias)
% URL: http://localhost:8080/limite_carga?matricula=202602
endpoint_limite_carga(Request) :-
    http_parameters(Request, [matricula(Mat, [atom])]),
    (   promedio_general(Mat, Prom)
    ->  restriccion_carga(Mat, Max),
        reply_json(json([matricula=Mat, promedio_general=Prom, maximo_materias_permitidas=Max]))
    ;   reply_json(json([error='Alumno no encontrado']), [status(404)])
    ).

% 4. Indicar cuántas veces ha cursado una materia y las calificaciones obtenidas
% URL: http://localhost:8080/historial_alumno?matricula=202602
endpoint_historial_alumno(Request) :-
    http_parameters(Request, [matricula(Mat, [atom])]),
    findall(json([materia=IdM, oportunidad=Op, calificacion=Cal]), historial(Mat, IdM, Op, Cal), Historial),
    (   Historial \= []
    ->  reply_json(json([matricula=Mat, historial=Historial]))
    ;   reply_json(json([error='Sin historial para esta matricula']), [status(404)])
    ).

% 5. Indicar si el alumno debe ser dado de baja (reprobó 3 veces una materia)
% URL: http://localhost:8080/verificar_baja?matricula=202603
endpoint_verificar_baja(Request) :-
    http_parameters(Request, [matricula(Mat, [atom])]),
    (   debe_ser_dado_de_baja(Mat)
    ->  reply_json(json([matricula=Mat, estatus='BAJA REQUERIDA', motivo='Reprobo una materia 3 veces']))
    ;   reply_json(json([matricula=Mat, estatus='REGULAR', motivo='Ninguna materia cuenta con 3 recursamientos reprobados']))
    ).

% 6. Encontrar a los alumnos de alto rendimiento (promedio >= 90)
% URL: http://localhost:8080/alto_rendimiento
endpoint_alto_rendimiento(_Request) :-
    findall(json([matricula=Mat, promedio=Prom]), alto_rendimiento(Mat, Prom), Lista),
    reply_json(Lista).

% 7. Decirme cuántos posibles aspirantes hay para abrir un curso en particular
% URL: http://localhost:8080/aspirantes_curso?materia=prog2
endpoint_aspirantes_curso(Request) :-
    http_parameters(Request, [materia(MatId, [atom])]),
    (   materia(MatId, NombreMat, _, _)
    ->  aspirantes_curso(MatId, Total),
        reply_json(json([materia=MatId, nombre=NombreMat, total_posibles_aspirantes=Total]))
    ;   reply_json(json([error='Materia no existente']), [status(404)])
    ).