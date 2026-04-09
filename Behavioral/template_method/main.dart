import 'report/csv_report.dart';
import 'report/html_report.dart';

void main() {
  final reports = [CsvReport(), HtmlReport()];

  for (final report in reports) {
    report.generate();
  }
}