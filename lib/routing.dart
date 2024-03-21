import 'package:dex_course_temp/core/domain/container/app_container.dart';
import 'package:dex_course_temp/features/auth/presentation/auth_page.dart';
import 'package:dex_course_temp/features/auth/presentation/auth_vm.dart';
import 'package:dex_course_temp/features/init/presentation/init_page.dart';
import 'package:dex_course_temp/features/init/presentation/init_vm.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouteList {
  static const init = '/init';

  static const auth = '/auth';
}

abstract class AppRouterConfig {
  static final instance = GoRouter(
    initialLocation: AppRouteList.init,
    routes: [
      GoRoute(
        path: AppRouteList.init,
        builder: (context, state) => const InitPage(
          vm: InitViewModel(),
        ),
      ),
      GoRoute(
        path: AppRouteList.auth,
        builder: (context, state) {
          return AuthPage(
            vm: AuthViewModel(
              authRepository: AppContainer().repositoryScope.authRepository,
              settingService: AppContainer().serviceScope.settingsService,
            ),
          );
        },
      ),
    ],
  );
}
