import 'package:dex_course_temp/features/advertisement/domain/entity/advertisement_list_item.dart';
import 'package:dex_course_temp/theme/color_collection.dart';
import 'package:flutter/material.dart';

class AdvListItemWidget extends StatelessWidget {
  final AdvertisementListItem advertisementListItem;

  const AdvListItemWidget({super.key, required this.advertisementListItem});

  BoxDecoration _cardDecoration(BuildContext context) => BoxDecoration(
        color: ColorCollection.surface,
        border: Border.all(
          color: ColorCollection.outlineVariant,
        ),
        borderRadius: BorderRadius.circular(12),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _cardDecoration(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // _previewBuilder(context),
          _contentBuilder(context),
        ],
      ),
    );
  }

  Widget _titleBuilder(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            advertisementListItem.title,
          ),
          if (advertisementListItem.isFavorite)
            Icon(
              Icons.favorite_outlined,
              size: 24,
              color: Theme.of(context).colorScheme.primary,
            )
          else
            Icon(
              Icons.favorite_border_outlined,
              size: 24,
              color: Theme.of(context).colorScheme.outline,
            )
        ],
      );

  Widget _contentBuilder(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ).copyWith(top: 8, bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _titleBuilder(context),
            const SizedBox(height: 16),
            Text(
              advertisementListItem.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );
}
