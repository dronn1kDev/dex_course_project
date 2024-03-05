import 'package:flutter/material.dart';

class UserFormScreen extends StatelessWidget {
  final firstNameTextCtrl = TextEditingController();

  final lastNameTextCtrl = TextEditingController();

  UserFormScreen({super.key});

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
                TextField(
                  controller: firstNameTextCtrl,
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                  ),
                ),
                TextField(
                  controller: lastNameTextCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                  ),
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
                  ElevatedButton(
                    onPressed: () => _showHelloMessage(context),
                    child: const Text('Say Hi!'),
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
}
