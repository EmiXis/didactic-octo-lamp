% --- MATERIAS POR SEMESTRE ---
% semestre(Materia, NumeroSemestre)

% Primer Semestre

semestre(tecnologias_y_manejo_de_la_informacion, 1).
semestre(la_empresa_y_su_entorno, 1).
semestre(razonamiento_logico, 1).
semestre(programacion_i, 1).
semestre(quimica_general, 1).
semestre(taller_de_comunicacion_oral_y_escrita, 1).

% Segundo Semestre

semestre(desarrollo_sustentable, 2).
semestre(algebra_lineal, 2).
semestre(matematicas_discretas, 2).
semestre(programacion_ii, 2).
semestre(base_de_datos_i, 2).
semestre(fisica_para_computacion, 2).

% Tercer Semestre

semestre(ingles_i, 3).
semestre(calculo_diferencial, 3).
semestre(contabilidad_financiera, 3).
semestre(estructuras_de_datos, 3).
semestre(bases_de_datos_ii, 3).
semestre(sistemas_operativos_i, 3).

% Cuarto Semestre

semestre(ingles_ii, 4).
semestre(calculo_integral, 4).
semestre(programacion_orientada_a_objetos, 4).
semestre(costos_y_presupuestos, 4).
semestre(probabilidad_y_estadistica, 4).
semestre(sistemas_electricos_y_electronicos, 4).

% Quinto Semestre

semestre(ingles_iii, 5).
semestre(teoria_de_senales, 5).
semestre(programacion_visual, 5).
semestre(analisis_y_diseno_de_sistemas_i, 5).
semestre(redes_de_computadoras_i, 5).
semestre(sistemas_digitales, 5).
semestre(taller_de_diseno, 5).

% Sexto Semestre

semestre(ingles_iv, 6).
semestre(emprendedores, 6).
semestre(investigacion_de_operaciones, 6).
semestre(optativo_i, 6).
semestre(lenguaje_ensamblador, 6).
semestre(analisis_y_diseno_de_sistemas_ii, 6).
semestre(arquitectura_de_computadoras, 6).

% Septimo Semestre

semestre(actividades_de_formacion_integral, 7).
semestre(taller_emprendedor, 7).
semestre(programacion_de_metodos_numericos, 7).
semestre(optativo_ii, 7).
semestre(diseno_de_interfaces, 7).
semestre(ingenieria_de_software, 7).
semestre(practicas_profesionales, 7).

% Octavo Semestre

semestre(sistemas_cliente_servidor_i, 8).
semestre(aplicaciones_con_bases_de_datos, 8).
semestre(compiladores_y_ensambladores, 8).
semestre(optativo_iii, 8).
semestre(laboratorio_de_interfaces_de_usuario, 8).

% Noveno Semestre

semestre(sistemas_cliente_servidor_ii, 9).
semestre(implantacion_y_capacitacion, 9).
semestre(programacion_avanzada, 9).
semestre(optativo_iv, 9).
semestre(servicio_social, 9).

% --- SERIACION (PRERREQUISITOS) ---
% seriacion(MateriaPrevia, MateriaRequerida)
% "Para llevar MateriaRequerida, primero debes aprobar MateriaPrevia"

seriacion(programacion_i, programacion_ii).
seriacion(programacion_ii, estructuras_de_datos).
seriacion(programacion_ii, programacion_orientada_a_objetos).
seriacion(algebra_lineal, programacion_de_metodos_numericos).
seriacion(matematicas_discretas, programacion_de_metodos_numericos).
seriacion(fisica_para_computacion, sistemas_electricos_y_electronicos).
seriacion(calculo_diferencial, calculo_integral).
seriacion(ingles_i, ingles_ii).
seriacion(ingles_ii, ingles_iii).
seriacion(ingles_iii, ingles_iv).
seriacion(programacion_orientada_a_objetos, programacion_visual).
seriacion(sistemas_digitales, arquitectura_de_computadoras).
seriacion(diseno_de_interfaces, laboratorio_de_interfaces_de_usuario).
seriacion(sistemas_cliente_servidor_i, sistemas_cliente_servidor_ii).