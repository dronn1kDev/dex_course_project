import 'package:dex_course_temp/features/locality/domain/entity/locality.dart';

class AdvListFilter {
  final List<Locality> availableLocalityList;
  final double? minPrice;
  final double? maxPrice;
  final int page;
  final int limit;

  const AdvListFilter({
    required this.availableLocalityList,
    this.minPrice,
    this.maxPrice,
    required this.page,
    required this.limit,
  }) : assert(page >= 0 && limit > 0);
}
