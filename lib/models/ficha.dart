class Ficha {
  final int? idFichaClinica;
  final String? fechaHora;
  final String? motivoConsulta;
  final String? diagnostico;
  final String? observacion;
  final int? idLocal;
  final int? idEmpleado;
  final int? idCliente;
  final int? idTipoProducto;
  final String? fechaHoraCadena;
  final String? fechaHoraCadenaFormateada;
  final String? fechaDesdeCadena;
  final String? fechaHastaCadena;
  final String? todosLosCampos;

  const Ficha({
      this.idFichaClinica,
      this.fechaHora,
      this.motivoConsulta,
      this.diagnostico,
      this.observacion,
      this.fechaHoraCadena,
      this.fechaHoraCadenaFormateada,
      this.fechaDesdeCadena,
      this.fechaHastaCadena,
      this.todosLosCampos,
      this.idLocal,
      this.idEmpleado,
      this.idCliente,
      this.idTipoProducto
    }
  );
}
