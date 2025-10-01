import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:path_provider/path_provider.dart';

class PdfViewerScreen extends StatefulWidget {
  final String pdfUrl;
  final String title;

  const PdfViewerScreen({
    super.key,
    required this.pdfUrl,
    required this.title,
  });

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  String? localPath;
  bool isLoading = true;
  bool hasError = false;
  int? totalPages = 0;
  int currentPage = 0;
  bool isReady = false;
  late PDFViewController pdfViewController;

  @override
  void initState() {
    super.initState();
    _downloadAndSavePdf();
  }

  Future<void> _downloadAndSavePdf() async {
    try {
      final response = await http.get(Uri.parse(widget.pdfUrl));
      if (response.statusCode == 200) {
        final dir = await getTemporaryDirectory();
        final file = File('${dir.path}/temp.pdf');
        await file.writeAsBytes(response.bodyBytes);
        setState(() {
          localPath = file.path;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load PDF');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        hasError = true;
      });
    }
  }

  Future<void> _saveToDownloads() async {
    try {
      final downloadsDir = await getDownloadsDirectory();
      if (downloadsDir == null) {
        throw Exception('Downloads directory not found');
      }

      final fileName = widget.pdfUrl.split('/').last;
      final destinationFile = File('${downloadsDir.path}/$fileName');

      final sourceFile = File(localPath!);
      await sourceFile.copy(destinationFile.path);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.translation?.feedback_file_saved_successfully ??
              'File downloaded to Downloads'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.translation?.feedback_file_save_failed ??
              'Failed to download file'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarV2.alternate(
        title: Text(
          widget.title,
          style: context.responsiveTextTheme.current.headLine4SemiBold.copyWith(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        trailing: [
          if (localPath != null && isReady)
            IconButton(
              icon: const Icon(Iconsax.refresh, color: Colors.white),
              onPressed: () {
                pdfViewController.setPage(0);
              },
            ),
          if (localPath != null && isReady)
            IconButton(
              icon: const Icon(Iconsax.direct_down, color: Colors.white),
              onPressed: _saveToDownloads,
            ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : hasError
              ? _buildErrorWidget()
              : Stack(
                  children: [
                    PDFView(
                      filePath: localPath!,
                      enableSwipe: true,
                      swipeHorizontal: false,
                      autoSpacing: true,
                      pageFling: true,
                      onRender: (pages) {
                        setState(() {
                          totalPages = pages;
                          isReady = true;
                        });
                      },
                      onViewCreated: (PDFViewController vc) {
                        pdfViewController = vc;
                      },
                      onPageChanged: (int? page, int? total) {
                        setState(() {
                          currentPage = page ?? 0;
                        });
                      },
                      onError: (error) {
                        setState(() {
                          hasError = true;
                        });
                      },
                      onPageError: (page, error) {
                        setState(() {
                          hasError = true;
                        });
                      },
                    ),
                    if (!isReady)
                      const Center(child: CircularProgressIndicator()),
                  ],
                ),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSizesManager.p24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Iconsax.document_cloud,
                size: 64, color: TextColors.ternary.color),
            const SizedBox(height: AppSizesManager.p16),
            Text(
              context.translation!.feedback_loading_failed,
              style: context.responsiveTextTheme.current.headLine4SemiBold,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizesManager.p8),
            Text(
              context.translation!.feedback_pdf_load_error,
              style: context.responsiveTextTheme.current.body2Regular.copyWith(
                color: TextColors.ternary.color,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizesManager.p24),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  isLoading = true;
                  hasError = false;
                });
                _downloadAndSavePdf();
              },
              icon: const Icon(Iconsax.refresh, size: 18),
              label: Text(context.translation!.refresh),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent1Shade1,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizesManager.p24,
                  vertical: AppSizesManager.p12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
