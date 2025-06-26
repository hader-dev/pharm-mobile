import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';

import '../../../../config/services/auth/user_manager.dart';

class UserImage extends StatelessWidget {
  const UserImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
            child: getItInstance.get<UserManager>().currentUser.image == null
                ? SvgPicture.asset(DrawableAssetStrings.defaultProfileImgIcon)
                : CachedNetworkImage(
                    imageUrl:
                        "https://img.freepik.com/premium-photo/male-artist-3d-cartoon-avatar-portrait_839035-198908.jpg",
                    fit: BoxFit.cover,
                  ),
          ),
        ),
      ),
    );
  }
}
