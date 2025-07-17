import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../config/language_config/cubit/lang_cubit.dart';
import '../../config/language_config/cubit/lang_state.dart';
import '../../config/routes/routing_manager.dart';
import '../../config/theme/light_theme.dart';

class HaderPharmApp extends StatelessWidget {
  const HaderPharmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LangCubit()..initLanguage(),
      child: BlocBuilder<LangCubit, LangState>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Hader Pharm',
            theme: LightTheme.theme,
            routerConfig: RoutingManager.router,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            locale: Locale(BlocProvider.of<LangCubit>(context).appLang),
            builder: (context, child) => Overlay(
              initialEntries: [OverlayEntry(builder: (_) => child!)],
            ),
          );
        },
      ),
    );
  }
}
