import 'package:dex_course_temp/core/presentation/app_filled_button.dart';
import 'package:dex_course_temp/core/presentation/app_text_field.dart';
import 'package:flutter/material.dart';

class UserFormScreen extends StatefulWidget {
  const UserFormScreen({super.key});

  @override
  State<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final firstNameTextCtrl = TextEditingController();

  final lastNameTextCtrl = TextEditingController();

  final isPossibleToSayHi = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    firstNameTextCtrl.addListener(_controllersTextListener);
    lastNameTextCtrl.addListener(_controllersTextListener);
  }

  @override
  void dispose() {
    firstNameTextCtrl.removeListener(_controllersTextListener);
    lastNameTextCtrl.removeListener(_controllersTextListener);
    super.dispose();
  }

  void _controllersTextListener() => isPossibleToSayHi.value =
      firstNameTextCtrl.text.isNotEmpty && lastNameTextCtrl.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Form'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                AppTextField(
                  labelText: 'First Name',
                  controller: firstNameTextCtrl,
                ),
                AppTextField(
                  labelText: 'Last Name',
                  controller: lastNameTextCtrl,
                ),
              ]),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                verticalDirection: VerticalDirection.up,
                children: [
                  ValueListenableBuilder(
                    valueListenable: isPossibleToSayHi,
                    builder: (context, value, child) => AppFilledButton(
                      onPressed: _sayHiCallback(context),
                      child: const Text('Say Hi!'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showHelloMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Hello!',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              Text(
                'Hello, ${firstNameTextCtrl.text} ${lastNameTextCtrl.text}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void Function()? _sayHiCallback(BuildContext context) =>
      isPossibleToSayHi.value ? () => _showHelloMessage(context) : null;
}
