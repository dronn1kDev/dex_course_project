import 'package:dex_course_temp/core/domain/intl/generated/l10n.dart';
import 'package:dex_course_temp/core/presentation/app_bar.dart';
import 'package:dex_course_temp/core/presentation/app_filled_button.dart';
import 'package:dex_course_temp/core/presentation/app_text_field.dart';
import 'package:dex_course_temp/core/presentation/button/app_bar_action_button.dart';
import 'package:dex_course_temp/core/presentation/password_text_field.dart';
import 'package:dex_course_temp/core/presentation/view/view_model.dart';
import 'package:dex_course_temp/features/auth/presentation/auth_vm.dart';
import 'package:dex_course_temp/theme/color_collection.dart';
import 'package:flutter/material.dart';
import 'package:reactive_variables/reactive_variables.dart';

class AuthPage extends BaseView<AuthViewModel> {
  const AuthPage({
    super.key,
    required super.vmFactory,
  });

  @override
  Widget build(BuildContext context, AuthViewModel vm) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        actions: [
          AppBarActionButton(
            onTap: () => vm.onSettingsTap(context),
            child: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TabBar(
            controller: vm.tabController,
            tabs: [
              Tab(
                text: S.of(context).login,
              ),
              Tab(
                text: S.of(context).registration,
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: vm.tabController,
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const SizedBox(height: 100),
                      Row(
                        children: [
                          AppBarActionButton(
                            onTap: vm.googleSignIn,
                            child: const Icon(Icons.logo_dev),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      AppTextField(
                        controller: vm.phoneLoginTextCtrl,
                        labelText: S.of(context).phone,
                        prefixIcon: const Icon(
                          Icons.phone_outlined,
                        ),
                      ),
                      const SizedBox(height: 20),
                      PasswordTextField(
                        controller: vm.passwordLoginTextCtrl,
                        labelText: S.of(context).password,
                      ),
                      const SizedBox(height: 20),
                      Obs(
                        rvList: [vm.isLoginPossible],
                        builder: (context) => AppFilledButton(
                          onPressed: vm.isLoginPossible()
                              ? () => vm.goToAdvListPage(context)
                              : null,
                          child: Text(S.of(context).signIn),
                        ),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const SizedBox(height: 100),
                      AppTextField(
                        controller: vm.phoneRegisterTextCtrl,
                        labelText: S.of(context).phone,
                        prefixIcon: const Icon(
                          Icons.phone_outlined,
                        ),
                      ),
                      const SizedBox(height: 20),
                      PasswordTextField(
                        controller: vm.passwordRegisterTextCtrl,
                        labelText: S.of(context).password,
                      ),
                      const SizedBox(height: 20),
                      PasswordTextField(
                        controller: vm.repeatPasswordRegisterTextCtrl,
                        labelText: S.of(context).repeatPassword,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          vm.isUserAgreedWithPnPUsage.observer(
                            (context, value) => Checkbox(
                              value: value,
                              onChanged: vm.onCheckBoxChecked,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: RichText(
                                maxLines: 2,
                                textHeightBehavior: const TextHeightBehavior(),
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '${vm.imAgreedWith} ',
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    TextSpan(
                                      text: vm.pNPUsage,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            color: ColorCollection.primary,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      vm.isRegisterPossible.observer(
                        (context, value) => AppFilledButton(
                          onPressed: value ? () {} : null,
                          child: Text(S.of(context).signUp),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
