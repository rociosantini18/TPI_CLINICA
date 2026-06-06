# PROMEDIC - Sistema de Gestión de Turnos Médicos

## Descripción
PROMEDIC es una aplicación web para administrar la asignación de turnos, pacientes y médicos
de una clínica médica. Permite gestionar los tiempos de los especialistas a partir de la asignación
de turnos a los pacientes, con distintos perfiles de acceso según el rol del usuario.

## Funcionalidades principales

### Gestión de médicos
- Alta, modificación y baja lógica de médicos
- Asociación a una o más especialidades
- Asignación de turno de trabajo (horario de entrada y salida)

### Gestión de pacientes
- Alta, modificación y baja lógica de pacientes
- Registro de datos personales: nombre, apellido, DNI, fecha de nacimiento, teléfono, dirección y obra social

### Gestión de turnos
- Para dar de alta un turno se selecciona un paciente previamente cargado y una especialidad
- El sistema sugiere automáticamente tres opciones de horario con su respectivo médico
- El usuario puede aceptar una sugerencia o cargar el turno de forma manual
- Los turnos tienen una duración fija de una hora (ej: 10:00 a 11:00, 11:00 a 12:00)
- Al confirmar el turno se asigna un número y se envía una confirmación por mail al paciente
- Los turnos pueden reprogramarse o cancelarse, pero nunca eliminarse

### Validaciones
- No puede existir más de un turno para el mismo médico en el mismo día y horario
- No puede existir más de un turno para el mismo paciente en el mismo día y horario
- No se pueden dar de alta turnos con fecha vencida
- El paciente debe tener un email válido cargado para recibir la confirmación

### Perfiles de acceso 
-Administrador: Acceso total: puede ver y manipular todo el sistema.
-Recepcionista: Administra pacientes y turnos medicos 

### Estado de turno
-Nuevo: Turno recien dado de alta
-Reporgramado: Turno modificado a otra fecha u horario
-Cancelado: Turno cancelado por el paciente o la clinica
-No asistio: El paciente no se presento
-Cerrado: Turno finalizado con diagnostico cargado
