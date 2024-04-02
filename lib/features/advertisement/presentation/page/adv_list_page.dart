import 'package:dex_course_temp/core/presentation/app_bar.dart';
import 'package:dex_course_temp/core/presentation/button/app_bar_action_button.dart';
import 'package:dex_course_temp/features/advertisement/presentation/page/adv_list_vm.dart';
import 'package:dex_course_temp/features/advertisement/presentation/widget/adv_list_builder/adv_list_builder.dart';
import 'package:flutter/material.dart';

class AdvListPage extends StatefulWidget {
  final AdvListViewModel vm;
  const AdvListPage({super.key, required this.vm});

  @override
  State<AdvListPage> createState() => _AdvListPageState();
}

class _AdvListPageState extends State<AdvListPage> {
  AdvListViewModel get vm => widget.vm;

  @override
  void initState() {
    super.initState();
    vm.getAdvNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        actions: [
          AppBarActionButton(
            onTap: () => vm.getAdvNextPage(),
            child: const Icon(Icons.abc),
          )
        ],
      ),
      body: SafeArea(
        child: AdvListBuilder(
          controller: vm.listController,
        ),
      ),
    );
  }
}
