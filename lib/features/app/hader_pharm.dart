import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hader_pharm_mobile/config/language_config/cubit/lang_cubit.dart';
import 'package:hader_pharm_mobile/config/language_config/cubit/lang_state.dart';
import 'package:hader_pharm_mobile/config/responsive/typography/widgets/responsive_theme_provider.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';

import '../../config/language_config/resources/app_localizations.dart';

class HaderPharmApp extends StatelessWidget {
  const HaderPharmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LangCubit()..initLanguage(),
      child: BlocBuilder<LangCubit, LangState>(
        builder: (context, state) {
          return ResponsiveThemeProvider(
            child: Builder(
              builder: (themeContext) {
                return MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  title: 'Hader Pharm',
                  theme: Theme.of(themeContext),
                  routerConfig: RoutingManager.router,
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: AppLocalizations.supportedLocales,
                  locale: Locale(
                    BlocProvider.of<LangCubit>(context).appLang,
                  ),
                  builder: (context, child) => Overlay(
                    initialEntries: [OverlayEntry(builder: (_) => child!)],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
