import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';

import '../../../../config/theme/typoghrapy_manager.dart';

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
      insetPadding: const EdgeInsets.all(24),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
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
            const SizedBox(height: 10),

            // Note Content
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                note.isNotEmpty ? note : " context.translation!.noAdditionalNotes",
                style: AppTypography.headLine4MediumStyle.copyWith(
                  color: note.isNotEmpty ? Colors.grey[800] : Colors.grey[400],
                ),
              ),
            ),

            const SizedBox(height: AppSizesManager.p8),
          ],
        ),
      ),
    );
  }
}
