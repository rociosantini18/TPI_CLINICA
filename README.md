# PROMEDIC - Sistema de Gestión de Turnos Médicos

## Descripción
PROMEDIC es una aplicación web para administrar la asignación de turnos, pacientes y médicos
de una clínica médica. Permite gestionar los tiempos de los especialistas a partir de la asignación
de turnos a los pacientes, con distintos perfiles de acceso según el rol del usuario.

## Funcionalidades principales

### Gestión de médicos
- Alta, modificación y baja lógica de médicos
- Asociación a una especialidad


### Gestión de empleados (Recepcionista y Administrador)
- Alta, modificacion y baja logica de empleados

### Gestión de pacientes
- Alta, modificación y baja lógica de pacientes
- Registro de datos personales: nombre, apellido, DNI, fecha de nacimiento, teléfono, dirección y obra social

### Gestión de turnos
- Para dar de alta un turno, si sos la recepcionista, se selecciona un paciente previamente cargado y una especialidad, ademas de horarios disponibles previamente cargados
- Los turnos tienen una duración fija de una hora (ej: 10:00 a 11:00, 11:00 a 12:00)
- Los turnos tienen 3 estados: nuevo, cancelado, atendido. 
- Una vez atendido el paciente, se le puede cargar un diagnostico que el medico le de a la recepcionista como recordatorio. (ej: Tomar ibuprofeno o alguna observacion)


### Perfiles de acceso 
- Administrador: Acceso total: puede ver y manipular todo el sistema
- Recepcionista: Administra pacientes y turnos medicos 
- Paciente: Podes ver tu perfil, editar los datos, ver tus turnos y sacar nuevos
