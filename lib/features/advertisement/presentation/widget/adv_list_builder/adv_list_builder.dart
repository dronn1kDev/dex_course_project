import 'package:dex_course_temp/features/advertisement/presentation/widget/adv_list_builder/adv_list_bloc.dart';
import 'package:dex_course_temp/features/advertisement/presentation/widget/adv_list_builder/adv_list_state.dart';
import 'package:dex_course_temp/features/advertisement/presentation/widget/adv_list_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdvListBuilder extends StatelessWidget {
  final AdvListController? controller;
  const AdvListBuilder({super.key, this.controller});

  Widget _buildList(BuildContext context, DataAdvListState state) =>
      ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) =>
            AdvListItemCard(advertisementListItem: state.data[index]),
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemCount: state.data.length,
      );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdvListController, AdvListState>(
      bloc: controller ?? context.read<AdvListController>(),
      builder: (context, state) => switch (state) {
        LoadingAdvListState() =>
          const Center(child: CircularProgressIndicator()),
        DataAdvListState() => _buildList(context, state),
        ErrorAdvListState() => Container(),
      },
    );
  }
}
