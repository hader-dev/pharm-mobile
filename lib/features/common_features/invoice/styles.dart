import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

final companyNameStyle = pw.TextStyle(
  fontSize: 18,
  fontWeight: pw.FontWeight.bold,
);

final headerTextStyle = pw.TextStyle(
  fontSize: 9,
);

final invoiceTitleStyle = pw.TextStyle(
  fontSize: 14,
  fontWeight: pw.FontWeight.bold,
);

final tableHeaderStyle = pw.TextStyle(
  fontSize: 8,
  fontWeight: pw.FontWeight.bold,
);

final tableCellStyle = pw.TextStyle(
  fontSize: 8,
);

final clientTitleStyle = pw.TextStyle(
  fontSize: 11,
  fontWeight: pw.FontWeight.bold,
);

final clientInfoStyle = pw.TextStyle(
  fontSize: 9,
);

final dechargeBigStyle = pw.TextStyle(
  fontSize: 16,
  fontWeight: pw.FontWeight.bold,
);

final dechargeTitleStyle = pw.TextStyle(
  fontSize: 20,
  fontWeight: pw.FontWeight.bold,
);

pw.BoxDecoration borderBox() => pw.BoxDecoration(
      border: pw.Border.all(width: 1, color: PdfColors.black),
    );

pw.BoxDecoration grayBox() => pw.BoxDecoration(
      color: PdfColors.grey300,
      border: pw.Border.all(width: 1, color: PdfColors.black),
    );

pw.BoxDecoration bottomBorder() => pw.BoxDecoration(
      border: pw.Border(
        bottom: pw.BorderSide(width: 1, color: PdfColors.black),
      ),
    );
