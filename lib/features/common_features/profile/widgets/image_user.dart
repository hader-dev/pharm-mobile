import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';

import '../../../../config/services/auth/user_manager.dart';
import '../../../../config/services/network/network_interface.dart';

class UserImage extends StatelessWidget {
  const UserImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userImage = getItInstance.get<UserManager>().currentUser.image;
    final imageUrl = userImage != null
        ? getItInstance.get<INetworkService>().getFilesPath(userImage.path)
        : null;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Hero(
        tag: "avatar",
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            height: 70,
            width: 70,
            child: userImage == null
                ? SvgPicture.asset(DrawableAssetStrings.defaultProfileImgIcon)
                : CachedNetworkImage(
                    imageUrl: imageUrl!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) {
                      return SvgPicture.asset(
                          DrawableAssetStrings.defaultProfileImgIcon);
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
