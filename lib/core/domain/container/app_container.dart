import 'dart:developer';

import 'package:dex_course_temp/features/advertisement/data/repository/adv_mocked_repository.dart';
import 'package:dex_course_temp/features/advertisement/domain/repository/advertisement_repository.dart';
import 'package:dex_course_temp/features/auth/data/source/auth_mocked_data_source.dart';
import 'package:dex_course_temp/features/auth/domain/repository/auth_repository.dart';
import 'package:dex_course_temp/features/settings/domain/service/settings_service.dart';
import 'package:dex_course_temp/features/settings/domain/service/settings_state.dart';
import 'package:get_it/get_it.dart';

class AppContainer {
  late final ServiceScope serviceScope;
  late final RepositoryScope repositoryScope;

  AppContainer.init() {
    ready = initDependencies();
    GetIt.instance.registerSingleton(this);
  }

  factory AppContainer() => GetIt.instance<AppContainer>();

  late final Future<bool> ready;

  Future<bool> initDependencies() async {
    try {
      final authRepo = AuthRepository(AuthMockedDataSource());
      final AdvertisementRepository advertisementRepository =
          AdvMockedRepository();

      repositoryScope = RepositoryScope(
        authRepository: authRepo,
        advertisementRepository: advertisementRepository,
      );

      final settingsService =
          SettingsService(const SettingsState(localeIndex: 0));

      serviceScope = ServiceScope(settingsService: settingsService);
      return true;
    } catch (e, st) {
      log('App Container has not been initialized', error: e, stackTrace: st);
      return false;
    }
  }
}

class ServiceScope {
  final SettingsService settingsService;

  ServiceScope({
    required this.settingsService,
  });
}

class RepositoryScope {
  final AuthRepository authRepository;
  final AdvertisementRepository advertisementRepository;

  RepositoryScope({
    required this.authRepository,
    required this.advertisementRepository,
  });
}
