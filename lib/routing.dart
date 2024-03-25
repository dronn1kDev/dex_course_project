import 'package:dex_course_temp/core/domain/container/app_container.dart';
import 'package:dex_course_temp/features/advertisement/presentation/page/adv_list_page.dart';
import 'package:dex_course_temp/features/advertisement/presentation/page/adv_list_vm.dart';
import 'package:dex_course_temp/features/auth/presentation/auth_page.dart';
import 'package:dex_course_temp/features/auth/presentation/auth_vm.dart';
import 'package:dex_course_temp/features/init/presentation/init_page.dart';
import 'package:dex_course_temp/features/init/presentation/init_vm.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouteList {
  static const init = '/init';

  // static const _authPath = 'auth';
  static const auth = '/auth';

  static const advListPage = '/adv-list-page';
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
        routes: const [
          // GoRoute(
          //   path: 'forgot-password',
          //   routes: [
          //     GoRoute(
          //       path: 'code-validation',
          //     ),
          //     GoRoute(
          //       path: 'new-password',
          //     ),
          //   ],
          // ),
        ],
      ),
      GoRoute(
        path: AppRouteList.advListPage,
        builder: (context, state) => AdvListPage(
          vm: AdvListViewModel(
            advertisementRepository:
                AppContainer().repositoryScope.advertisementRepository,
          ),
        ),
      ),
    ],
  );
}
