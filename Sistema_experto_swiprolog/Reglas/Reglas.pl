:- use_module(library(lists)).

% --- REGLA 1: Verificar seriacion ---
% No puede llevar materia X si no aprobo materia Y
puede_llevar(Alumno, Materia) :-
    forall(
        seriacion(Previa, Materia),
        (cursada(Alumno, Previa, _, Cal),
         Cal >= 70)
    ).

% --- REGLA 2: Carga maxima permitida ---
% No puede cargar mas de 4 materias si promedio < 80 o tiene mas de 1 reprobada
carga_maxima_permitida(Alumno, MaxCarga) :-
    findall(C, cursada(Alumno, _, _, C), Calificaciones),
    sum_list(Calificaciones, Suma),
    length(Calificaciones, Total),
    Total > 0,
    Promedio is Suma / Total,
    findall(M, (cursada(Alumno, M, _, Cal), Cal < 70), Reprobadas),
    length(Reprobadas, NumReprobadas),
    (Promedio >= 80, NumReprobadas =< 1 -> MaxCarga = 4 ; MaxCarga = 3).

% --- REGLA 3: Veces que curso una materia y calificaciones en cada curso ---
veces_cursada(Alumno, Materia, Veces, Calificaciones) :-
    findall([Intento, Cal], cursada(Alumno, Materia, Intento, Cal), Calificaciones),
    length(Calificaciones, Veces).

% --- REGLA 4: Verificar si debe ser dado de baja ---
% Si reprobó 3 veces una materia, debe ser dado de baja
debe_baja(Alumno) :-
    cursada(Alumno, _, Intento, Cal),
    Intento >= 3,
    Cal < 70.

% --- REGLA 5: Alumnos de alto rendimiento ---
% Promedio general >= 90
alumnos_alto_rendimiento(Alumnos) :-
    findall([Id, Nombre], (
        alumno(Id, Nombre),
        findall(C, cursada(Id, _, _, C), Calificaciones),
        sum_list(Calificaciones, Suma),
        length(Calificaciones, Total),
        Total > 0,
        Promedio is Suma / Total,
        Promedio >= 90
    ), Alumnos).

% --- REGLA 6: Materias por semestre ---
materias_por_semestre(Semestre, Materias) :-
    findall(M, semestre(M, Semestre), Materias).

% --- REGLA 7: Aspirantes posibles a un curso ---
% Para abrir un curso, cuantos posibles aspirantes hay
aspirantes_posibles(Materia, Cantidad) :-
    findall(A, (
        alumno(A, _),
        puede_llevar(A, Materia),
        \+ inscrito_actual(A, Materia)
    ), Aspirantes),
    length(Aspirantes, Cantidad).
