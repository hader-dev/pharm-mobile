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

            // // Button (optional)
            // Align(
            //   alignment: Alignment.centerRight,
            //   child: Row(
            //     children: [
            //       // TextButton.icon(
            //       //   icon: const Icon(Icons.note_add_rounded, color: Colors.amber),
            //       //   label: Text(note == "" ? "Add Note" : "Update Note"),
            //       //   onPressed: () {
            //       //     Navigator.of(context).pop();
            //       //     showDialog(
            //       //       context: context,
            //       //       builder: (BuildContext context) => AddNoteDialog(
            //       //         title: "context.translation!.orderItemNote",
            //       //         id: id ?? 0,
            //       //         note: note ?? "",
            //       //       ),
            //       //     );
            //       //   },
            //       // ),
            //       const Spacer(),
            //       TextButton.icon(
            //         icon: const Icon(Icons.check_circle, color: Colors.green),
            //         label: Text(context.translation!.gotIt),
            //         onPressed: () => Navigator.of(context).pop(),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
