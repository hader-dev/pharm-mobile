import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/responsive/device_size.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import 'package:photo_view/photo_view.dart';

// ignore: must_be_immutable
class ProductInteractivePictures extends StatelessWidget {
  final String pictureUrl;

  const ProductInteractivePictures({
    super.key,
    required this.pictureUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p12),
      constraints: BoxConstraints(
        maxHeight: context.responsiveAppSizeTheme.deviceSize.height * 3 / 4,
        maxWidth: context.responsiveAppSizeTheme.deviceSize.height * 3 / 4,
      ),
      child: PhotoView(
        backgroundDecoration: const BoxDecoration(color: Colors.transparent),
        imageProvider: NetworkImage(
          pictureUrl,
        ),
      ),
    );
  }
}
