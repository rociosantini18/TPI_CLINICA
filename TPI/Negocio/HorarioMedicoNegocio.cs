using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TPI.Dominio;

namespace TPI.Negocio
{
    public class HorarioMedicoNegocio
    {
        public List<HorarioMedico> listarPorMedico(int idMedico)
        {
            List<HorarioMedico> lista = new List<HorarioMedico>();
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta(@"
            SELECT Id_Horario, DiaSemana, HoraInicio, HoraFin
            FROM HorarioMedico
            WHERE Id_Medico = @idMedico
            ORDER BY DiaSemana, HoraInicio");
                datos.setearParametro("@idMedico", idMedico);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    HorarioMedico h = new HorarioMedico();
                    h.Id = (int)datos.Lector["Id_Horario"];
                    h.DiaSemana = datos.Lector["DiaSemana"] != DBNull.Value ? (DayOfWeek)Convert.ToInt32(datos.Lector["DiaSemana"]) : DayOfWeek.Monday;
                    h.HoraInicio = (TimeSpan)datos.Lector["HoraInicio"];
                    h.HoraFin = (TimeSpan)datos.Lector["HoraFin"];
                    lista.Add(h);
                }
                return lista;
            }
            catch (Exception ex) { throw ex; }
            finally { datos.CerrarConexion(); }
        }

        public List<TimeSpan> listarHorariosDisponibles(int idMedico, DateTime fecha)
        {
            List<TimeSpan> disponibles = new List<TimeSpan>();
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta(@"
                    SELECT h.HoraInicio
                    FROM HorarioMedico h
                    WHERE h.Id_Medico = @idMedico
                    AND h.HoraInicio NOT IN (
                        SELECT t.HoraInicio FROM Turno t
                        WHERE t.Id_Medico = @idMedico
                        AND t.Estado NOT IN ('Cancelado')
                    )
                    ORDER BY h.HoraInicio");

                datos.setearParametro("@idMedico", idMedico);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                    disponibles.Add((TimeSpan)datos.Lector["HoraInicio"]);

                return disponibles;
            }
            catch (Exception ex) { throw ex; }
            finally { datos.CerrarConexion(); }
        }

        public void agregar(int idMedico, DayOfWeek diaSemana, TimeSpan horaInicio, TimeSpan horaFin)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta(@"
            INSERT INTO HorarioMedico (Id_Medico, DiaSemana, HoraInicio, HoraFin)
            VALUES (@idMedico, @diaSemana, @horaInicio, @horaFin)");
                datos.setearParametro("@idMedico", idMedico);
                datos.setearParametro("@diaSemana", (int)diaSemana);
                datos.setearParametro("@horaInicio", horaInicio);
                datos.setearParametro("@horaFin", horaFin);
                datos.ejecutarAccion();
            }
            catch (Exception ex) { throw ex; }
            finally { datos.CerrarConexion(); }
        }

        public void eliminar(int idHorario)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("DELETE FROM HorarioMedico WHERE Id_Horario = @id");
                datos.setearParametro("@id", idHorario);
                datos.ejecutarAccion();
            }
            catch (Exception ex) { throw ex; }
            finally { datos.CerrarConexion(); }
        }

        public Medico obtenerConHorarios(int idMedico)
        {
            MedicoNegocio medNegocio = new MedicoNegocio();
            Medico medico = medNegocio.listar().FirstOrDefault(m => m.Id == idMedico);

            if (medico != null)
                medico.Horarios = listarPorMedico(idMedico);

            return medico;
        }
        public List<HorarioMedico> listarFechasDisponiblesPorMedico(int idMedico)
        {
            AccesoDatos datos = new AccesoDatos();
            List<HorarioMedico> lista = new List<HorarioMedico>();
            try
            {
                datos.setearConsulta(@"
                    select distinct m.Id_Medico
                    from HorarioMedico hm
                    inner join Medico m on hm.Id_Medico = m.Id_Medico
                    where m.Id_Medico = @id");
                datos.setearParametro("@id", idMedico);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    HorarioMedico h = new HorarioMedico();
                    lista.Add(h);
                }
                return lista;
            }
            catch (Exception) { throw; }
            finally { datos.CerrarConexion(); }
        }

        public List<HorarioMedico> listarHorarioDisponiblesPorFecha(DateTime fecha)
        {
            AccesoDatos datos = new AccesoDatos();
            List<HorarioMedico> lista = new List<HorarioMedico>();
            try
            {
                datos.setearConsulta(@"
                    select HoraInicio 
                    from HorarioMedico
                    where Fecha = @fecha");
                datos.setearParametro("@fecha", fecha);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    HorarioMedico h = new HorarioMedico();
                    h.HoraInicio = (TimeSpan)datos.Lector["HoraInicio"];
                    lista.Add(h);
                }
                return lista;
            }
            catch (Exception) { throw; }
            finally { datos.CerrarConexion(); }
        }
    }
}