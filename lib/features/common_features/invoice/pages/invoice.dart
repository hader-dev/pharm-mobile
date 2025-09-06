import 'package:hader_pharm_mobile/models/company.dart';
import 'package:hader_pharm_mobile/models/invoice.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PharmaceuticalInvoice {
  static List<pw.Page> build(
      Invoice invoice, pw.ImageProvider logoImage, final double padding) {
    final company = invoice.sellerCompany!;
    final client = invoice.clientCompany!;
    final items = invoice.invoiceItems!;

    const itemsPerPage = 10;
    final itemChunks = <List<InvoiceItem>>[];
    for (var i = 0; i < items.length; i += itemsPerPage) {
      itemChunks.add(items.sublist(
        i,
        i + itemsPerPage > items.length ? items.length : i + itemsPerPage,
      ));
    }

    final pages = <pw.Page>[];

    for (var chunkIndex = 0; chunkIndex < itemChunks.length; chunkIndex++) {
      final chunk = itemChunks[chunkIndex];

      pages.add(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: pw.EdgeInsets.all(padding),
          build: (context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                if (chunkIndex == 0)
                  _buildHeader(company, invoice, client, logoImage),
                if (chunkIndex > 0)
                  _buildContinuationHeader(company, invoice, chunkIndex + 1),
                pw.SizedBox(height: 10),
                _buildTable(chunk),
                if (chunkIndex == itemChunks.length - 1)
                  _buildFooter(items, invoice),
              ],
            );
          },
        ),
      );
    }

    return pages;
  }

  // -------------------------------
  // HEADER
  // -------------------------------
  static pw.Widget _buildHeader(Company company, Invoice invoice,
      Company client, pw.ImageProvider logoImage) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // Company & invoice info
        pw.Container(
          padding: const pw.EdgeInsets.only(bottom: 10),
          decoration: pw.BoxDecoration(
            border: pw.Border(
              bottom: pw.BorderSide(width: 1, color: PdfColors.black),
            ),
          ),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(company.name,
                      style: pw.TextStyle(
                          fontSize: 18, fontWeight: pw.FontWeight.bold)),
                  pw.Text(company.description ?? '',
                      style: const pw.TextStyle(fontSize: 9)),
                  pw.Text(company.address ?? '',
                      style: const pw.TextStyle(fontSize: 9)),
                  pw.Text("Tél : ${company.phone}",
                      style: const pw.TextStyle(fontSize: 9)),
                  pw.Text("Fax : ${company.fax}",
                      style: const pw.TextStyle(fontSize: 9)),
                  pw.Text("Compte : ${company.bankAccount}",
                      style: const pw.TextStyle(fontSize: 9)),
                  pw.Text("E-mail : ${company.email}",
                      style: const pw.TextStyle(fontSize: 9)),
                ],
              ),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  if (company.image?.path != null)
                    pw.Container(
                      width: 100,
                      height: 100,
                      child: pw.Image(logoImage, fit: pw.BoxFit.cover),
                    ),
                  pw.SizedBox(height: 10),
                  pw.Text("Id Fiscal : ${company.fiscalId}",
                      style: const pw.TextStyle(fontSize: 9)),
                  pw.Text("RC : ${company.rcNumber}",
                      style: const pw.TextStyle(fontSize: 9)),
                  pw.Text("AI : ${company.aiNumber}",
                      style: const pw.TextStyle(fontSize: 9)),
                  pw.Text("NIS : ${company.nisNumber}",
                      style: const pw.TextStyle(fontSize: 9)),
                ],
              )
            ],
          ),
        ),
        pw.SizedBox(height: 10),
        // Invoice info
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text("FACTURE N°: ${invoice.formattedInvoiceNumber}",
                    style: pw.TextStyle(
                        fontSize: 14, fontWeight: pw.FontWeight.bold)),
                pw.Text(invoice.id, style: const pw.TextStyle(fontSize: 9)),
                pw.Text("Code Client : ${invoice.clientCompany?.id}",
                    style: const pw.TextStyle(fontSize: 9)),
                pw.Text("Code Région : ${invoice.sellerCompany?.regionId}",
                    style: const pw.TextStyle(fontSize: 9)),
                pw.Text("Wilaya : ${invoice.sellerCompany?.willaya}",
                    style: const pw.TextStyle(fontSize: 9)),
                pw.Text("Mode paiement : ${invoice.paymentMethod?.label}",
                    style: const pw.TextStyle(fontSize: 9)),
                pw.Text("Date Echéance : ${invoice.dueDate}",
                    style: const pw.TextStyle(fontSize: 9)),
              ],
            ),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Text("Le : ${invoice.issueDate}",
                    style: const pw.TextStyle(fontSize: 9)),
                pw.Text("DOIT : TBD??", style: const pw.TextStyle(fontSize: 9)),
              ],
            )
          ],
        ),
        pw.SizedBox(height: 10),
        // Client
        pw.Container(
          width: double.infinity,
          decoration: pw.BoxDecoration(
            color: PdfColors.grey300,
            border: pw.Border.all(width: 1, color: PdfColors.black),
          ),
          padding: const pw.EdgeInsets.all(10),
          margin: const pw.EdgeInsets.only(bottom: 20),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("Pharmacie : ${client.name}",
                  style: pw.TextStyle(
                      fontSize: 11, fontWeight: pw.FontWeight.bold)),
              pw.Text(client.address ?? "",
                  style: const pw.TextStyle(fontSize: 9)),
              pw.Text("${client.town} WILAYA: ${client.willaya}",
                  style: const pw.TextStyle(fontSize: 9)),
              pw.Text(
                  "IF: ${client.fiscalId} AI: ${client.aiNumber} RC: ${client.rcNumber} NIS: ${client.nisNumber}",
                  style: const pw.TextStyle(fontSize: 9)),
            ],
          ),
        )
      ],
    );
  }

  // -------------------------------
  // CONTINUATION HEADER
  // -------------------------------
  static pw.Widget _buildContinuationHeader(
      Company company, Invoice invoice, int pageNumber) {
    return pw.Container(
      padding: const pw.EdgeInsets.only(bottom: 10),
      decoration: pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(width: 1, color: PdfColors.black),
        ),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(company.name,
              style:
                  pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
          pw.Text("FACTURE N°: ${invoice.invoiceNumber} - Page $pageNumber",
              style:
                  pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
        ],
      ),
    );
  }

  // -------------------------------
  // TABLE
  // -------------------------------
  static pw.Widget _buildTable(List<InvoiceItem> itemsChunk) {
    return pw.Column(
      children: [
        // Table Header
        pw.Container(
          decoration: pw.BoxDecoration(
            color: PdfColors.grey300,
            border: pw.Border.all(width: 1, color: PdfColors.black),
          ),
          padding: const pw.EdgeInsets.all(5),
          child: pw.Row(
            children: [
              _col("DESIGNATION", 3, bold: true),
              _col("QTE", 1, center: true),
              _col("N° LOT", 1, center: true),
              _col("PPA", 1, center: true),
              _col("SHP", 1, center: true),
              _col("PU HT", 1, center: true),
              _col("Exp.", 1, center: true),
              _col("TVA", 1, center: true),
              _col("Mge", 1, center: true),
              _col("MT HT", 1, center: true),
            ],
          ),
        ),
        // Rows
        ...itemsChunk.map((item) {
          return pw.Container(
            padding: const pw.EdgeInsets.all(5),
            decoration: pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide(width: 1, color: PdfColors.black),
                right: pw.BorderSide(width: 1, color: PdfColors.black),
                bottom: pw.BorderSide(width: 1, color: PdfColors.black),
              ),
            ),
            child: pw.Row(
              children: [
                _col(item.designation, 3),
                _col("${item.quantity}", 1, center: true),
                _col(item.lotNumber, 1, center: true),
                _col(item.ppa, 1, center: true),
                _col(item.shp, 1, center: true),
                _col(item.puHt, 1, center: true),
                _col(item.expiry, 1, center: true),
                _col(item.tva, 1, center: true),
                _col(item.mge, 1, center: true),
                _col(item.mtHt, 1, center: true),
              ],
            ),
          );
        }),
      ],
    );
  }

  static pw.Widget _col(String text, int flex,
      {bool bold = false, bool center = false}) {
    return pw.Expanded(
      flex: flex,
      child: pw.Text(text,
          style: pw.TextStyle(
              fontSize: 8,
              fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal),
          textAlign: center ? pw.TextAlign.center : pw.TextAlign.left),
    );
  }

  // -------------------------------
  // FOOTER
  // -------------------------------
  static pw.Widget _buildFooter(
    List<InvoiceItem> items,
    Invoice invoice,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 10),
        // Summary
        pw.Container(
          width: double.infinity,
          decoration: pw.BoxDecoration(
            border: pw.Border.all(width: 1, color: PdfColors.black),
          ),
          padding: const pw.EdgeInsets.all(5),
          margin: const pw.EdgeInsets.only(bottom: 10),
          child: pw.Text(
            "Lignes : ${items.length} NB: ${invoice.invoiceSummary.totalItems} SHP: ${invoice.invoiceSummary.totalShipping} PPA: ${invoice.invoiceSummary.totalPpa} Rist: ${invoice.invoiceSummary.totalRist}",
            style: const pw.TextStyle(fontSize: 8),
          ),
        ),
        // Totals
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text("Arrêtée la présente facture à la somme de :",
                      style: const pw.TextStyle(fontSize: 10)),
                  pw.Text(invoice.invoiceSummary.amountInWords,
                      style: const pw.TextStyle(fontSize: 10)),
                ],
              ),
            ),
            pw.Container(
              width: 200,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(width: 1, color: PdfColors.black),
              ),
              child: pw.Column(
                children: [
                  _totalRow("TOTAL HT", invoice.invoiceSummary.totalExclTax),
                  _totalRow("TVA", invoice.invoiceSummary.vatAmount),
                  _totalRow("TIMBRE", invoice.invoiceSummary.stampDuty),
                  pw.Container(
                    color: PdfColors.grey300,
                    padding: const pw.EdgeInsets.all(5),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text("NET A PAYER",
                            style: pw.TextStyle(
                                fontSize: 10, fontWeight: pw.FontWeight.bold)),
                        pw.Text("${invoice.invoiceSummary.netToPay}",
                            style: pw.TextStyle(
                                fontSize: 10, fontWeight: pw.FontWeight.bold)),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        pw.SizedBox(height: 20),
        // Conditions
        pw.Container(
          decoration: pw.BoxDecoration(
            border: pw.Border.all(width: 1, color: PdfColors.black),
          ),
          child: pw.Row(
            children: [
              _conditionBox("Colis"),
              _conditionBox("Psycho"),
              _conditionBox("Frigo"),
            ],
          ),
        )
      ],
    );
  }

  static pw.Widget _totalRow(String label, dynamic value) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(5),
      decoration: pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(width: 1, color: PdfColors.black),
        ),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(label, style: const pw.TextStyle(fontSize: 9)),
          pw.Text("$value", style: const pw.TextStyle(fontSize: 9)),
        ],
      ),
    );
  }

  static pw.Widget _conditionBox(String label, {String? value}) {
    return pw.Expanded(
      child: pw.Container(
        padding: const pw.EdgeInsets.all(5),
        decoration: pw.BoxDecoration(
          border:
              pw.Border(right: pw.BorderSide(width: 1, color: PdfColors.black)),
        ),
        child: pw.Column(
          children: [
            pw.Text(label,
                textAlign: pw.TextAlign.center,
                style: const pw.TextStyle(fontSize: 9)),
            if (value != null)
              pw.Text(value,
                  textAlign: pw.TextAlign.center,
                  style: const pw.TextStyle(fontSize: 9)),
          ],
        ),
      ),
    );
  }
}
