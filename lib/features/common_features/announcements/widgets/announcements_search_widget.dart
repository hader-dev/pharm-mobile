import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/text_fields/custom_text_field.dart';
import 'package:hader_pharm_mobile/features/common_features/announcements/cubit/all_announcements_cubit.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class AnnouncementsSearchWidget extends StatelessWidget {
  const AnnouncementsSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p16),
      child: CustomTextField(
        hintText: context.translation!.search_announcements,
        controller:
            BlocProvider.of<AllAnnouncementsCubit>(context).searchController,
        state: FieldState.normal,
        isEnabled: true,
        prefixIcon: Icon(
          Iconsax.search_normal,
          color: AppColors.accent1Shade1,
        ),
        suffixIcon: InkWell(
          onTap: () {
            BlocProvider.of<AllAnnouncementsCubit>(context)
                .searchController
                .clear();
            BlocProvider.of<AllAnnouncementsCubit>(context)
                .searchAnnouncements(null);
          },
          child: Icon(
            Icons.clear,
            color: AppColors.accent1Shade1,
          ),
        ),
        onChanged: (searchValue) {
          BlocProvider.of<AllAnnouncementsCubit>(context)
              .searchAnnouncements(searchValue);
        },
        validationFunc: (value) {},
      ),
    );
  }
}
