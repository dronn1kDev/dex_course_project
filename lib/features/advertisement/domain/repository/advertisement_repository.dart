import 'package:dex_course_temp/core/domain/use_case_result/use_case_result.dart';
import 'package:dex_course_temp/features/advertisement/domain/entity/adv_list_filter.dart';
import 'package:dex_course_temp/features/advertisement/domain/entity/advertisement_list_item.dart';

abstract class AdvertisementRepository {
  Future<UseCaseResult<List<AdvertisementListItem>>> getList(
      AdvListFilter filter);

  Future<UseCaseResult<AdvertisementListItem>> add(
      AdvCreationEntity advCreationEntity);

  Future<UseCaseResult<void>> delete(final String id);
}
