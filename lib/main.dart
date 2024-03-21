import 'package:dex_course_temp/core/domain/container/app_container.dart';
import 'package:dex_course_temp/core/domain/intl/generated/l10n.dart';
import 'package:dex_course_temp/features/settings/domain/service/settings_service.dart';
import 'package:dex_course_temp/routing.dart';
import 'package:dex_course_temp/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  AppContainer.init();

  runApp(MyApp(
    appContainer: AppContainer(),
  ));
}

class MyApp extends StatelessWidget {
  final AppContainer appContainer;

  const MyApp({
    super.key,
    required this.appContainer,
  });

  SettingsService get settingsService =>
      appContainer.serviceScope.settingsService;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => settingsService,
      child: BlocBuilder(
        bloc: settingsService,
        builder: (context, state) => MaterialApp.router(
          title: 'Купи и точка?',
          theme: themeData,
          routerConfig: AppRouterConfig.instance,
          localizationsDelegates: const [
            S.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          locale: settingsService.currentLocale,
          supportedLocales: settingsService.supportedLocaleList,
        ),
      ),
    );
  }
}
