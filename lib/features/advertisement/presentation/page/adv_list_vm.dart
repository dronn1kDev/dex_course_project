import 'package:dex_course_temp/core/domain/use_case_result/use_case_result.dart';
import 'package:dex_course_temp/features/advertisement/domain/entity/adv_list_filter.dart';
import 'package:dex_course_temp/features/advertisement/domain/entity/advertisement_list_item.dart';
import 'package:dex_course_temp/features/advertisement/domain/repository/advertisement_repository.dart';
import 'package:reactive_variables/reactive_variables.dart';

class AdvListViewModel {
  final AdvertisementRepository _advertisementRepository;

  final advList = <AdvertisementListItem>[].rv;

  AdvListViewModel({
    required AdvertisementRepository advertisementRepository,
  }) : _advertisementRepository = advertisementRepository;

  Future<void> getAdvPage(final int page) async {
    final result = await _advertisementRepository.getList(
      AdvListFilter(
        availableLocalityList: [],
        page: page,
        limit: 10,
      ),
    );

    switch (result) {
      case GoodUseCaseResult<List<AdvertisementListItem>>(:final data):
        advList.addAll(data);
        break;
      case BadUseCaseResult<List<AdvertisementListItem>>():
        // TODO отобразить ошибку
        advList.clear();
        break;
    }
  }
}
