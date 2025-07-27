import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../utils/constants.dart';
import '../cubit/home_cubit.dart';
import 'promotion_item_widget.dart';

class PromotionSection extends StatelessWidget {
  final List<String> promotionsUrls;
  final PageController pageController = PageController(initialPage: 0);
  PromotionSection({super.key, this.promotionsUrls = const <String>[]});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (BuildContext context, HomeState state) {
        if (state is PromotionLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is PromotionLoadingFailed) {
          return const Text(
            'Failed to load promotions',
          );
        }
        return Padding(
          padding: const EdgeInsets.only(
            right: AppSizesManager.p8,
            left: AppSizesManager.p8,
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(AppSizesManager.commonWidgetsRadius)),
                height: 130,
                width: MediaQuery.of(context).size.width,
                child: PageView(
                  controller: pageController,
                  scrollDirection: Axis.horizontal,
                  children: promotionsUrls
                      .map(
                        (String promotionUrl) => PromotionItemWidget(promotionUrl: promotionUrl),
                      )
                      .toList(),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
                ),
                padding: const EdgeInsets.all(AppSizesManager.p4),
                margin: const EdgeInsets.all(AppSizesManager.p4),
                child: SmoothPageIndicator(
                  controller: pageController,
                  effect: const ExpandingDotsEffect(
                    dotHeight: 4,
                    dotWidth: 4,
                    spacing: 2,
                    dotColor: Colors.grey,
                    activeDotColor: Colors.white,
                  ),
                  count: promotionsUrls.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
