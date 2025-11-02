import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class OrderNoteDialog extends StatelessWidget {
  final String title;
  final String note;
  final VoidCallback? onClose;

  final int? id;

  const OrderNoteDialog({
    super.key,
    required this.title,
    required this.note,
    this.onClose,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: EdgeInsets.all(24),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Title Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (onClose != null) onClose!();
                  },
                ),
              ],
            ),
            const ResponsiveGap.s12(),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                note.isNotEmpty
                    ? note
                    : context.translation!.no_additional_notes,
                style: context.responsiveTextTheme.current.headLine4Medium
                    .copyWith(
                  color: note.isNotEmpty ? Colors.grey[800] : Colors.grey[400],
                ),
              ),
            ),

            const ResponsiveGap.s8(),
          ],
        ),
      ),
    );
  }
}
