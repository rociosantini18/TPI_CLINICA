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
        public List<DateTime> listarFechasDisponiblesPorMedico(int idMedico)
        {
            List<DayOfWeek> diasQueAtiende = new List<DayOfWeek>();
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("SELECT DISTINCT DiaSemana FROM HorarioMedico WHERE Id_Medico = @id");
                datos.setearParametro("@id", idMedico);
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    diasQueAtiende.Add((DayOfWeek)Convert.ToInt32(datos.Lector["DiaSemana"]));
                }
            }
            catch (Exception ex) { throw ex; }
            finally { datos.CerrarConexion(); }

            List<DateTime> fechasDisponibles = new List<DateTime>();
            if (diasQueAtiende.Count > 0)
            {
                DateTime fechaActual = DateTime.Today;
                for (int i = 0; i < 30; i++)
                {
                    if (diasQueAtiende.Contains(fechaActual.DayOfWeek))
                    {
                        fechasDisponibles.Add(fechaActual);
                    }
                    fechaActual = fechaActual.AddDays(1);
                }
            }
            return fechasDisponibles;
        }

        public List<TimeSpan> listarHorariosDisponibles(int idMedico, DateTime fecha)
        {
            List<TimeSpan> disponibles = new List<TimeSpan>();
            AccesoDatos datos = new AccesoDatos();
            try
            {
                int diaSemana = (int)fecha.DayOfWeek;
                datos.setearConsulta(@"
            SELECT h.HoraInicio
            FROM HorarioMedico h
            WHERE h.Id_Medico = @idMedico 
            AND h.DiaSemana = @dia
            AND h.HoraInicio NOT IN (
                SELECT t.HoraInicio FROM Turno t
                WHERE t.Id_Medico = @idMedico
                AND CAST(t.Fecha AS DATE) = CAST(@fecha AS DATE)
                AND t.Estado NOT IN ('Cancelado', 'Reprogramado')
            )
            ORDER BY h.HoraInicio");

                datos.setearParametro("@idMedico", idMedico);
                datos.setearParametro("@dia", diaSemana);
                datos.setearParametro("@fecha", fecha);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    disponibles.Add((TimeSpan)datos.Lector["HoraInicio"]);
                }
                return disponibles;
            }
            catch (Exception ex) { throw ex; }
            finally { datos.CerrarConexion(); }
        }
    }
}