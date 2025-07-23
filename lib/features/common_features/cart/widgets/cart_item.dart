import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/theme/typoghrapy_manager.dart';
import 'package:hader_pharm_mobile/features/common_features/create_company_profile/sub_pages/review&submit/widgets/info_row.dart';
import 'package:hader_pharm_mobile/models/cart_item.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

import '../cubit/cart_cubit.dart';
import 'cart_item_quantity_section.dart';

class CartItemWidget extends StatelessWidget {
  final CartItemModel cartItemData;

  const CartItemWidget({super.key, required this.cartItemData});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppSizesManager.p8, horizontal: AppSizesManager.p4),
      padding: const EdgeInsets.symmetric(vertical: AppSizesManager.p10, horizontal: AppSizesManager.p10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
      ),
      child: Row(
        children: [
          //   CacheNetworkImagePlus(
          //   height: 70,
          //   width: 70,

          //   boxFit: BoxFit.fill,
          //   imageUrl: cartItemData. != null
          //       ? getItInstance
          //           .get<INetworkService>()
          //           .getFilesPath(BlocProvider.of<MedicineDetailsCubit>(context).medicineCatalogData!.image!.path)
          //       : "",
          //   errorWidget: Column(
          //     children: [
          //       Spacer(),
          //       Icon(Iconsax.image, color: Color.fromARGB(255, 197, 197, 197), size: AppSizesManager.iconSize30),
          //       Gap(AppSizesManager.s8),
          //       Text(
          //         "Image not available",
          //         style: AppTypography.body3MediumStyle.copyWith(color: const Color.fromARGB(255, 197, 197, 197)),
          //       ),
          //       Spacer(),
          //     ],
          //   ),
          // ),

          const Gap(AppSizesManager.s12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      cartItemData.designation,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.headLine5SemiBoldStyle,
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        BlocProvider.of<CartCubit>(context).deleteCartItem(cartItemData.id);
                      },
                      child: const Icon(
                        Iconsax.trash,
                        color: Colors.red,
                        size: AppSizesManager.iconSize20,
                      ),
                    )
                  ],
                ),
                const Gap(AppSizesManager.s12),
                Column(
                  children: [
                    InfoRow(
                      label: context.translation!.unitHtPrice,
                      dataValue: num.parse(cartItemData.unitPriceHt).toStringAsFixed(2),
                    ),
                    InfoRow(
                      label: context.translation!.unitTtcPrice,
                      dataValue: num.parse(cartItemData.unitPriceTtc).toStringAsFixed(2),
                    ),
                    InfoRow(
                      label: "${context.translation!.tva}%",
                      dataValue: num.parse(cartItemData.tvaPercentage).toStringAsFixed(2),
                    ),
                    Row(
                      children: [
                        Spacer(),
                        QuantitySection(
                          cartData: cartItemData,
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
