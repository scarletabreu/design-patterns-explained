import '../template/report_generator.dart';

class CsvReport extends ReportGenerator {
  @override
  String reportName() => "CSV";

  @override
  String formatOutput(List<Map<String, dynamic>> data) {
    print("Formateando como CSV...");
    final buffer = StringBuffer("producto,ventas,ingresos\n");
    for (final row in data) {
      buffer.writeln("${row['producto']},${row['ventas']},${row['ingresos']}");
    }
    return buffer.toString();
  }

  @override
  void saveFile(String content) {
    print("Guardando archivo reporte.csv");
    print("Contenido:\n$content");
  }
}