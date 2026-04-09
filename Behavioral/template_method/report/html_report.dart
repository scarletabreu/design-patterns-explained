import '../template/report_generator.dart';

class HtmlReport extends ReportGenerator {
  @override
  String reportName() => "HTML";

  @override
  String formatOutput(List<Map<String, dynamic>> data) {
    print("Formateando como HTML...");
    final buffer = StringBuffer("<table>\n<tr><th>Producto</th><th>Ventas</th><th>Ingresos</th></tr>\n");
    for (final row in data) {
      buffer.writeln("<tr><td>${row['producto']}</td><td>${row['ventas']}</td><td>\$${row['ingresos']}</td></tr>");
    }
    buffer.write("</table>");
    return buffer.toString();
  }

  @override
  void saveFile(String content) {
    print("Guardando archivo reporte.html");
    print("Contenido:\n$content");
  }

  // Sobreescritura del hook
  @override
  void onComplete() {
    print("Abriendo reporte en el navegador...");
  }
}