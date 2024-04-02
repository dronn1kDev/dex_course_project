import 'package:dex_course_temp/features/advertisement/domain/entity/adv_list_filter.dart';
import 'package:dex_course_temp/features/advertisement/domain/repository/advertisement_repository.dart';
import 'package:dex_course_temp/features/advertisement/presentation/widget/adv_list_builder/adv_list_bloc.dart';
import 'package:dex_course_temp/features/advertisement/presentation/widget/adv_list_builder/adv_list_state.dart';

class AdvListViewModel {
  final AdvertisementRepository _advertisementRepository;

  final listController = AdvListController(LoadingAdvListState());

  final _pageLimit = 10;
  int _currentPage = 0;

  AdvListViewModel({
    required AdvertisementRepository advertisementRepository,
  }) : _advertisementRepository = advertisementRepository;

  Future<void> getAdvNextPage() async {
    listController.append(() => _advertisementRepository.getList(
          AdvListFilter(
            availableLocalityList: [],
            page: _currentPage,
            limit: _pageLimit,
          ),
        ));
    _currentPage++;
  }

  Future<void> refreshCurrentItems() async {
    final specificLimit = (_currentPage + 1) * _pageLimit;
    listController.replace(
      () => _advertisementRepository.getList(
        AdvListFilter(
          availableLocalityList: [],
          page: 0,
          limit: specificLimit,
        ),
      ),
    );
  }
}
