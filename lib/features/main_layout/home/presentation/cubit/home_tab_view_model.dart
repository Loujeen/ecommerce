import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/domain/entities/CategoryOrBrandResponseEntity.dart';
import 'package:ecommerce/domain/use_cases/get_all_brands_use_case.dart';
import 'package:ecommerce/domain/use_cases/get_all_categories_use_case.dart';
import 'package:ecommerce/features/main_layout/home/presentation/cubit/home_tab_states.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/resources/assets_manager.dart';

@injectable
class HomeTabViewModel extends Cubit<HomeTabStates> {
  GetAllCategoriesUseCase getAllCategoriesUseCase;
  GetAllBrandsUseCase getAllBrandsUseCase;

  final List<String> adsImages = [
    ImageAssets.carouselSlider1,
    ImageAssets.carouselSlider2,
    ImageAssets.carouselSlider3,
  ];

  HomeTabViewModel(
      {required this.getAllCategoriesUseCase,
        required this.getAllBrandsUseCase})
      : super(HomeTabInitialState());

  //todo: hold data - handle logic
  List<CategoryOrBrandEntity> categoriesList = [];
  List<CategoryOrBrandEntity> brandsList = [];

  static HomeTabViewModel get(context) => BlocProvider.of(context);

  void getAllCategories() async {
    emit(HomeCategoryLoadingState());
    var either = await getAllCategoriesUseCase.invoke();
    either.fold((l) {
      emit(HomeCategoryErrorState(failures: l));
    }, (response) {
      categoriesList = response.data ?? [];
      if (brandsList.isNotEmpty) {
        emit(HomeCategorySuccessState(responseEntity: response));
      }
    });
  }

  void getAllBrands() async {
    emit(HomeBrandsLoadingState());
    var either = await getAllBrandsUseCase.invoke();
    either.fold((l) {
      emit(HomeBrandsErrorState(failures: l));
    }, (response) {
      brandsList = response.data ?? [];
      if (categoriesList.isNotEmpty) {
        emit(HomeBrandsSuccessState(responseEntity: response));
      }
    });
  }
}