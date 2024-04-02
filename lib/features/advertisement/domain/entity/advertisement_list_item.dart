import 'package:dex_course_temp/features/locality/domain/entity/locality.dart';

class AdvertisementListItem {
  final String id;
  final String title;
  final String description;
  final DateTime creationDate;
  final double cost;
  final Locality locality;
  final bool isFavorite;

  const AdvertisementListItem({
    required this.id,
    required this.title,
    required this.description,
    required this.creationDate,
    required this.cost,
    required this.locality,
    required this.isFavorite,
  });
}

class AdvCreationEntity {
  final String title;
  final String description;
  final double cost;
  final Locality locality;
  AdvCreationEntity({
    required this.title,
    required this.description,
    required this.cost,
    required this.locality,
  });
}
