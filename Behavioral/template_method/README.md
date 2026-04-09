# Patrón Template Method (Método Plantilla)

## Descripción general

El Template Method es un patrón de diseño de comportamiento que define el esqueleto de un algoritmo en una clase base, delegando algunos pasos a las subclases. Permite que las subclases redefinan ciertos pasos del algoritmo sin cambiar su estructura general.

---

## Problema

Considera un sistema que genera reportes en distintos formatos: PDF, CSV y HTML. El proceso general siempre es el mismo: recopilar datos, procesar datos, formatear la salida y guardar el archivo. Sin embargo, los detalles de formateo varían según el formato de destino.

**Enfoque incorrecto (duplicación de la estructura del algoritmo):**

```dart
class PdfReport {
  void generate() {
    fetchData();
    processData();
    formatAsPdf(); // diferente
    saveFile();    // diferente
  }
}

class CsvReport {
  void generate() {
    fetchData();   // duplicado
    processData(); // duplicado
    formatAsCsv();
    saveFile();
  }
}
```

La estructura del algoritmo se duplica en cada clase, lo que genera inconsistencias al evolucionar.

**Enfoque correcto usando Template Method:**

```dart
abstract class ReportGenerator {
  void generate() {   // plantilla: define el esqueleto
    fetchData();
    processData();
    formatOutput();   // paso variable
    saveFile();       // paso variable
  }

  void fetchData() { /* implementación común */ }
  void processData() { /* implementación común */ }

  void formatOutput(); // abstract: deben implementar las subclases
  void saveFile();
}
```

El algoritmo vive en un solo lugar; las subclases solo aportan los pasos que varían.

---

## Estructura

| Componente | Rol |
|---|---|
| Abstract Class | Define el método plantilla y declara los pasos abstractos y concretos |
| Template Method | Método que define el esqueleto del algoritmo; no debe ser sobreescrito |
| Abstract Steps | Métodos que las subclases deben implementar obligatoriamente |
| Hook Methods | Métodos opcionales con implementación vacía o por defecto que las subclases pueden sobreescribir |
| Concrete Class | Subclase que implementa los pasos variables del algoritmo |

---

## Implementación en Dart

**`template/report_generator.dart`**

```dart
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
```

**`report/csv_report.dart`**

```dart
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
```

**`report/html_report.dart`**

```dart
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
```

**`main.dart`**

```dart
import 'report/csv_report.dart';
import 'report/html_report.dart';

void main() {
  final reports = [CsvReport(), HtmlReport()];

  for (final report in reports) {
    report.generate();
  }
}
```

**Salida esperada:**

```text
=== Generando reporte: CSV ===
Obteniendo datos desde la fuente...
Procesando y ordenando datos...
Formateando como CSV...
Guardando archivo reporte.csv
Contenido:
producto,ventas,ingresos
Laptop,120,144000
Monitor,85,42500
Mouse,340,10200

=== Generando reporte: HTML ===
Obteniendo datos desde la fuente...
Procesando y ordenando datos...
Formateando como HTML...
Guardando archivo reporte.html
Contenido:
<table>
<tr><th>Producto</th><th>Ventas</th><th>Ingresos</th></tr>
<tr><td>Laptop</td><td>120</td><td>$144000</td></tr>
...
</table>
Abriendo reporte en el navegador...
```

---

## Hook Methods (métodos gancho)

Los hooks son métodos con implementación vacía o por defecto que las subclases pueden sobreescribir opcionalmente. A diferencia de los pasos abstractos, no son obligatorios.

```dart
// En la clase base:
void onComplete() {} // hook vacío: no hace nada por defecto

// En HtmlReport (sobreescribe el hook):
@override
void onComplete() {
  print("Abriendo reporte en el navegador...");
}

// En CsvReport (no sobreescribe: el hook permanece vacío)
```

Los hooks permiten que las subclases se integren en puntos específicos del algoritmo sin alterar su flujo principal.

---

## Ventajas y desventajas

**Ventajas**
- Elimina la duplicación del esqueleto del algoritmo entre subclases
- Facilita la extensión del algoritmo sin modificar su estructura principal
- Los hooks permiten personalización opcional sin forzar implementación
- Centraliza el flujo del algoritmo en un único lugar de fácil mantenimiento

**Desventajas**
- Puede violar el Principio de Sustitución de Liskov si las subclases alteran el comportamiento de manera inesperada
- La herencia como mecanismo de extensión puede resultar rígida comparado con la composición
- Las subclases pueden depender de detalles de implementación de la clase base

---

## Cuándo utilizarlo

Aplica el patrón Template Method cuando:

- Múltiples clases comparten la misma estructura de algoritmo pero difieren en pasos concretos
- Se desea evitar la duplicación de código manteniendo la variabilidad en puntos específicos
- Se quiere controlar qué partes del algoritmo pueden sobreescribir las subclases
- Se necesitan puntos de extensión opcionales sin imponer implementación obligatoria

---

## Aplicaciones en Flutter

- Generación de distintos tipos de reportes o exportaciones (PDF, CSV, JSON)
- Procesamiento de autenticación con distintos proveedores (email, Google, Apple)
- Ciclos de vida de pantallas con pasos comunes: carga, render, disposición
- Sincronización de datos con distintas fuentes respetando el mismo flujo de validación

---

## Estructura del proyecto

```
template_method/
│
├── template/
│   └── report_generator.dart
│
├── report/
│   ├── csv_report.dart
│   └── html_report.dart
│
├── main.dart
└── README.md
```

---

## Ejecución del ejemplo

```bash
dart run behavioral/template_method/main.dart
```