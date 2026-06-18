using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TPI.Dominio;

namespace TPI.Negocio
{
    public class TurnoNegocio
    {
        public List<Turno> listar()
        {
            List<Turno> lista = new List<Turno>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(@"
                    SELECT 
                        t.Id_Turno, t.NumeroTurno, t.Fecha, t.HoraInicio, t.HoraFin,
                        t.Observaciones, t.Diagnostico, t.FechaCreacion, t.FechaModificación,
                        t.Estado,
                        p.Id_Paciente,
                        pp.Nombre AS NombrePaciente, pp.Apellido AS ApellidoPaciente,
                        pp.Dni AS DniPaciente,
                        m.Id_Medico, m.Matricula,
                        mp.Nombre AS NombreMedico, mp.Apellido AS ApellidoMedico,
                        e.Id_Especialidad, e.Nombre_Especialidad
                    FROM Turno t
                    INNER JOIN Paciente p ON t.Id_Paciente = p.Id_Paciente
                    INNER JOIN Persona pp ON p.Id_Persona = pp.Id_Persona
                    INNER JOIN Medico m ON t.Id_Medico = m.Id_Medico
                    INNER JOIN Persona mp ON m.Id_Persona = mp.Id_Persona
                    INNER JOIN Especialidad e ON m.Id_Especialidad = e.Id_Especialidad
                    ORDER BY t.Fecha, t.HoraInicio");

                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Turno t = new Turno();

                    t.Id = (int)datos.Lector["Id_Turno"];
                    t.Numero = (string)datos.Lector["NumeroTurno"];
                    t.Fecha = (DateTime)datos.Lector["Fecha"];
                    t.HoraInicio = (TimeSpan)datos.Lector["HoraInicio"];
                    t.HoraFin = (TimeSpan)datos.Lector["HoraFin"];
                    t.Observaciones = datos.Lector["Observaciones"] as string;
                    t.Diagnostico = datos.Lector["Diagnostico"] as string;
                    t.FechaCreacion = (DateTime)datos.Lector["FechaCreacion"];
                    t.FechaModificacion = datos.Lector["FechaModificación"] == DBNull.Value ? DateTime.MinValue: (DateTime)datos.Lector["FechaModificación"];
                    t.Estado = datos.Lector["Estado"] as string;

                    t.Paciente = new Paciente();
                    t.Paciente.Id = (int)datos.Lector["Id_Paciente"];
                    t.Paciente.Nombre = (string)datos.Lector["NombrePaciente"];
                    t.Paciente.Apellido = (string)datos.Lector["ApellidoPaciente"];
                    t.Paciente.Dni = (string)datos.Lector["DniPaciente"];

                    t.Medico = new Medico();
                    t.Medico.Id = (int)datos.Lector["Id_Medico"];
                    t.Medico.Matricula = (string)datos.Lector["Matricula"];
                    t.Medico.Nombre = (string)datos.Lector["NombreMedico"];
                    t.Medico.Apellido = (string)datos.Lector["ApellidoMedico"];

                    t.Especialidad = new Especialidad();
                    t.Especialidad.Id = (int)datos.Lector["Id_Especialidad"];
                    t.Especialidad.Nombre = (string)datos.Lector["Nombre_Especialidad"];

                    lista.Add(t);
                }

                return lista;
            }
            catch (Exception ex) { throw ex; }
            finally { datos.CerrarConexion(); }
        }

