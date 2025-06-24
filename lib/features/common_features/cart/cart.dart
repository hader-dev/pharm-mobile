import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  final bool isInHome;
  const CartScreen({super.key, this.isInHome = false});

  @override
  Widget build(BuildContext context) {
    return Placeholder();
    // BlocProvider.value(
    //   value: HomeScreen.scaffoldKey.currentContext!.read<CartCubit>(),
    //   child: Scaffold(
    //     body: SafeArea(
    //         child: Padding(
    //       padding: const EdgeInsets.symmetric(
    //         horizontal: AppSizes.smallPadding,
    //       ),
    //       child: Stack(
    //         children: [
    //           Column(
    //             children: <Widget>[
    //               AppBarWidget(
    //                 topPadding: AppSizes.mediumPadding,
    //                 bottomPadding: AppSizes.mediumPadding,
    //                 title: Text(
    //                   context.translation!.my_cart,
    //                   style: context.theme.textTheme.headlineSmall!.copyWith(fontSize: AppTypography.appFontSize3),
    //                 ),
    //                 trailling: <Widget>[
    //                   BlocBuilder<CartCubit, CartState>(
    //                     builder: (context, state) {
    //                       return InkWell(
    //                         overlayColor: const WidgetStatePropertyAll(Colors.transparent),
    //                         onTap: () {
    //                           ValidateActionDialog().showValidateActionDialog(
    //                             context: context,
    //                             title: Text(
    //                               context.translation!.clear_cart,
    //                               style: context.theme.textTheme.headlineSmall,
    //                             ),
    //                             content: Text(
    //                               context.translation!.clear_cart_confirmation,
    //                             ),
    //                             agreeText: context.translation!.clear,
    //                             cancelText: context.translation!.cancel,
    //                             onValidate: () {
    //                               context.read<CartCubit>().removeAll();
    //                             },
    //                             dialogType: DialogType.warning,
    //                           );
    //                         },
    //                         child: Padding(
    //                           padding: const EdgeInsets.all(4),
    //                           child: Icon(
    //                             LucideIcons.trash2,
    //                             color: Colors.redAccent[400],
    //                           ),
    //                         ),
    //                       );
    //                     },
    //                   )
    //                 ],
    //                 leading: isInHome
    //                     ? const SizedBox.shrink()
    //                     : GestureDetector(
    //                         onTap: () {
    //                           GoRouter.of(context).pop();
    //                         },
    //                         child: const Icon(
    //                           Icons.arrow_back_ios_new,
    //                         ),
    //                       ),
    //               ),
    //               Expanded(child: BlocBuilder<CartCubit, CartState>(
    //                 builder: (BuildContext context, CartState state) {
    //                   if (state is CartLoading) {
    //                     return const LoadingWidget();
    //                   } else if (state is CartError) {
    //                     return const CustomErrorWidget();
    //                   }
    //                   if (state is CartLoadingSuccess && context.read<CartCubit>().cartItems.isEmpty) {
    //                     return Center(
    //                       child: EmptyResultWidget(
    //                         onRefresh: () async {
    //                           await context.read<CartCubit>().getCartItem();
    //                         },
    //                       ),
    //                     );
    //                   }
    //                   return Column(
    //                     children: <Widget>[
    //                       if (context.read<CartCubit>().isSelectedMode)
    //                         if (context.read<CartCubit>().cartItems.isNotEmpty)
    //                           Padding(
    //                             padding: const EdgeInsets.only(top: AppSizes.mediumPadding),
    //                             child: Row(
    //                               children: <Widget>[
    //                                 SizedBox(
    //                                     height: 25,
    //                                     width: 25,
    //                                     child: Checkbox(
    //                                         value: context.read<CartCubit>().selectedItems.length ==
    //                                             context.read<CartCubit>().cartItems.length,
    //                                         activeColor: AppColorsPallette.primaryColors.first,
    //                                         side:
    //                                             BorderSide(color: AppColorsPallette.primaryColors.first.withAlpha(80)),
    //                                         shape: const RoundedRectangleBorder(
    //                                             borderRadius: BorderRadius.horizontal(
    //                                                 right: Radius.circular(AppSizes.tinyRadius),
    //                                                 left: Radius.circular(AppSizes.tinyRadius))),
    //                                         onChanged: (bool? value) {
    //                                           context.read<CartCubit>().selectedItems.length ==
    //                                                   context.read<CartCubit>().cartItems.length
    //                                               ? context.read<CartCubit>().unSelectAll()
    //                                               : context.read<CartCubit>().selectAll();
    //                                         })),
    //                                 const SizedBox(
    //                                   width: AppSizes.smallSpacing,
    //                                 ),
    //                                 Text(
    //                                   context.translation!.select_all,
    //                                   style: context.theme.textTheme.bodySmall!
    //                                       .copyWith(fontWeight: AppTypography.appFontSemiBold),
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                       Expanded(
    //                         child: RefreshIndicator(
    //                           onRefresh: () async {
    //                             await context.read<CartCubit>().getCartItem();
    //                           },
    //                           child: ListView.builder(
    //                             physics: const AlwaysScrollableScrollPhysics(),
    //                             shrinkWrap: true,
    //                             itemCount: context.read<CartCubit>().cartItems.length,
    //                             itemBuilder: (BuildContext context, int index) {
    //                               return Column(
    //                                 children: [
    //                                   CartItemWidget(
    //                                     cart_item: context.read<CartCubit>().cartItems[index],
    //                                   ),
    //                                   if (index < context.read<CartCubit>().cartItems.length - 1)
    //                                     Padding(
    //                                       padding:
    //                                           const EdgeInsets.only(left: 39, right: AppSizes.smallToMediumPadding),
    //                                       child: Divider(
    //                                         color: Colors.grey.shade200,
    //                                         height: 0.5,
    //                                       ),
    //                                     ),
    //                                 ],
    //                               );
    //                             },
    //                           ),
    //                         ),
    //                       ),
    //                     ],
    //                   );
    //                 },
    //               )),
    //               CartSummary(),
    //             ],
    //           ),
    //           BlocBuilder<CartCubit, CartState>(
    //             builder: (context, state) {
    //               if (state is CartLoadingUpdate) {
    //                 return Positioned(
    //                   top: 0,
    //                   bottom: 0,
    //                   left: 0,
    //                   right: 0,
    //                   child: InkWell(
    //                     onTap: () {},
    //                     child: Container(
    //                       child: Column(
    //                         mainAxisAlignment: MainAxisAlignment.center,
    //                         children: [
    //                           Container(
    //                               height: 50,
    //                               width: 50,
    //                               alignment: Alignment.center,
    //                               decoration: BoxDecoration(
    //                                   border: Border.all(color: Colors.grey, width: 1),
    //                                   color: Colors.white,
    //                                   borderRadius: BorderRadius.circular(AppSizes.tinyRadius)),
    //                               child: const LoadingWidget()),
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                 );
    //               }
    //               return const SizedBox.shrink();
    //             },
    //           ),
    //         ],
    //       ),
    //     )),
    //   ),
    // );
  }
}
