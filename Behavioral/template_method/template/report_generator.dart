abstract class ReportGenerator {
  // Metodo plantilla: define el esqueleto del algoritmo
  // No debe ser sobreescrito por las subclases
  void generate() {
    print("\n=== Generando reporte: ${reportName()} ===");
    final data = fetchData();
    final processed = processData(data);
    final output = formatOutput(processed);
    saveFile(output);
    onComplete(); // hook opcional
  }

  // Paso común: obtener datos (implementación por defecto)
  List<Map<String, dynamic>> fetchData() {
    print("Obteniendo datos desde la fuente...");
    return [
      {"producto": "Laptop", "ventas": 120, "ingresos": 144000},
      {"producto": "Mouse", "ventas": 340, "ingresos": 10200},
      {"producto": "Monitor", "ventas": 85, "ingresos": 42500},
    ];
  }

  // Paso común: procesar datos (implementación por defecto)
  List<Map<String, dynamic>> processData(List<Map<String, dynamic>> data) {
    print("Procesando y ordenando datos...");
    return List.from(data)
      ..sort((a, b) => (b["ingresos"] as int).compareTo(a["ingresos"] as int));
  }

  // Pasos variables: deben implementarse en cada subclase
  String reportName();
  String formatOutput(List<Map<String, dynamic>> data);
  void saveFile(String content);

  // Hook: metodo opcional con comportamiento vacío por defecto
  void onComplete() {}
}