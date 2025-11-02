import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common_features/anouncement_details/cubit/announcement_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/pdf_viewer/pdf_viewer_screen.dart';
import 'package:hader_pharm_mobile/models/announcement.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class AnnouncementDocumentsPage extends StatelessWidget {
  const AnnouncementDocumentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => context.read<AnnouncementCubit>().loadAnnouncement(),
      child: BlocBuilder<AnnouncementCubit, AnnouncementState>(
          builder: (context, state) {
        if (state is AnnouncementIsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final hasApiPdf = state.announcement.pdf != null;

        if (!hasApiPdf) {
          return RefreshIndicator(
            onRefresh: () =>
                context.read<AnnouncementCubit>().loadAnnouncement(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Center(
                  child: EmptyListWidget(),
                ),
              ),
            ),
          );
        }

        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p16),
          child: Column(
            children: [
              if (hasApiPdf)
                _buildDocumentCard(context, state.announcement.pdf!),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildDocumentCard(BuildContext context, PdfDocument pdf) {
    final sizeInMB = (int.parse(pdf.size) / (1024 * 1024)).toStringAsFixed(2);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            context.responsiveAppSizeTheme.current.commonWidgetsRadius),
      ),
      child: InkWell(
        onTap: () => _openPdf(context, pdf),
        borderRadius: BorderRadius.circular(
            context.responsiveAppSizeTheme.current.commonWidgetsRadius),
        child: Padding(
          padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.accent1Shade1.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Iconsax.document,
                      color: AppColors.accent1Shade1,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: context.responsiveAppSizeTheme.current.p12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pdf.filename,
                          style:
                              context.responsiveTextTheme.current.body2Medium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                            height: context.responsiveAppSizeTheme.current.p4),
                        Text(
                          'PDF • $sizeInMB MB',
                          style: context.responsiveTextTheme.current.bodySmall
                              .copyWith(color: TextColors.ternary.color),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Iconsax.arrow_right_3,
                    color: TextColors.ternary.color,
                    size: 16,
                  ),
                ],
              ),
              SizedBox(height: context.responsiveAppSizeTheme.current.p12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _openPdf(context, pdf),
                      icon: const Icon(Iconsax.eye, size: 18),
                      label: Text(context.translation!.see_all),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent1Shade1,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              context.responsiveAppSizeTheme.current.p16,
                          vertical: context.responsiveAppSizeTheme.current.p12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openPdf(BuildContext context, PdfDocument pdf) async {
    try {
      final String fullUrl;
      if (pdf.path.startsWith('http://') || pdf.path.startsWith('https://')) {
        fullUrl = pdf.path;
      } else {
        final networkService = getItInstance.get<INetworkService>();
        final baseUrl = networkService.baseUrl;
        fullUrl = '$baseUrl/files/${pdf.path}';
      }

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PdfViewerScreen(
            pdfUrl: fullUrl,
            title: pdf.filename,
          ),
        ),
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.translation!.feedback_loading_failed),
            backgroundColor: SystemColors.red.primary,
          ),
        );
      }
    }
  }
}
