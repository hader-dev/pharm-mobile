import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:hader_pharm_mobile/config/responsive/device_size.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart'
    show AppColors;
import 'package:hader_pharm_mobile/features/app_layout/app_layout.dart';
import 'package:hader_pharm_mobile/features/app_layout/cubit/app_layout_cubit.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/cubit/cart_cubit.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart'
    show DrawableAssetStrings;
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class MarketplaceAppBar extends StatelessWidget {
  final bool isExtraLargeScreen;

  const MarketplaceAppBar({
    super.key,
    required this.isExtraLargeScreen,
  });

  @override
  Widget build(BuildContext context) {
    final offset = context.deviceSize.width <= DeviceSizes.largeMobile.width
        ? Offset(7, -9)
        : Offset(-15, 5);

    return CustomAppBarV2.normal(
      topPadding: context.responsiveAppSizeTheme.current.p8,
      bottomPadding: context.responsiveAppSizeTheme.current.p8,
      rightPadding: context.responsiveAppSizeTheme.current.p8,
      leftPadding: context.responsiveAppSizeTheme.current.p8,
      leading: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: context.responsiveAppSizeTheme.current.p8),
          child: SvgPicture.asset(DrawableAssetStrings.newMarketIcon,
              height: context.responsiveAppSizeTheme.current.iconSize25,
              width: context.responsiveAppSizeTheme.current.iconSize25,
              colorFilter: ColorFilter.mode(
                AppColors.accent1Shade1,
                BlendMode.srcIn,
              ))),
      title: Text(
        context.translation!.market_place,
        style: context.responsiveTextTheme.current.headLine2.copyWith(
          color: AppColors.accent1Shade1,
        ),
      ),
      trailing: [
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          child: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: context.responsiveAppSizeTheme.current.p8),
                child: state.cartItems.isEmpty
                    ? SvgPicture.asset(DrawableAssetStrings.newEmptyCartIcon,
                        height:
                            context.responsiveAppSizeTheme.current.iconSize20,
                        width:
                            context.responsiveAppSizeTheme.current.iconSize20,
                        colorFilter: ColorFilter.mode(
                          AppColors.accent1Shade1,
                          BlendMode.srcIn,
                        ))
                    : Badge.count(
                        count: state.cartItems.length,
                        textStyle:
                            context.responsiveTextTheme.current.body3Medium,
                        offset: offset,
                        child: SvgPicture.asset(
                            DrawableAssetStrings.newFilledCartIcon,
                            height: context
                                .responsiveAppSizeTheme.current.iconSize20,
                            width: context
                                .responsiveAppSizeTheme.current.iconSize20,
                            colorFilter: ColorFilter.mode(
                              AppColors.accent1Shade1,
                              BlendMode.srcIn,
                            ))),
              );
            },
          ),
          onTap: () {
            AppLayout.appLayoutScaffoldKey.currentContext!
                .read<AppLayoutCubit>()
                .changePage(2);
          },
        ),
      ],
    );
  }
}
