import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/text_fields/custom_text_field.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:iconsax/iconsax.dart';

class SearchWithFilterBarWidget extends StatelessWidget {
  const SearchWithFilterBarWidget({
    super.key,
    required this.onChanged,
    required this.onFilterTap,
    required this.hintText,
    required this.searchController,
  });

  final void Function(String?) onChanged;
  final VoidCallback onFilterTap;
  final String hintText;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppSizesManager.p8),
      child: CustomTextField(
        hintText: hintText,
        controller: searchController,
        state: FieldState.normal,
        isEnabled: true,
        prefixIcon: Icon(
          Iconsax.search_normal,
          color: AppColors.accent1Shade1,
        ),
        suffixIcon: InkWell(
          onTap: onFilterTap,
          child: Icon(
            Icons.clear,
            color: AppColors.accent1Shade1,
          ),
        ),
        onChanged: onChanged,
        validationFunc: (value) {},
      ),
    );
  }
}
