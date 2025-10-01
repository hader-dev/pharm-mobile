import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/language_config/resources/app_localizations.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';

class DeligateCreateClientAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const DeligateCreateClientAppbar({
    super.key,
    required this.translation,
  });

  final AppLocalizations translation;

  @override
  Widget build(BuildContext context) {
    return CustomAppBarV2.alternate(
      title: Text(
        translation.add_client,
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(color: Colors.white),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
