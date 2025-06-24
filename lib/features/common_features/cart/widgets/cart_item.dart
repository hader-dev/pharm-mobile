// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:ecom_client_app/utils/constants.dart';
// import 'package:ecom_client_app/utils/extensions/app_context_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';

// import '../../../../models/cart_item.dart';
// import '../../../common/formatted_price.dart';
// import '../../order_details/widgets/order_item_note.dart';
// import '../cubit/cart_cubit.dart';
// import 'quantity_section.dart';

// class CartItemWidget extends StatelessWidget {
//   const CartItemWidget({super.key, required this.cart_item});
//   // ignore: non_constant_identifier_names
//   final CartItemModel cart_item;
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return BlocBuilder<CartCubit, CartState>(
//       builder: (context, state) {
//         return Slidable(
//           endActionPane: ActionPane(
//             extentRatio: 0.3,
//             motion: const ScrollMotion(),
//             children: [
//               SlidableAction(
//                 spacing: AppSizes.extraSmallPadding,
//                 flex: 1,
//                 backgroundColor:
//                     AppColorsPallette.primaryColors.first.withAlpha(50),
//                 foregroundColor: Colors.white,
//                 icon: Icons.notes_rounded,
//                 label: context.translation!.note,
//                 onPressed: (context) {
//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) => OrderNoteDialog(
//                       title: context.translation!.orderItemNote,
//                       id: cart_item.id!,
//                       note: cart_item.note ?? "",
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//           child: InkWell(
//             focusColor: Colors.transparent,
//             highlightColor: Colors.transparent,
//             hoverColor: Colors.transparent,
//             splashColor: Colors.transparent,
//             // onLongPress: () {
//             //   context.read<CartCubit>().isSelectedModeChanged();
//             // },
//             child: Row(
//               children: [
//                 SizedBox(
//                     height: 25,
//                     width: 25,
//                     child: Checkbox(
//                         value: context
//                             .read<CartCubit>()
//                             .selectedItems
//                             .contains(cart_item),
//                         activeColor: AppColorsPallette.primaryColors.first,
//                         side: BorderSide(
//                             color: AppColorsPallette.primaryColors.first
//                                 .withAlpha(80)),
//                         shape: const RoundedRectangleBorder(
//                             borderRadius: BorderRadius.horizontal(
//                                 right: Radius.circular(AppSizes.tinyRadius),
//                                 left: Radius.circular(AppSizes.tinyRadius))),
//                         onChanged: (bool? value) {
//                           context.read<CartCubit>().selectItem(cart_item);
//                         })),
//                 Expanded(
//                   child: Container(
//                     margin: const EdgeInsets.symmetric(
//                         horizontal: 0, vertical: AppSizes.extraSmallPadding),
//                     padding:
//                         const EdgeInsets.all(AppSizes.smallToMediumPadding),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         // Product image
//                         ClipRRect(
//                           borderRadius:
//                               BorderRadius.circular(AppSizes.extraSmallRadius),
//                           child: CachedNetworkImage(
//                             imageUrl: cart_item.article!.imgPath!,
//                             height: 80,
//                             width: 80,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         const SizedBox(width: 12),

//                         // Product info
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               // Title + Delete button
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       cart_item.article!.label,
//                                       style:
//                                           theme.textTheme.titleMedium!.copyWith(
//                                         fontWeight: FontWeight.w600,
//                                         fontSize: AppTypography.appFontSize4,
//                                       ),
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                   ),
//                                   InkWell(
//                                     onTap: () {
//                                       context
//                                           .read<CartCubit>()
//                                           .removeArticle(cart_item.id!);
//                                     },
//                                     child: const CircleAvatar(
//                                       radius: AppSizes.extraSmallRadius,
//                                       child: Icon(
//                                         Icons.close,
//                                         color: Colors.black,
//                                         size: AppSizes.extraSmallIconSize,
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                               const SizedBox(height: 4),
//                               // Subtitle
//                               if (cart_item.article!.optionValues != null &&
//                                   cart_item.article!.optionValues!.isNotEmpty)
//                                 Row(
//                                   children: [
//                                     ...cart_item.article!.optionValues!
//                                         .take(3)
//                                         .map((element) => Container(
//                                               margin: const EdgeInsets.only(
//                                                   right: 8),
//                                               padding: const EdgeInsets.all(3),
//                                               decoration: BoxDecoration(
//                                                 color: Colors.grey[200],
//                                                 borderRadius:
//                                                     BorderRadius.circular(
//                                                         AppSizes.tinyRadius),
//                                               ),
//                                               child: Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: AppSizes
//                                                         .extraSmallPadding,
//                                                     right: AppSizes
//                                                         .extraSmallPadding),
//                                                 child: Text(
//                                                   element.value ?? "",
//                                                   style: theme
//                                                       .textTheme.bodySmall!
//                                                       .copyWith(
//                                                     color: Colors.black87,
//                                                     fontSize: AppTypography
//                                                         .appFontSize6,
//                                                   ),
//                                                   overflow:
//                                                       TextOverflow.ellipsis,
//                                                 ),
//                                               ),
//                                             )),
//                                     if (cart_item
//                                             .article!.optionValues!.length >
//                                         3)
//                                       CircleAvatar(
//                                         radius: 10,
//                                         backgroundColor: Colors.grey[300],
//                                         child: Text(
//                                           '+${cart_item.article!.optionValues!.length - 3}',
//                                           style: theme.textTheme.bodySmall!
//                                               .copyWith(
//                                             color: Colors.black54,
//                                             fontSize:
//                                                 AppTypography.appFontSize6,
//                                           ),
//                                         ),
//                                       ),
//                                   ],
//                                 ),
//                               const SizedBox(height: 12),

//                               Row(
//                                 children: [
//                                   FormattedPrice(
//                                     price: double.parse(((double.tryParse(
//                                                     cart_item
//                                                         .article!.price!) ??
//                                                 0) *
//                                             cart_item.quantity)
//                                         .toStringAsFixed(2)),
//                                     valueStyle: context
//                                         .theme.textTheme.headlineSmall!
//                                         .copyWith(
//                                       fontSize: AppTypography.appFontSize5,
//                                       fontWeight: AppTypography.appFontBold,
//                                       color: Colors.black,
//                                     ),
//                                     unitStyle: TextStyle(
//                                       color: AppColorsPallette
//                                           .lightAccentsColors[3],
//                                       fontSize: AppTypography.appFontSize7,
//                                     ),
//                                   ),
//                                   const Spacer(),
//                                   CartQuantitySection(cartItem: cart_item),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
