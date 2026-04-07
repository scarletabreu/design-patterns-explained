import 'prototype.dart';

class Notification implements Prototype<Notification> {
  String tipo;
  String titulo;
  String mensaje;
  String destinatario;
  Map<String, String> metadatos;

  Notification({
    required this.tipo,
    required this.titulo,
    required this.mensaje,
    required this.destinatario,
    required this.metadatos,
  });

  @override
  Notification clone() {
    return Notification(
      tipo: tipo,
      titulo: titulo,
      mensaje: mensaje,
      destinatario: destinatario,
      metadatos: Map<String, String>.from(metadatos),
    );
  }

  @override
  String toString() {
    return 'Notification(tipo: $tipo, titulo: "$titulo", destinatario: $destinatario, metadatos: $metadatos)';
  }
}
