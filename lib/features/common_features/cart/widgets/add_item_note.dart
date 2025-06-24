// import 'package:ecom_client_app/utils/constants.dart';
// import 'package:ecom_client_app/utils/extensions/app_context_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../home/home_screen.dart';
// import '../cubit/cart_cubit.dart';

// class AddNoteDialog extends StatelessWidget {
//   final String title;
//   final String note;
//   final VoidCallback? onClose;
//   final int id;

//   AddNoteDialog({
//     Key? key,
//     required this.title,
//     required this.note,
//     required this.id,
//     this.onClose,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     TextEditingController _noteController = TextEditingController(text: note);

//     return BlocProvider.value(
//       value: HomeScreen.scaffoldKey.currentContext!.read<CartCubit>(),
//       child: Dialog(
//         backgroundColor: Colors.white,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         insetPadding: const EdgeInsets.all(24),
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               // Title Row
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Text(
//                     title,
//                     style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                           fontWeight: FontWeight.bold,
//                         ),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.close),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                       if (onClose != null) onClose!();
//                     },
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 10),

//               // Note Content
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: TextField(
//                   controller: _noteController,
//                   maxLines: 5,
//                   decoration: InputDecoration(
//                     hintText: "Add your note here...",
//                     hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                           fontSize: AppTypography.appFontSize4,
//                           color: Colors.grey[400],
//                         ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide(color: Colors.grey.shade300),
//                     ),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: AppSizes.mediumSpacing),

//               // Button (optional)
//               BlocBuilder<CartCubit, CartState>(
//                 builder: (context, state) {
//                   return Align(
//                     alignment: Alignment.centerRight,
//                     child: Row(
//                       children: [
//                         const Spacer(),
//                         TextButton.icon(
//                           icon: const Icon(Icons.save, color: Colors.green),
//                           label: Text(
//                               "${note.isEmpty ? "Add Note" : "Update Note"}"),
//                           onPressed: () {
//                             context.read<CartCubit>().addNote(
//                                   id: id,
//                                   note: _noteController.text,
//                                 );
//                             Navigator.of(context).pop();
//                           },
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