        public List<Turno> listarPorPaciente(int idPaciente)
        {
            List<Turno> lista = new List<Turno>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(@"
                    SELECT 
                        t.Id_Turno, t.NumeroTurno, t.Fecha, t.HoraInicio, t.HoraFin,
                        t.Observaciones, t.Diagnostico, t.FechaCreacion, t.FechaModificación,
                        t.Estado,
                        p.Id_Paciente,
                        pp.Nombre AS NombrePaciente, pp.Apellido AS ApellidoPaciente,
                        pp.Dni AS DniPaciente,
                        m.Id_Medico, m.Matricula,
                        mp.Nombre AS NombreMedico, mp.Apellido AS ApellidoMedico,
                        e.Id_Especialidad, e.Nombre_Especialidad
                    FROM Turno t
                    INNER JOIN Paciente p ON t.Id_Paciente = p.Id_Paciente
                    INNER JOIN Persona pp ON p.Id_Persona= pp.Id_Persona
                    INNER JOIN Medico m ON t.Id_Medico = m.Id_Medico
                    INNER JOIN Persona mp ON m.Id_Persona = mp.Id_Persona
                    INNER JOIN Especialidad e ON m.Id_Especialidad= e.Id_Especialidad
                    WHERE t.Id_Paciente = @idPaciente
                    ORDER BY t.Fecha, t.HoraInicio");

                datos.setearParametro("@idPaciente", idPaciente);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Turno t = new Turno();

                    t.Id = (int)datos.Lector["Id_Turno"];
                    t.Numero = (string)datos.Lector["NumeroTurno"];
                    t.Fecha = (DateTime)datos.Lector["Fecha"];
                    t.HoraInicio = (TimeSpan)datos.Lector["HoraInicio"];
                    t.HoraFin = (TimeSpan)datos.Lector["HoraFin"];
                    t.Observaciones = datos.Lector["Observaciones"] as string;
                    t.Diagnostico = datos.Lector["Diagnostico"] as string;
                    t.FechaCreacion = (DateTime)datos.Lector["FechaCreacion"];
                    t.FechaModificacion = datos.Lector["FechaModificación"] == DBNull.Value? DateTime.MinValue: (DateTime)datos.Lector["FechaModificación"];
                    t.Estado = datos.Lector["Estado"] as string;

                    t.Paciente = new Paciente();
                    t.Paciente.Id = (int)datos.Lector["Id_Paciente"];
                    t.Paciente.Nombre = (string)datos.Lector["NombrePaciente"];
                    t.Paciente.Apellido = (string)datos.Lector["ApellidoPaciente"];
                    t.Paciente.Dni = (string)datos.Lector["DniPaciente"];

                    t.Medico = new Medico();
                    t.Medico.Id = (int)datos.Lector["Id_Medico"];
                    t.Medico.Matricula = (string)datos.Lector["Matricula"];
                    t.Medico.Nombre = (string)datos.Lector["NombreMedico"];
                    t.Medico.Apellido = (string)datos.Lector["ApellidoMedico"];

                    t.Especialidad = new Especialidad();
                    t.Especialidad.Id = (int)datos.Lector["Id_Especialidad"];
                    t.Especialidad.Nombre = (string)datos.Lector["Nombre_Especialidad"];

                    lista.Add(t);
                }

                return lista;
            }
            catch (Exception ex) { throw ex; }
            finally { datos.CerrarConexion(); }
        }

        public void agregar(Turno turno)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta(@"
                    INSERT INTO Turno 
                        (NumeroTurno, Fecha, HoraInicio, HoraFin, Observaciones, 
                         Diagnostico, FechaCreacion, FechaModificación, Estado, Id_Paciente, Id_Medico)
                    VALUES 
                        (@numero, @fecha, @horaInicio, @horaFin, @observaciones,
                         @diagnostico, @fechaCreacion, NULL, @estado, @idPaciente, @idMedico)");

                datos.setearParametro("@numero", turno.Numero);
                datos.setearParametro("@fecha", turno.Fecha);
                datos.setearParametro("@horaInicio", turno.HoraInicio);
                datos.setearParametro("@horaFin", turno.HoraFin);
                datos.setearParametro("@observaciones", turno.Observaciones ?? (object)DBNull.Value);
                datos.setearParametro("@diagnostico", turno.Diagnostico ?? (object)DBNull.Value);
                datos.setearParametro("@fechaCreacion", DateTime.Today);
                datos.setearParametro("@estado", "Nuevo");
                datos.setearParametro("@idPaciente", turno.Paciente.Id);
                datos.setearParametro("@idMedico", turno.Medico.Id);

                datos.ejecutarAccion();
            }
            catch (Exception ex) { throw ex; }
            finally { datos.CerrarConexion(); }
        }

        public void cancelar(int idTurno)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta(@"
                    UPDATE Turno SET 
                        Estado = 'Cancelado',
                        FechaModificación = @fecha
                    WHERE Id_Turno = @id");

                datos.setearParametro("@fecha", DateTime.Today);
                datos.setearParametro("@id", idTurno);

                datos.ejecutarAccion();
            }
            catch (Exception ex) { throw ex; }
            finally { datos.CerrarConexion(); }
        }

        public void modificarEstado(int idTurno, string nuevoEstado)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta(@"
                    UPDATE Turno SET
                        Estado = @estado,
                        FechaModificación = @fecha
                    WHERE Id_Turno = @id");

                datos.setearParametro("@estado", nuevoEstado);
                datos.setearParametro("@fecha", DateTime.Today);
                datos.setearParametro("@id", idTurno);

                datos.ejecutarAccion();
            }
            catch (Exception ex) { throw ex; }
            finally { datos.CerrarConexion(); }
        }
    }
}