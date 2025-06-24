// import 'package:ecom_client_app/config/routes/routing_manager.dart';
// import 'package:ecom_client_app/utils/extensions/app_context_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:go_router/go_router.dart';

// import '../../../../utils/constants.dart';
// import '../../../common/button_widget.dart';

// import '../../../common/formatted_price.dart';
// import '../cubit/cart_cubit.dart';

// class CartSummary extends StatelessWidget {
//   ValueNotifier<bool> isExpanded = ValueNotifier(true);
//   CartSummary({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder(
//         valueListenable: isExpanded,
//         builder: (BuildContext context, bool value, Widget? child) {
//           return InkWell(
//             onTap: () {
//               isExpanded.value = !isExpanded.value;
//             },
//             child: Container(
//               margin: const EdgeInsets.only(bottom: AppSizes.smallPadding),
//               padding: const EdgeInsets.all(AppSizes.mediumPadding),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(color: Colors.grey[300]!),
//                 borderRadius: const BorderRadius.all(
//                   Radius.circular(AppSizes.extraSmallRadius),
//                 ),
//               ),
//               child: !isExpanded.value
//                   ? Row(children: <Widget>[
//                       Text(
//                         context.translation!.summary,
//                         style: context.theme.textTheme.bodySmall!
//                             .copyWith(fontSize: AppTypography.appFontSize4, fontWeight: AppTypography.appFontSemiBold),
//                       ),
//                       const Spacer(),
//                       Icon(Icons.keyboard_arrow_up_sharp,
//                           color: context.theme.primaryColor, size: AppSizes.smallToMediumIconSize),
//                     ])
//                   : Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
//                       Container(
//                           height: 5,
//                           width: 50,
//                           decoration: BoxDecoration(
//                               color: Colors.grey[300], borderRadius: BorderRadius.circular(AppSizes.extraSmallRadius))),
//                       Padding(
//                         padding: const EdgeInsets.only(top: AppSizes.smallPadding, bottom: AppSizes.mediumPadding),
//                         child: Row(
//                           children: <Widget>[
//                             const Spacer(),
//                             Icon(Icons.close, color: context.theme.primaryColor, size: AppSizes.smallToMediumIconSize),
//                           ],
//                         ),
//                       ),
//                       Row(
//                         children: <Widget>[
//                           Text(
//                             context.translation!.tva,
//                             style: context.theme.textTheme.bodySmall!
//                                 .copyWith(fontSize: AppTypography.appFontSize5, color: Colors.grey[600]),
//                           ),
//                           const Spacer(),
//                           BlocBuilder<CartCubit, CartState>(
//                             builder: (context, state) {
//                               return FormattedPrice(
//                                 price: double.parse(
//                                     (context.read<CartCubit>().totalTTCAmount - context.read<CartCubit>().totalHtAmount)
//                                         .toStringAsFixed(2)),
//                                 valueStyle: context.theme.textTheme.headlineSmall!.copyWith(
//                                   fontSize: AppTypography.appFontSize4,
//                                   fontWeight: AppTypography.appFontBold,
//                                   color: Colors.grey,
//                                 ),
//                                 unitStyle: TextStyle(
//                                   color: AppColorsPallette.lightAccentsColors[3],
//                                   fontSize: AppTypography.appFontSize6,
//                                 ),
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: AppSizes.smallPadding,
//                       ),
//                       Row(
//                         children: <Widget>[
//                           Text(
//                             context.translation!.total_ht_amount,
//                             style: context.theme.textTheme.bodySmall!
//                                 .copyWith(fontSize: AppTypography.appFontSize5, color: Colors.grey[600]),
//                           ),
//                           const Spacer(),
//                           BlocBuilder<CartCubit, CartState>(
//                             builder: (context, state) {
//                               return FormattedPrice(
//                                 price: double.parse(context.read<CartCubit>().totalHtAmount.toStringAsFixed(2)),
//                                 valueStyle: context.theme.textTheme.headlineSmall!.copyWith(
//                                   fontSize: AppTypography.appFontSize4,
//                                   fontWeight: AppTypography.appFontBold,
//                                   color: Colors.grey,
//                                 ),
//                                 unitStyle: TextStyle(
//                                   color: AppColorsPallette.lightAccentsColors[3],
//                                   fontSize: AppTypography.appFontSize6,
//                                 ),
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: AppSizes.smallPadding,
//                       ),
//                       Text(
//                         '---------------------------------------',
//                         style: TextStyle(letterSpacing: 1.5, color: Colors.grey.withOpacity(0.5)),
//                       ),
//                       Row(
//                         children: <Widget>[
//                           Text(
//                             context.translation!.total_ttc_amount,
//                             style: context.theme.textTheme.bodySmall!
//                                 .copyWith(fontSize: AppTypography.appFontSize5, color: Colors.grey[600]),
//                           ),
//                           const Spacer(),
//                           BlocBuilder<CartCubit, CartState>(
//                             builder: (BuildContext context, CartState state) {
//                               return FormattedPrice(
//                                 price: double.parse(context.read<CartCubit>().totalTTCAmount.toStringAsFixed(2)),
//                                 valueStyle: context.theme.textTheme.headlineSmall!.copyWith(
//                                   fontSize: AppTypography.appFontSize4,
//                                   fontWeight: AppTypography.appFontBold,
//                                   color: Colors.black,
//                                 ),
//                                 unitStyle: TextStyle(
//                                   color: AppColorsPallette.lightAccentsColors[3],
//                                   fontSize: AppTypography.appFontSize6,
//                                 ),
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                       BlocBuilder<CartCubit, CartState>(
//                         builder: (context, state) {
//                           return context.read<CartCubit>().selectedItems.isNotEmpty
//                               ? Padding(
//                                   padding: const EdgeInsets.symmetric(vertical: AppSizes.mediumPadding),
//                                   child: BlocBuilder<CartCubit, CartState>(
//                                     builder: (BuildContext context, CartState state) {
//                                       final int selectedCount = context.read<CartCubit>().selectedItems.length;
//                                       return CommonButton(
//                                         labelColor: Colors.white,
//                                         height: 45,
//                                         minWidth: double.maxFinite,
//                                         label:
//                                             '${context.translation!.checkout}${selectedCount == 0 ? '' : " ($selectedCount)"}',
//                                         color: AppColorsPallette.primaryColors.first,
//                                         onTap: () {
//                                           if (selectedCount == 0) {
//                                             Fluttertoast.showToast(
//                                               msg: 'Please select at least one item to checkout.',
//                                               toastLength: Toast.LENGTH_SHORT,
//                                               gravity: ToastGravity.BOTTOM,
//                                               textColor: Colors.black,
//                                             );
//                                             return;
//                                           }
//                                           GoRouter.of(context).pushNamed(RoutingManager.checkOutScreen,
//                                               extra: context.read<CartCubit>().selectedItems);
//                                         },
//                                       );
//                                     },
//                                   ),
//                                 )
//                               : const SizedBox.shrink();
//                         },
//                       ),
// // ...existing code...
// // ...existing code...
//                     ]),
//             ),
//           );
//         });
//   }
// }
