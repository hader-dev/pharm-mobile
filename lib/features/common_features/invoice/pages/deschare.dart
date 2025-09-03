import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PharmaceuticalDecharge {
  static const int itemsPerPage = 15;

  static List<pw.Page> build(Map<String, dynamic> invoiceData,
      pw.ImageProvider logoImage, final double padding) {
    final company = invoiceData['company'];
    final invoice = invoiceData['invoice'];
    final client = invoiceData['client'];
    final items = List<Map<String, dynamic>>.from(invoiceData['items']);
    final totals = invoiceData['totals'];

    final itemChunks = <List<Map<String, dynamic>>>[];
    for (var i = 0; i < items.length; i += itemsPerPage) {
      itemChunks.add(items.sublist(
        i,
        i + itemsPerPage > items.length ? items.length : i + itemsPerPage,
      ));
    }

    List<pw.Page> pages = [];

    for (var i = 0; i < itemChunks.length; i++) {
      final chunk = itemChunks[i];

      pages.add(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: pw.EdgeInsets.all(padding),
          build: (context) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              if (i == 0) _buildHeader(company, client, invoice),
              if (i > 0) _buildContinuationHeader(company, invoice, i + 1),
              pw.SizedBox(height: 10),
              _buildTableHeader(),
              _buildItems(chunk),
              if (i == itemChunks.length - 1) ...[
                pw.SizedBox(height: 20),
                _buildFooter(totals),
              ]
            ],
          ),
        ),
      );
    }

    return pages;
  }

  static pw.Widget _buildHeader(Map<String, dynamic> company,
      Map<String, dynamic> client, Map<String, dynamic> invoice) {
    return pw.Column(
      children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              child: pw.Container(
                height: 120,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(width: 1, color: PdfColors.black),
                  color: PdfColors.grey300,
                ),
                padding: const pw.EdgeInsets.all(8),
                margin: const pw.EdgeInsets.only(right: 10, bottom: 20),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text("Pharmacie : ${client['name']}",
                        style: pw.TextStyle(
                            fontSize: 11, fontWeight: pw.FontWeight.bold)),
                    pw.Text(client['address'] ?? "",
                        style: const pw.TextStyle(fontSize: 9)),
                    pw.Text("${client['city']} WILAYA : ${client['wilaya']}",
                        style: const pw.TextStyle(fontSize: 9)),
                    pw.Text(
                        "IF : ${client['if']}  AI : ${client['ai']}  RC : ${client['rc']}  NIS : ${client['nis']}",
                        style: const pw.TextStyle(fontSize: 9)),
                  ],
                ),
              ),
            ),
            pw.Expanded(
              child: pw.Container(
                height: 120,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(width: 1, color: PdfColors.black),
                  color: PdfColors.grey300,
                ),
                padding: const pw.EdgeInsets.all(8),
                margin: const pw.EdgeInsets.only(bottom: 20),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text("Fournisseur : ${company['name']}",
                        style: pw.TextStyle(
                            fontSize: 11, fontWeight: pw.FontWeight.bold)),
                    pw.Text(company['address'] ?? "",
                        style: const pw.TextStyle(fontSize: 9)),
                    pw.Text("Tél : ${company['phone']}",
                        style: const pw.TextStyle(fontSize: 9)),
                    pw.Text("e-mail : ${company['email']}",
                        style: const pw.TextStyle(fontSize: 9)),
                    pw.Text(
                        "IF : ${company['fiscalId']}  AI : ${company['ai']}  RC : ${company['rc']}  NIS : ${company['nis']}",
                        style: const pw.TextStyle(fontSize: 9)),
                  ],
                ),
              ),
            ),
          ],
        ),
        pw.Center(
          child: pw.Column(
            children: [
              pw.Text("DECHARGE N° ${invoice['number']}",
                  style: pw.TextStyle(
                      fontSize: 16, fontWeight: pw.FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildContinuationHeader(Map<String, dynamic> company,
      Map<String, dynamic> invoice, int pageNumber) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 20),
      decoration: pw.BoxDecoration(
        border:
            pw.Border(bottom: pw.BorderSide(width: 1, color: PdfColors.black)),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(company['name'],
              style:
                  pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
          pw.Text("DECHARGE N°: ${invoice['number']} - Page $pageNumber",
              style:
                  pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
        ],
      ),
    );
  }

  static pw.Widget _buildTableHeader() {
    return pw.Container(
      decoration: pw.BoxDecoration(
        color: PdfColors.grey300,
        border: pw.Border.all(width: 1, color: PdfColors.black),
      ),
      padding: const pw.EdgeInsets.all(5),
      child: pw.Row(
        children: [
          pw.Expanded(
              flex: 3, child: pw.Text("DESIGNATION", style: _headerStyle())),
          pw.Expanded(
              flex: 1,
              child: pw.Text("QTE",
                  textAlign: pw.TextAlign.center, style: _headerStyle())),
          pw.Expanded(
              flex: 1,
              child: pw.Text("N°LOT",
                  textAlign: pw.TextAlign.center, style: _headerStyle())),
          pw.Expanded(
              flex: 1,
              child: pw.Text("PPA",
                  textAlign: pw.TextAlign.center, style: _headerStyle())),
          pw.Expanded(
              flex: 1,
              child: pw.Text("Exp.",
                  textAlign: pw.TextAlign.center, style: _headerStyle())),
          pw.Expanded(
              flex: 1,
              child: pw.Text("PU HT",
                  textAlign: pw.TextAlign.center, style: _headerStyle())),
          pw.Expanded(
              flex: 1,
              child: pw.Text("MT HT",
                  textAlign: pw.TextAlign.center, style: _headerStyle())),
        ],
      ),
    );
  }

  static pw.Widget _buildItems(List<Map<String, dynamic>> chunk) {
    return pw.Column(
      children: chunk
          .map((item) => pw.Container(
                decoration: pw.BoxDecoration(
                  border: pw.Border(
                    left: pw.BorderSide(width: 1, color: PdfColors.black),
                    right: pw.BorderSide(width: 1, color: PdfColors.black),
                    bottom: pw.BorderSide(width: 1, color: PdfColors.black),
                  ),
                ),
                padding: const pw.EdgeInsets.all(5),
                child: pw.Row(
                  children: [
                    pw.Expanded(
                        flex: 3,
                        child: pw.Text(item['designation'] ?? "",
                            style: _rowStyle())),
                    pw.Expanded(
                        flex: 1,
                        child: pw.Text("${item['quantity']}",
                            textAlign: pw.TextAlign.center,
                            style: _rowStyle())),
                    pw.Expanded(
                        flex: 1,
                        child: pw.Text("${item['lotNumber']}",
                            textAlign: pw.TextAlign.center,
                            style: _rowStyle())),
                    pw.Expanded(
                        flex: 1,
                        child: pw.Text("${item['ppa']}",
                            textAlign: pw.TextAlign.center,
                            style: _rowStyle())),
                    pw.Expanded(
                        flex: 1,
                        child: pw.Text("${item['expiry']}",
                            textAlign: pw.TextAlign.center,
                            style: _rowStyle())),
                    pw.Expanded(
                        flex: 1,
                        child: pw.Text("${item['puHt']}",
                            textAlign: pw.TextAlign.center,
                            style: _rowStyle())),
                    pw.Expanded(
                        flex: 1,
                        child: pw.Text("${item['mtHt']}",
                            textAlign: pw.TextAlign.center,
                            style: _rowStyle())),
                  ],
                ),
              ))
          .toList(),
    );
  }

  static pw.Widget _buildFooter(Map<String, dynamic> totals) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Text("TOTAL : ${totals['totalHt']}",
              style:
                  pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
        ),
        pw.SizedBox(height: 40),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            _signatureBox("Visa Pharmacien"),
            _signatureBox("Avis Responsable Commercial"),
            _signatureBox("Avis PDG"),
          ],
        )
      ],
    );
  }

  static pw.Widget _signatureBox(String label) {
    return pw.Container(
      height: 60,
      width: 150,
      padding: pw.EdgeInsets.all(10),
      alignment: pw.Alignment.topCenter,
      decoration: pw.BoxDecoration(
          border: pw.Border.all(width: 1, color: PdfColors.black)),
      child: pw.Text(label, style: const pw.TextStyle(fontSize: 9)),
    );
  }

  static pw.TextStyle _headerStyle() =>
      pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold);

  static pw.TextStyle _rowStyle() => const pw.TextStyle(fontSize: 8);
}
