// import 'package:ecom_client_app/utils/extensions/app_context_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../utils/constants.dart';

// import '../../../../utils/helper_func.dart';
// import '../cubit/order_details_cubit.dart';

// class OrderHeaderSection extends StatelessWidget {
//   const OrderHeaderSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     ValueNotifier showMore = ValueNotifier(false);
//     OrderDetailsCubit cubit = context.read<OrderDetailsCubit>();
//     return Container(
//       width: double.maxFinite,
//       margin: EdgeInsets.all(AppSizes.extraSmallPadding),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(AppSizes.extraSmallRadius / 2),
//       ),
//       padding: EdgeInsets.all(AppSizes.mediumPadding),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             context.translation!.orderRef,
//             style: context.theme.textTheme.bodySmall!.copyWith(
//               color: AppColorsPallette.primaryColors.first.withAlpha(170),
//               fontSize: AppTypography.appFontSize4,
//             ),
//           ),
//           SizedBox(height: AppSizes.smallSpacing),
//           Text(
//             "# ${cubit.orderDetails!.ref ?? context.translation!.noReference}",
//             softWrap: true,
//             overflow: TextOverflow.ellipsis,
//             style: context.theme.textTheme.bodySmall!.copyWith(
//               fontSize: AppTypography.appFontSize4,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           if (cubit.orderDetails!.note != null)
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 SizedBox(height: AppSizes.mediumSpacing),
//                 Text(
//                   context.translation!.order_note,
//                   style: context.theme.textTheme.bodySmall!.copyWith(
//                     color: AppColorsPallette.primaryColors.first.withAlpha(170),
//                     fontSize: AppTypography.appFontSize4,
//                   ),
//                 ),
//                 SizedBox(height: AppSizes.smallSpacing),
//                 //TODO: extract to reusable widget
//                 cubit.orderDetails!.note!.isNotEmpty
//                     ? ValueListenableBuilder(
//                         valueListenable: showMore,
//                         builder: (BuildContext ctx, value, Widget? child) {
//                           return InkWell(
//                             onTap: () => showMore.value = !showMore.value,
//                             child: calculateNumberOfLines(
//                                         cubit.orderDetails!.note!,
//                                         context.theme.textTheme.bodySmall!.copyWith(
//                                           fontWeight: AppTypography.appFontRegular,
//                                         ),
//                                         MediaQuery.sizeOf(context).width) >
//                                     3
//                                 ? Stack(
//                                     alignment: AlignmentDirectional.bottomEnd,
//                                     children: <Widget>[
//                                       Text.rich(
//                                         showMore.value
//                                             ? TextSpan(
//                                                 text: cubit.orderDetails!.note!,
//                                                 style: context.theme.textTheme.bodySmall!.copyWith(
//                                                     height: 1.5,
//                                                     fontWeight: AppTypography.appFontRegular,
//                                                     color: AppColorsPallette.darkAccentsColors.last),
//                                                 children: [
//                                                     TextSpan(
//                                                       text: context.translation!.show_less,
//                                                       style: context.theme.textTheme.bodySmall!.copyWith(
//                                                           height: 1.5,
//                                                           fontWeight: AppTypography.appFontRegular,
//                                                           color: AppColorsPallette.primaryColors.first),
//                                                     )
//                                                   ])
//                                             : TextSpan(
//                                                 text: cubit.orderDetails!.note!,
//                                                 style: context.theme.textTheme.bodySmall!.copyWith(
//                                                     height: 1.5,
//                                                     fontWeight: AppTypography.appFontRegular,
//                                                     color: AppColorsPallette.darkAccentsColors.last),
//                                                 children: [
//                                                     TextSpan(
//                                                       text: ' (${context.translation!.showMore})',
//                                                       style: context.theme.textTheme.bodySmall!.copyWith(
//                                                           height: 1.5,
//                                                           fontWeight: AppTypography.appFontRegular,
//                                                           color: AppColorsPallette.primaryColors.first),
//                                                     )
//                                                   ]),
//                                         softWrap: true,
//                                         maxLines: showMore.value ? null : 2,
//                                       ),
//                                       showMore.value
//                                           ? const SizedBox.shrink()
//                                           : Icon(
//                                               Icons.keyboard_arrow_down_rounded,
//                                               color: AppColorsPallette.primaryColors.first,
//                                               size: AppSizes.mediumIconSize,
//                                             )
//                                     ],
//                                   )
//                                 : Text(cubit.orderDetails!.note!,
//                                     style: context.theme.textTheme.bodySmall!.copyWith(
//                                         height: 1.5,
//                                         fontWeight: AppTypography.appFontRegular,
//                                         color: AppColorsPallette.darkAccentsColors.last)),
//                           );
//                         },
//                       )
//                     : Text(" ${context.translation!.no_additional_notes}",
//                         style: context.theme.textTheme.bodySmall!.copyWith(
//                             fontWeight: AppTypography.appFontRegular, color: AppColorsPallette.darkAccentsColors.last)),
//               ],
//             ),
//         ],
//       ),
//     );
//   }
// }
