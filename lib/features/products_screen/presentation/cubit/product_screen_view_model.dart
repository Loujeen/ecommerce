import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/domain/entities/ProductResponseEntity.dart';
import 'package:ecommerce/domain/use_cases/add_cart_use_case.dart';
import 'package:ecommerce/domain/use_cases/get_all_products_use_case.dart';
import 'package:ecommerce/features/products_screen/presentation/cubit/product_states.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductScreenViewModel extends Cubit<ProductStates> {
  GetAllProductsUseCase getAllProductsUseCase;
  AddCartUseCase addCartUseCase;

  ProductScreenViewModel(
      {required this.getAllProductsUseCase, required this.addCartUseCase})
      : super(ProductInitialState());

  //todo: hold data - handle logic
  List<ProductEntity> productsList = [];
  int numOfCartItems = 0;

  static ProductScreenViewModel get(context) => BlocProvider.of(context);

  void getAllProducts() async {
    emit(ProductLoadingState());
    var either = await getAllProductsUseCase.invoke();
    either.fold((l) => emit(ProductErrorState(failures: l)), (response) {
      productsList = response.data!;
      emit(ProductSuccessState(productResponseEntity: response));
    });
  }

  void addToCart(String productId) async {
    emit(AddToCartLoadingState());
    var either = await addCartUseCase.invoke(productId);
    either.fold((l) {
      emit(AddToCartErrorState(failures: l));
    }, (response) {
      numOfCartItems = response.numOfCartItems!.toInt();
      print('numOfCartItems: $numOfCartItems');
      // emit(AddToCartSuccessState(addCartResponseEntity: response));
    });
  }
}