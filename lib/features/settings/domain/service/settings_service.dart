import 'dart:async';

import 'package:dex_course_temp/features/settings/domain/entity/app_locale.dart';
import 'package:dex_course_temp/features/settings/domain/service/settings_event.dart';
import 'package:dex_course_temp/features/settings/domain/service/settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsService extends Bloc<SettingsEvent, SettingsState> {
  SettingsService(super.initialState) {
    on<ChangeLocaleEvent>(_onChangeLocaleEvent);
  }

  final List<AppLocale> supportedLocaleList = [
    const AppLocale(
      name: 'Русский',
      languageCode: 'ru',
    ),
    const AppLocale(
      name: 'English',
      languageCode: 'en',
    )
  ];

  AppLocale get currentLocale => supportedLocaleList[state.localeIndex];

  FutureOr<void> _onChangeLocaleEvent(
    ChangeLocaleEvent event,
    Emitter<SettingsState> emit,
  ) {
    emit(SettingsState(
      localeIndex: event.newLocaleIndex,
    ));
  }
}
