% ============================================
% conocimiento.pl - Base de Conocimiento
% ============================================

% --- ALUMNOS ---
% alumno(Id, NombreCompleto)
alumno(1, 'Juan Perez Lopez').
alumno(2, 'Maria Garcia Ruiz').
alumno(3, 'Carlos Hernandez Sanchez').
alumno(4, 'Ana Martinez Diaz').
alumno(5, 'Pedro Lopez Torres').
alumno(6, 'Laura Sanchez Mendez').
alumno(7, 'Miguel Rodriguez Cruz').
alumno(8, 'Sofia Flores Nunez').
alumno(9, 'Diego Ramirez Solis').
alumno(10, 'Elena Torres Gutierrez').

% --- CURSADA (Historial academico) ---
% cursada(IdAlumno, Materia, Intento, Calificacion)
%   Intento: numero de vez que curso la materia (1, 2, 3...)
%   Calificacion: 0-100 (70 es minimo para aprobar)

% Juan Perez - Buen alumno (promedio ~88)
cursada(1, programacion_i, 1, 90).
cursada(1, programacion_ii, 1, 85).
cursada(1, algebra_lineal, 1, 88).
cursada(1, base_de_datos_i, 1, 92).
cursada(1, matematicas_discretas, 1, 82).

% Maria Garcia - Regular (promedio ~75)
cursada(2, programacion_i, 1, 70).
cursada(2, programacion_ii, 1, 75).
cursada(2, algebra_lineal, 1, 72).
cursada(2, base_de_datos_i, 1, 78).
cursada(2, matematicas_discretas, 1, 68).
cursada(2, matematicas_discretas, 2, 74).

% Carlos Hernandez - Reprobo 3 veces (debe baja)
cursada(3, programacion_i, 1, 65).
cursada(3, programacion_i, 2, 60).
cursada(3, programacion_i, 3, 55).

% Ana Martinez - Alto rendimiento (promedio >=90)
cursada(4, programacion_i, 1, 95).
cursada(4, programacion_ii, 1, 98).
cursada(4, algebra_lineal, 1, 92).
cursada(4, base_de_datos_i, 1, 97).
cursada(4, fisica_para_computacion, 1, 91).
cursada(4, matematicas_discretas, 1, 94).

% Pedro Lopez - Recien entrado (pocos cursos)
cursada(5, programacion_i, 1, 80).

% Laura Sanchez - Promedio regular, materia pendiente
cursada(6, programacion_i, 1, 78).
cursada(6, programacion_ii, 1, 72).
cursada(6, algebra_lineal, 1, 65).
cursada(6, algebra_lineal, 2, 70).

% Miguel Rodriguez - Buen alumno en programacion
cursada(7, programacion_i, 1, 88).
cursada(7, programacion_ii, 1, 90).
cursada(7, algebra_lineal, 1, 75).
cursada(7, base_de_datos_i, 1, 85).
cursada(7, matematicas_discretas, 1, 80).
cursada(7, fisica_para_computacion, 1, 78).

% Sofia Flores - Reprobo dos veces, ahora aprueba
cursada(8, programacion_i, 1, 60).
cursada(8, programacion_i, 2, 72).
cursada(8, algebra_lineal, 1, 68).
cursada(8, algebra_lineal, 2, 75).

% Diego Ramirez - Excelente en matematicas
cursada(9, programacion_i, 1, 85).
cursada(9, programacion_ii, 1, 82).
cursada(9, algebra_lineal, 1, 95).
cursada(9, matematicas_discretas, 1, 92).
cursada(9, fisica_para_computacion, 1, 88).
cursada(9, calculo_diferencial, 1, 90).
cursada(9, base_de_datos_i, 1, 87).

% Elena Torres - Reprobo una materia dos veces
cursada(10, programacion_i, 1, 70).
cursada(10, programacion_ii, 1, 65).
cursada(10, programacion_ii, 2, 72).
cursada(10, algebra_lineal, 1, 78).
cursada(10, base_de_datos_i, 1, 80).

% --- INSCRITOS ACTUALMENTE ---
% inscrito_actual(IdAlumno, Materia)
inscrito_actual(1, estructuras_de_datos).
inscrito_actual(1, bases_de_datos_ii).
inscrito_actual(2, estructuras_de_datos).
inscrito_actual(4, estructuras_de_datos).
inscrito_actual(4, calculo_diferencial).
inscrito_actual(4, fisica_para_computacion).
inscrito_actual(5, programacion_ii).
inscrito_actual(6, estructuras_de_datos).
inscrito_actual(7, estructuras_de_datos).
inscrito_actual(7, bases_de_datos_ii).
inscrito_actual(7, fisica_para_computacion).
inscrito_actual(9, estructuras_de_datos).
inscrito_actual(9, calculo_integral).
inscrito_actual(10, estructuras_de_datos).
