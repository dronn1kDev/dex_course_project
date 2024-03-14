import 'package:dex_course_temp/features/auth/presentation/widget/register_tab_view.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: 2, vsync: this);

  final emailTextCtrl = TextEditingController();
  final passwordTextCtrl = TextEditingController();

  final isChecked = ValueNotifier(false);

  final isLoginPossible = ValueNotifier(false);

  final _loginFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    isChecked.addListener(_loginListener);
    emailTextCtrl.addListener(_loginListener);
    passwordTextCtrl.addListener(_loginListener);
  }

  @override
  void dispose() {
    isChecked.removeListener(_loginListener);
    emailTextCtrl.removeListener(_loginListener);
    passwordTextCtrl.removeListener(_loginListener);
    super.dispose();
  }

  void _loginListener() {
    if (!isChecked.value) {
      isLoginPossible.value = false;
      return;
    }

    if (emailTextCtrl.text.isEmpty || passwordTextCtrl.text.isEmpty) {
      isLoginPossible.value = false;
      return;
    }

    isLoginPossible.value = true;
  }

  Widget get _tabBarBuilder => TabBar(
        controller: _tabController,
        tabs: const [
          Tab(
            text: 'Login',
          ),
          Tab(
            text: 'Register',
          ),
        ],
      );

  Widget get _tabViewBuilder => TabBarView(
        controller: _tabController,
        children: [
          _loginTabBuilder,
          _registerTabBuilder,
        ],
      );

  Widget get _loginTabBuilder => SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _loginFormKey,
          child: Column(
            children: [
              const SizedBox(height: 100),
              TextFormField(
                controller: emailTextCtrl,
                validator: (value) {
                  if (value?.isNotEmpty == true) return null;
                  return 'The value can not be empty';
                },
                decoration: const InputDecoration(
                  labelText: 'email',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordTextCtrl,
                decoration: const InputDecoration(
                  labelText: 'password',
                ),
                validator: (value) {
                  if (value?.isNotEmpty == true) return null;
                  return 'The value can not be empty';
                },
              ),
              const SizedBox(height: 20),
              ValueListenableBuilder(
                valueListenable: isChecked,
                builder: (context, value, child) => Checkbox(
                  value: isChecked.value,
                  onChanged: (value) => isChecked.value = value ?? false,
                ),
              ),
              ValueListenableBuilder(
                valueListenable: isLoginPossible,
                builder: (context, value, child) => FilledButton(
                  onPressed: isLoginPossible.value ? () {} : null,
                  child: const Text('login'),
                ),
              ),
            ],
          ),
        ),
      );

  Widget get _registerTabBuilder => const RegisterTabView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auth Page'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _tabBarBuilder,
          Expanded(child: _tabViewBuilder),
        ],
      ),
    );
  }
}
