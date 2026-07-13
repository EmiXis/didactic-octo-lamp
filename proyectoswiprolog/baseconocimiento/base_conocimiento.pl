:- encoding(utf8).

% ==========================================
%  MATERIAS (id, Nombre, Semestre, Area)
% ==========================================
materia(mat1, 'Matematicas I', 1, ciencias_basicas).
materia(prog1, 'Programacion I', 1, programacion).
materia(mat2, 'Matematicas II', 2, ciencias_basicas).
materia(prog2, 'Programacion II', 2, programacion).
materia(edd, 'Estructuras de Datos', 3, programacion).
materia(bd1, 'Base de Datos I', 4, ciencias_ingenieria).

% ==========================================
%  SERIACIÓN (Materia, MateriaPrerrequisito)
% ==========================================
seriacion(mat2, mat1).  
seriacion(prog2, prog1).
seriacion(edd, prog2).

% ==========================================
%  HISTORIAL DE ALUMNOS
%  historial(Matricula, IdMateria, NumOportunidad, Calificacion)
% ==========================================
% Alumno 1: Daniela (Alto rendimiento)
historial('202601', mat1, 1, 95).
historial('202601', prog1, 1, 92).

% Alumno 2: Juan (Promedio bajo < 80 y materias reprobadas)
historial('202602', mat1, 1, 75).
historial('202602', prog1, 1, 50). 
historial('202602', prog1, 2, 72). 

% Alumno 3: Pedro (Caso de baja: Reprobo 3 veces prog1)
historial('202603', prog1, 1, 45).
historial('202603', prog1, 2, 55).
historial('202603', prog1, 3, 50).

% ==========================================
%  REGLAS LÓGICAS DEL SISTEMA EXPERTO
% ==========================================

% Saber si aprobó una materia (>= 70)
aprobo_materia(Matricula, IdMateria) :-
    historial(Matricula, IdMateria, _, Cal),
    Cal >= 70.

% Validar seriación para una materia
puede_llevar_por_seriacion(Matricula, IdMateria) :-
    seriacion(IdMateria, Pre) -> aprobo_materia(Matricula, Pre) ; true.

% Calcular promedio general
promedio_general(Matricula, Promedio) :-
    findall(Cal, (materia(Id,_,_,_), findall(C, historial(Matricula, Id, _, C), Cals), max_list([0|Cals], Cal), Cal > 0), ListaCals),
    length(ListaCals, Cantidad),
    Cantidad > 0,
    sum_list(ListaCals, Suma),
    Promedio is Suma / Cantidad.

% Contar reprobadas actuales
materias_reprobadas_actuales(Matricula, Cantidad) :-
    findall(Id, (materia(Id,_,_,_), findall(C, historial(Matricula, Id, _, C), Cals), max_list([0|Cals], Max), Max < 70, Max > 0), Lista),
    length(Lista, Cantidad).

% Evaluar si excede o no el límite de carga académica (4 materias maximo si cumple condición)
restriccion_carga(Matricula, MaxMaterias) :-
    promedio_general(Matricula, Prom),
    materias_reprobadas_actuales(Matricula, Rep),
    (Prom < 80 ; Rep > 1) -> MaxMaterias = 4 ; MaxMaterias = 7.

% Verificar si debe ser dado de baja (3 oportunidades reprobadas)
debe_ser_dado_de_baja(Matricula) :-
    historial(Matricula, _, 3, Cal),
    Cal < 70.

% Encontrar alumnos de alto rendimiento
alto_rendimiento(Matricula, Promedio) :-
    promedio_general(Matricula, Promedio),
    Promedio >= 90.

% Encontrar aspirantes a un curso
aspirantes_curso(IdMateria, TotalAspirantes) :-
    materia(IdMateria, _, _, _),
    findall(Matricula, (historial(Matricula,_,_,_), \+ aprobo_materia(Matricula, IdMateria), puede_llevar_por_seriacion(Matricula, IdMateria)), ListaUnica),
    sort(ListaUnica, ListaFiltrada),
    length(ListaFiltrada, TotalAspirantes).