import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/language_config/resources/app_localizations.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/toast_helper.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

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
  late AppLocalizations translation;

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
        final file = File('${dir.path}/${widget.title}');
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
      final sourceFile = XFile(localPath!, name: widget.title);

      final shareResult = await SharePlus.instance.share(
        ShareParams(
          files: [sourceFile],
          text: context.translation?.feedback_share_pdf ?? 'Share PDF',
        ),
      );

      if (shareResult.status == ShareResultStatus.success) {
        getItInstance.get<ToastManager>().showToast(
              message: translation.feedback_file_saved_successfully,
              type: ToastType.success,
            );
      }
    } catch (e) {
      debugPrint('Error saving/sharing PDF: $e');
      getItInstance.get<ToastManager>().showToast(
            message: translation.feedback_file_save_failed,
            type: ToastType.error,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    translation = context.translation!;
    return Scaffold(
      appBar: CustomAppBarV2.normal(
        title: Text(
          widget.title,
          style: context.responsiveTextTheme.current.headLine4SemiBold.copyWith(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Directionality.of(context) == TextDirection.rtl ? Iconsax.arrow_right_3 : Iconsax.arrow_left_2,
            color: AppColors.accent1Shade1,
            size: context.responsiveAppSizeTheme.current.iconSize25,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        trailing: [
          if (localPath != null && isReady)
            IconButton(
              icon: Icon(Iconsax.refresh,
                  size: context.responsiveAppSizeTheme.current.iconSize25, color: AppColors.accent1Shade1),
              onPressed: () {
                pdfViewController.setPage(0);
              },
            ),
          if (localPath != null && isReady)
            IconButton(
              icon: Icon(LucideIcons.share2,
                  size: context.responsiveAppSizeTheme.current.iconSize25, color: AppColors.accent1Shade1),
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
                    if (!isReady) const Center(child: CircularProgressIndicator()),
                  ],
                ),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Iconsax.document_cloud, size: 64, color: TextColors.ternary.color),
            SizedBox(height: context.responsiveAppSizeTheme.current.p16),
            Text(
              context.translation!.feedback_loading_failed,
              style: context.responsiveTextTheme.current.headLine4SemiBold,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: context.responsiveAppSizeTheme.current.p8),
            Text(
              context.translation!.feedback_pdf_load_error,
              style: context.responsiveTextTheme.current.body2Regular.copyWith(
                color: TextColors.ternary.color,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: context.responsiveAppSizeTheme.current.p24),
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
                padding: EdgeInsets.symmetric(
                  horizontal: context.responsiveAppSizeTheme.current.p24,
                  vertical: context.responsiveAppSizeTheme.current.p12,
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
