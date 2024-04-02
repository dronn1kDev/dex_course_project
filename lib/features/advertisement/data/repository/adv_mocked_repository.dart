import 'package:dex_course_temp/core/domain/app_error/app_error.dart';
import 'package:dex_course_temp/core/domain/use_case_result/use_case_result.dart';
import 'package:dex_course_temp/features/advertisement/domain/entity/adv_list_filter.dart';
import 'package:dex_course_temp/features/advertisement/domain/entity/advertisement_list_item.dart';
import 'package:dex_course_temp/features/advertisement/domain/repository/advertisement_repository.dart';
import 'package:dex_course_temp/features/locality/domain/entity/locality.dart';

class AdvMockedRepository implements AdvertisementRepository {
  final _mockedAdvList = List<AdvertisementListItem>.generate(
    30,
    (index) {
      final localityCount = LocalityList.values.length;
      final locality = LocalityList.values[index % localityCount];

      return AdvertisementListItem(
        id: '$index',
        title: 'title $index',
        description: 'description $index',
        creationDate: DateTime(2024, 1, index + 1),
        cost: index * 123,
        locality: locality,
        isFavorite: index.isEven,
      );
    },
  );

  @override
  Future<UseCaseResult<List<AdvertisementListItem>>> getList(
      AdvListFilter filter) async {
    await Future.delayed(const Duration(seconds: 2));
    try {
      return UseCaseResult.good(_mockedAdvList
          .where((element) {
            if (filter.availableLocalityList.isNotEmpty) {
              final localityResult =
                  filter.availableLocalityList.contains(element.locality);
              if (!localityResult) return false;
            }
            return true;
          })
          .skip(filter.page * filter.limit)
          .take(filter.limit)
          .toList());
    } catch (e) {
      return UseCaseResult.bad([SpecificError('getList error')]);
    }
  }

  @override
  Future<UseCaseResult<AdvertisementListItem>> add(
      AdvCreationEntity advCreationEntity) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<UseCaseResult<void>> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }
}
