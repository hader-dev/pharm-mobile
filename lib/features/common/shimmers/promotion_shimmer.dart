import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart' show CarouselSlider;
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/shimmer_helper.dart'
    show ShimmerHelper;

class PromotionsShimmer extends StatelessWidget {
  final PageController pageController = PageController();
  PromotionsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final minSectionHeight = screenSize.height * 0.15;
    List<Widget> shimmerList = List.generate(
        4,
        (index) => ShimmerHelper.generateShimmer(
            height: 100,
            width: double.maxFinite,
            radius: context.responsiveAppSizeTheme.current.r4));

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsiveAppSizeTheme.current.p8,
      ),
      child: SizedBox(
        height: minSectionHeight * 1.2,
        child: Column(
          children: <Widget>[
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(context
                      .responsiveAppSizeTheme.current.commonWidgetsRadius)),
              height: minSectionHeight * 1.2,
              width: MediaQuery.of(context).size.width,
              child: LayoutBuilder(builder: (context, constraints) {
                return CarouselSlider(
                  options: CarouselOptions(
                    viewportFraction: .90,
                    enableInfiniteScroll: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 5),
                    pageSnapping: true,
                    disableCenter: true,
                  ),
                  items: shimmerList
                      .map((Widget shimmerItem) => shimmerItem)
                      .toList(),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
