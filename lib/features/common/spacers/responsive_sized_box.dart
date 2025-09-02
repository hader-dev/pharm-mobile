import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/responsive/app_sizes/tokens.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class ResponsiveGap extends StatelessWidget {
  final SizeToken token;
  const ResponsiveGap({
    super.key,
    required this.token,
  });

  const factory ResponsiveGap.s2() = ResponsiveGap._s2;
  const factory ResponsiveGap.s4() = ResponsiveGap._s4;
  const factory ResponsiveGap.s6() = ResponsiveGap._s6;
  const factory ResponsiveGap.s8() = ResponsiveGap._s8;
  const factory ResponsiveGap.s16() = ResponsiveGap._s16;
  const factory ResponsiveGap.s12() = ResponsiveGap._s12;
  const factory ResponsiveGap.s24() = ResponsiveGap._s24;
  const factory ResponsiveGap.s32() = ResponsiveGap._s32;

  const ResponsiveGap._s2({Key? key}) : this(key: key, token: SizeToken.s2);
  const ResponsiveGap._s4({Key? key}) : this(key: key, token: SizeToken.s4);
  const ResponsiveGap._s6({Key? key}) : this(key: key, token: SizeToken.s6);
  const ResponsiveGap._s8({Key? key}) : this(key: key, token: SizeToken.s8);
  const ResponsiveGap._s12({Key? key}) : this(key: key, token: SizeToken.s12);
  const ResponsiveGap._s16({Key? key}) : this(key: key, token: SizeToken.s16);
  const ResponsiveGap._s24({Key? key}) : this(key: key, token: SizeToken.s24);
  const ResponsiveGap._s32({Key? key}) : this(key: key, token: SizeToken.s32);

  @override
  Widget build(BuildContext context) {
    final gap = context.responsiveAppSizeTheme.currentDynamic[token.name];
    return Gap(gap);
  }
}
