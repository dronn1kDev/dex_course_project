import 'package:dex_course_temp/core/presentation/app_bar.dart';
import 'package:dex_course_temp/features/advertisement/presentation/page/adv_list_vm.dart';
import 'package:dex_course_temp/features/advertisement/presentation/widget/adv_list_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:reactive_variables/reactive_variables.dart';

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
    vm.getAdvPage(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context: context),
      body: SafeArea(
        child: vm.advList.observer((context, value) => ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) =>
                  AdvListItemWidget(advertisementListItem: vm.advList()[index]),
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemCount: vm.advList.length,
            )),
      ),
    );
  }
}
