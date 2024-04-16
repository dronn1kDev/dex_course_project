import 'dart:developer';

import 'package:dex_course_temp/core/domain/intl/generated/l10n.dart';
import 'package:dex_course_temp/core/domain/use_case_result/use_case_result.dart';
import 'package:dex_course_temp/core/presentation/app_text_field/app_text_editing_controller.dart';
import 'package:dex_course_temp/core/presentation/password_text_editing_controller.dart';
import 'package:dex_course_temp/core/presentation/view/view_model.dart';
import 'package:dex_course_temp/features/auth/domain/entity/auth_credentials.dart';
import 'package:dex_course_temp/features/auth/domain/repository/auth_repository.dart';
import 'package:dex_course_temp/features/auth/domain/strategy/auth_strategy.dart';
import 'package:dex_course_temp/features/settings/domain/service/settings_service.dart';
import 'package:dex_course_temp/features/settings/presentation/settings_modal_bs.dart';
import 'package:dex_course_temp/routing.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:reactive_variables/reactive_variables.dart';

class AuthViewModel extends ViewModel with SingleTickerProviderViewStateMixin {
  final AuthRepository _authRepository;
  final SettingsService _settingsService;

  AuthViewModel({
    required AuthRepository authRepository,
    required SettingsService settingService,
  })  : _authRepository = authRepository,
        _settingsService = settingService;

  late TabController tabController = TabController(length: 2, vsync: this);

  final phoneLoginTextCtrl = AppTextEditingController();
  final passwordLoginTextCtrl = PassTextEditingController();
  final phoneRegisterTextCtrl = AppTextEditingController();
  final passwordRegisterTextCtrl = PassTextEditingController();
  final repeatPasswordRegisterTextCtrl = PassTextEditingController();

  final isUserAgreedWithPnPUsage = false.rv;

  final isLoginPossible = false.rv;

  final isRegisterPossible = false.rv;

  String get imAgreedWith => S
      .of(context)
      .imAgreedWithPrivacyAndPolicyUsage
      .split(' ')
      .getRange(0, 3)
      .join(' ');

  String get pNPUsage {
    final wordList = S.of(context).imAgreedWithPrivacyAndPolicyUsage.split(' ');
    return wordList.getRange(3, wordList.length).join(' ');
  }

  @override
  void initState(BuildContext context) {
    super.initState(context);
    initListeners();
  }

  @override
  void dispose() {
    disposeListeners();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _loginPossibilityListener() {
    if (phoneLoginTextCtrl.text.isEmpty || passwordLoginTextCtrl.text.isEmpty) {
      isLoginPossible(false);
      return;
    }

    isLoginPossible(true);
  }

  void _registerPossibilityChanger() {
    if (!isUserAgreedWithPnPUsage()) {
      isRegisterPossible(false);
      return;
    }

    if (phoneRegisterTextCtrl.text.isEmpty ||
        passwordRegisterTextCtrl.text.isEmpty ||
        repeatPasswordRegisterTextCtrl.text.isEmpty) {
      isRegisterPossible(false);
      return;
    }

    // if (passwordRegisterTextCtrl.text != repeatPasswordRegisterTextCtrl.text) {
    //   isRegisterPossible(false);
    //   return;
    // }

    isRegisterPossible(true);
  }

  void _passwordVisibilityListener() {
    repeatPasswordRegisterTextCtrl
        .isTextHidden(passwordRegisterTextCtrl.isTextHidden());
  }

  void _repeatPasswordVisibilityListener() {
    passwordRegisterTextCtrl
        .isTextHidden(repeatPasswordRegisterTextCtrl.isTextHidden());
  }

  void initListeners() {
    isUserAgreedWithPnPUsage.addListener(_registerPossibilityChanger);
    phoneLoginTextCtrl.addListener(_loginPossibilityListener);
    passwordLoginTextCtrl.addListener(_loginPossibilityListener);
    passwordRegisterTextCtrl.isTextHidden
        .addListener(_passwordVisibilityListener);
    repeatPasswordRegisterTextCtrl.isTextHidden
        .addListener(_repeatPasswordVisibilityListener);
    phoneRegisterTextCtrl.addListener(_registerPossibilityChanger);
    passwordRegisterTextCtrl.addListener(_registerPossibilityChanger);
    repeatPasswordRegisterTextCtrl.addListener(_registerPossibilityChanger);
  }

  void disposeListeners() {
    isUserAgreedWithPnPUsage.removeListener(_registerPossibilityChanger);
    phoneLoginTextCtrl.removeListener(_loginPossibilityListener);
    passwordLoginTextCtrl.removeListener(_loginPossibilityListener);
    passwordRegisterTextCtrl.isTextHidden
        .removeListener(_passwordVisibilityListener);
    repeatPasswordRegisterTextCtrl.isTextHidden
        .removeListener(_repeatPasswordVisibilityListener);
    phoneRegisterTextCtrl.removeListener(_registerPossibilityChanger);
    passwordRegisterTextCtrl.removeListener(_registerPossibilityChanger);
    repeatPasswordRegisterTextCtrl.removeListener(_registerPossibilityChanger);
  }

  void onCheckBoxChecked(bool? value) =>
      isUserAgreedWithPnPUsage(value ?? false);

  Future<void> _signIn(SignInStrategy signInStrategy) async {
    final result = await signInStrategy();

    switch (result) {
      case GoodUseCaseResult<AuthCredentials>(:final data):
        log(data.jvtToken);
        break;
      case BadUseCaseResult<AuthCredentials>(:final errorList):
        for (final error in errorList) {
          log(error.code);
        }
        break;
    }
  }

  Future<void> defaultSignIn() async {
    final strategy = DefaultSignInStrategy(
      authRepository: _authRepository,
      phone: phoneLoginTextCtrl.text,
      password: passwordLoginTextCtrl.text,
    );

    return await _signIn(strategy);
  }

  void onSettingsTap(BuildContext context) {
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) =>
          SettingsModalBottomSheet(settingsService: _settingsService),
    );
  }

  Future<void> googleSignIn() async {
    // context.push(AppRouteList.auth);
    // return;
    final strategy = GoogleServiceSignInStrategy();

    return await _signIn(strategy);
  }

  void goToAdvListPage(BuildContext context) {
    context.go(AppRouteList.advListPage);
  }
}
