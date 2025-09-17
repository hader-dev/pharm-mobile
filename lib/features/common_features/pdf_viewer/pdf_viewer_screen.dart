import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
  late final WebViewController controller;
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    initializeWebView();
  }

  void initializeWebView() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (progress == 100) {
              setState(() {
                isLoading = false;
              });
            }
          },
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
              hasError = false;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
          onWebResourceError: (WebResourceError error) {
            setState(() {
              hasError = true;
              isLoading = false;
            });
          },
        ),
      );

    // Use Google Docs Viewer to display the PDF
    final googleDocsUrl =
        'https://docs.google.com/gview?embedded=true&url=${Uri.encodeComponent(widget.pdfUrl)}';
    controller.loadRequest(Uri.parse(googleDocsUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: context.responsiveTextTheme.current.headLine4SemiBold
              .copyWith(color: Colors.white),
        ),
        backgroundColor: AppColors.accent1Shade1,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.refresh),
            onPressed: () {
              controller.reload();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          if (!hasError)
            WebViewWidget(controller: controller)
          else
            _buildErrorWidget(),
          if (isLoading)
            Container(
              color: Colors.white,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
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
            Icon(
              Iconsax.document_cloud,
              size: 64,
              color: TextColors.ternary.color,
            ),
            const SizedBox(height: AppSizesManager.p16),
            Text(
              context.translation!.feedback_loading_failed,
              style: context.responsiveTextTheme.current.headLine4SemiBold,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizesManager.p8),
            Text(
              context.translation!.feedback_pdf_load_error,
              style: context.responsiveTextTheme.current.body2Regular
                  .copyWith(color: TextColors.ternary.color),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizesManager.p24),
            ElevatedButton.icon(
              onPressed: () {
                initializeWebView();
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
