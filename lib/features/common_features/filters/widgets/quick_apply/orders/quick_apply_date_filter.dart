// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
// import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
// import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
// import 'package:hader_pharm_mobile/features/common/widgets/bottom_sheet_header.dart';
// import 'package:hader_pharm_mobile/features/common_features/filters/actions/apply_filters.dart';
// import 'package:hader_pharm_mobile/features/common_features/filters/cubit/orders/orders_filters_cubit.dart';
// import 'package:hader_pharm_mobile/features/common_features/filters/widgets/common/selected_filters_display.dart';
// import 'package:hader_pharm_mobile/models/order_filters.dart';
// import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
// import 'package:iconsax/iconsax.dart';

// class QuickApplyFilterDateOrder extends StatelessWidget {
//   const QuickApplyFilterDateOrder({
//     super.key,
//     required this.title,
//     this.filterKey = OrderFiltersKeys.createdAtFrom,
//   });

//   final String title;
//   final OrderFiltersKeys filterKey;

//   void onFilterSelected(String value, bool selected, OrdersFiltersCubit cubit) {
//     cubit.updatedAppliedFilters(value, selected);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cubit = context.read<OrdersFiltersCubit>();

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       cubit.updateFilterKey(filterKey);
//     });

//     return Column(
//       mainAxisSize: MainAxisSize.max,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         BottomSheetHeader(
//           title: title,
//         ),
//         const ResponsiveGap.s12(),
//         Divider(color: AppColors.bgDisabled, thickness: 1, height: 1),
//         BlocBuilder<OrdersFiltersCubit, OrdersFiltersState>(
//           builder: (context, state) {
//             return SelectedFiltersDisplay(
//               selectedFilters: cubit.getCurrentWorkAppliedFilters(),
//               onRemoveFilter: (filter) =>
//                   onFilterSelected(filter, false, cubit),
//             );
//           },
//         ),
//         const ResponsiveGap.s8(),
//         SizedBox(
//           height: MediaQuery.of(context).size.height * 0.5,
//           child: BlocBuilder<OrdersFiltersCubit, OrdersFiltersState>(
//             builder: (context, state) {
//               final filters = state.appliedFilters.getFilterBykey(filterKey);

//               return Scaffold(
//                 resizeToAvoidBottomInset: true,
//                 body: SafeArea(
//                   child:
//                 ),
//                 bottomNavigationBar: SafeArea(
//                   child: Padding(
//                     padding:
//                         EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           flex: 1,
//                           child: PrimaryTextButton(
//                             isOutLined: true,
//                             label: context.translation!.reset,
//                             spalshColor: AppColors.accent1Shade1.withAlpha(50),
//                             labelColor: AppColors.accent1Shade1,
//                             onTap: () {
//                               cubit.resetCurrentFilters();
//                             },
//                             borderColor: AppColors.accent1Shade1,
//                           ),
//                         ),
//                         const ResponsiveGap.s8(),
//                         Expanded(
//                           flex: 1,
//                           child: PrimaryTextButton(
//                             label: context.translation!.confirm,
//                             leadingIcon: Iconsax.money4,
//                             onTap: () {
//                               applyFiltersOrder(context);
//                               context.pop();
//                             },
//                             color: AppColors.accent1Shade1,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
