import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/features/common/image/cached_network_image_with_asset_fallback.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../../config/services/auth/user_manager.dart';
import '../../../../config/services/network/network_interface.dart';

class UserImage extends StatefulWidget {
  const UserImage({
    super.key,
  });

  @override
  State<UserImage> createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  @override
  Widget build(BuildContext context) {
    final userImage = getItInstance.get<UserManager>().currentUser.image;
    final imageUrl = userImage != null
        ? getItInstance.get<INetworkService>().getFilesPath(userImage.path)
        : null;

    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 768;
    final imageSize = isTablet ? 90.0 : 70.0;

    return Padding(
      padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p12),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        height: imageSize,
        width: imageSize,
        child: CachedNetworkImageWithDrawableFallback.withErrorSvgImage(
          imageUrl: imageUrl ?? "",
          fit: BoxFit.cover,
          width: double.maxFinite,
          height: double.maxFinite,
        ),
      ),
    );
  }
}
