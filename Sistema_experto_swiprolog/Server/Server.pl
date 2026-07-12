% Sistema Experto ISC - Servidor HTTP con API REST
% Para ejecutar: swipl -s Server.pl
% Abrir: http://localhost:8080/home
% Detener: http_stop_server(8080, []). luego halt.

:- use_module(library(http/http_server)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_parameters)).
:- use_module(library(http/html_write)).
:- use_module(library(lists)).

% --- Cargar archivos base ---
:- prolog_load_context(directory, ServerDir),
   absolute_file_name('../dominio/Dominio', AbsDom, [relative_to(ServerDir)]),
   absolute_file_name('../Conocimiento/Conocimiento', AbsCon, [relative_to(ServerDir)]),
   absolute_file_name('../Reglas/Reglas', AbsReg, [relative_to(ServerDir)]),
   consult(AbsDom),
   consult(AbsCon),
   consult(AbsReg).

% --- Inicializar servidor en puerto 8080 ---
:- initialization http_server([port(8080)]).

% --- Definir rutas ---
:- http_handler(root(.), home_page, []).
:- http_handler(root(home), home_page, []).
:- http_handler(root(api/puede_llevar), api_puede_llevar, []).
:- http_handler(root(api/carga_maxima), api_carga_maxima, []).
:- http_handler(root(api/historial), api_historial, []).
:- http_handler(root(api/baja), api_baja, []).
:- http_handler(root(api/alto_rendimiento), api_alto_rendimiento, []).
:- http_handler(root(api/materias_por_semestre), api_materias_semestre, []).
:- http_handler(root(api/aspirantes), api_aspirantes, []).

% ================================================
% RUTA: Pagina de inicio
% ================================================
home_page(_Request) :-
    reply_html_page(
        title('Sistema Experto ISC'),
        [
            h1('Sistema Experto - Ingenieria en Sistemas Computacionales'),
            p('Servidor con base de conocimiento y reglas de experto.'),
            h2('Endpoints disponibles:'),
            ul([
                li('GET /api/puede_llevar?alumno=N&materia=X'),
                li('GET /api/carga_maxima?alumno=N'),
                li('GET /api/historial?alumno=N&materia=X'),
                li('GET /api/baja?alumno=N'),
                li('GET /api/alto_rendimiento'),
                li('GET /api/materias_por_semestre?semestre=N'),
                li('GET /api/aspirantes?materia=X')
            ])
        ]
    ).

% ================================================
% API: Puede llevar materia (seriacion)
% ================================================
api_puede_llevar(Request) :-
    http_parameters(Request, [
        alumno(Alumno, [integer]),
        materia(Materia, [atom])
    ]),
    atom_string(Materia, MateriaStr),
    (   puede_llevar(Alumno, Materia)
    ->  reply_json(json([
            alumno=Alumno,
            materia=MateriaStr,
            permitido=true
        ]))
    ;   reply_json(json([
            alumno=Alumno,
            materia=MateriaStr,
            permitido=false,
            razon='No cumple seriacion'
        ]))
    ).

% ================================================
% API: Carga maxima permitida
% ================================================
api_carga_maxima(Request) :-
    http_parameters(Request, [
        alumno(Alumno, [integer])
    ]),
    carga_maxima_permitida(Alumno, MaxCarga),
    reply_json(json([
        alumno=Alumno,
        max_carga=MaxCarga
    ])).

% ================================================
% API: Historial de cursada
% ================================================
api_historial(Request) :-
    http_parameters(Request, [
        alumno(Alumno, [integer]),
        materia(Materia, [atom])
    ]),
    atom_string(Materia, MateriaStr),
    veces_cursada(Alumno, Materia, Veces, Calificaciones),
    reply_json(json([
        alumno=Alumno,
        materia=MateriaStr,
        veces_cursada=Veces,
        calificaciones=Calificaciones
    ])).

% ================================================
% API: Verificar baja
% ================================================
api_baja(Request) :-
    http_parameters(Request, [
        alumno(Alumno, [integer])
    ]),
    (   debe_baja(Alumno)
    ->  reply_json(json([alumno=Alumno, debe_baja=true]))
    ;   reply_json(json([alumno=Alumno, debe_baja=false]))
    ).

% ================================================
% API: Alto rendimiento
% ================================================
api_alto_rendimiento(_Request) :-
    alumnos_alto_rendimiento(Alumnos),
    reply_json(json([alumnos=Alumnos])).

% ================================================
% API: Materias por semestre
% ================================================
api_materias_semestre(Request) :-
    http_parameters(Request, [
        semestre(Semestre, [integer])
    ]),
    materias_por_semestre(Semestre, Materias),
    maplist(atom_string, Materias, MateriasStr),
    reply_json(json([semestre=Semestre, materias=MateriasStr])).

% ================================================
% API: Aspirantes posibles
% ================================================
api_aspirantes(Request) :-
    http_parameters(Request, [
        materia(Materia, [atom])
    ]),
    atom_string(Materia, MateriaStr),
    aspirantes_posibles(Materia, Cantidad),
    reply_json(json([materia=MateriaStr, aspirantes=Cantidad])).
