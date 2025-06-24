// import 'dart:async';

// import 'package:ecom_client_app/utils/extensions/app_context_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../models/cart_item.dart';
// import '../../../../utils/constants.dart';
// import '../cubit/cart_cubit.dart';

// class CartQuantitySection extends StatefulWidget {
//   final CartItemModel cartItem;

//   const CartQuantitySection({super.key, required this.cartItem});

//   @override
//   State<CartQuantitySection> createState() => _CartQuantitySectionState();
// }

// class _CartQuantitySectionState extends State<CartQuantitySection> {
//   late TextEditingController _controller;
//   double _scaleMinus = 1.0;
//   double _scalePlus = 1.0;

//   @override
//   void initState() {
//     super.initState();
//     _controller =
//         TextEditingController(text: widget.cartItem.quantity.toString());
//   }

//   @override
//   void didUpdateWidget(covariant CartQuantitySection oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     // Update controller text if quantity changed externally
//     if (oldWidget.cartItem.quantity != widget.cartItem.quantity) {
//       _controller.text = widget.cartItem.quantity.toString();
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     _debounce?.cancel();
//     super.dispose();
//   }

//   void _animateButton(bool isPlus) {
//     setState(() {
//       if (isPlus) {
//         _scalePlus = 1.2;
//       } else {
//         _scaleMinus = 1.2;
//       }
//     });

//     Future.delayed(const Duration(milliseconds: 150), () {
//       setState(() {
//         _scalePlus = 1.0;
//         _scaleMinus = 1.0;
//       });
//     });
//   }

//   void _updateQuantityFromInput(String value) {
//     final qty = int.tryParse(value);
//     if (qty != null && qty > 0) {
//       // Instead of directly mutating cartItem, just notify Cubit to update
//       context.read<CartCubit>().updateCartItemQuantity(widget.cartItem, qty);
//     } else {
//       // Reset text if invalid input
//       _controller.text = widget.cartItem.quantity.toString();
//     }
//   }

// // Add this to your state class:
//   Timer? _debounce;

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CartCubit, CartState>(
//       builder: (BuildContext context, CartState state) {
//         return AnimatedContainer(
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeInOut,
//           height: 30,
//           padding:
//               const EdgeInsets.symmetric(horizontal: AppSizes.smallPadding),
//           decoration: BoxDecoration(
//             color: Colors.grey.shade200,
//             borderRadius: BorderRadius.circular(AppSizes.extraSmallRadius),
//             border: Border.all(color: Colors.grey.shade200),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.04),
//                 blurRadius: 4,
//                 offset: const Offset(0, 2),
//               )
//             ],
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               // Minus button with animation
//               AnimatedScale(
//                 scale: _scaleMinus,
//                 duration: const Duration(milliseconds: 150),
//                 child: GestureDetector(
//                   onTap: () {
//                     context
//                         .read<CartCubit>()
//                         .decreaseCartItemQuantity(widget.cartItem);
//                     _animateButton(false);
//                   },
//                   child:
//                       const Icon(Icons.remove, size: 18, color: Colors.black),
//                 ),
//               ),

//               const SizedBox(width: 12),

//               // Quantity input
//               SizedBox(
//                 width: 30,
//                 child: TextField(
//                   keyboardType: TextInputType.name,
//                   controller: TextEditingController(
//                     text: widget.cartItem.quantity.toString(),
//                   ),
//                   onChanged: (String value) {
//                     if (_debounce?.isActive ?? false) _debounce!.cancel();
//                     _debounce = Timer(const Duration(seconds: 1), () {
//                       if (value.isNotEmpty) {
//                         final qty = int.tryParse(value);
//                         if (qty != null && qty > 0) {
//                           context
//                               .read<CartCubit>()
//                               .updateCartItemQuantity(widget.cartItem, qty);
//                           FocusScope.of(context)
//                               .unfocus(); // Close the keyboard
//                         }
//                       }
//                     });
//                   },
//                   textAlign: TextAlign.center,
//                   style: context.theme.textTheme.bodyMedium!.copyWith(
//                     fontSize: AppTypography.appFontSize5,
//                     color: Colors.black,
//                     fontWeight: AppTypography.appFontBold,
//                   ),
//                   decoration: InputDecoration(
//                     border: InputBorder.none,
//                     hintText: widget.cartItem.quantity.toString(),
//                     hintStyle: context.theme.textTheme.bodyMedium!.copyWith(
//                       fontSize: AppTypography.appFontSize3,
//                       color:
//                           AppColorsPallette.primaryColors.first.withAlpha(100),
//                       fontWeight: AppTypography.appFontBold,
//                     ),
//                   ),
//                 ),
//               ),

//               const SizedBox(width: 12),

//               // Plus button with animation
//               AnimatedScale(
//                 scale: _scalePlus,
//                 duration: const Duration(milliseconds: 150),
//                 child: GestureDetector(
//                   onTap: () {
//                     context.read<CartCubit>().addCartItem(widget.cartItem);
//                     _animateButton(true);
//                   },
//                   child: const Icon(Icons.add, size: 18, color: Colors.black),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
