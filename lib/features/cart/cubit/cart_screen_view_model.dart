import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/domain/entities/GetCartResponseEntity.dart';
import 'package:ecommerce/domain/use_cases/delete_item_in_cart_use_case.dart';
import 'package:ecommerce/domain/use_cases/get_cart_use_case.dart';
import 'package:ecommerce/domain/use_cases/update_item_count_in_cart_use_case.dart';
import 'package:ecommerce/features/cart/cubit/cart_states.dart';
import 'package:injectable/injectable.dart';

@injectable
class CartScreenViewModel extends Cubit<CartStates> {
  GetCartUseCase getCartUseCase;
  DeleteItemInCartUseCase deleteItemInCartUseCase;

  UpdateItemCountInCartUseCase updateItemCountInCartUseCase;

  CartScreenViewModel(
      {required this.getCartUseCase,
        required this.deleteItemInCartUseCase,
        required this.updateItemCountInCartUseCase})
      : super(CartInitialState());

  //todo: hold data - handle logic
  List<GetProductCartEntity> productsList = [];

  static CartScreenViewModel get(context) => BlocProvider.of(context);

  void getCart() async {
    emit(GetCartLoadingState());
    var either = await getCartUseCase.invoke();
    either.fold((l) => emit(GetCartErrorState(failures: l)), (response) {
      productsList = response.data!.products!;
      emit(GetCartSuccessState(getCartResponseEntity: response));
    });
  }

  void deleteItemInCart(String productId) async {
    emit(DeleteItemInCartLoadingState());
    var either = await deleteItemInCartUseCase.invoke(productId);
    either.fold((l) => emit(DeleteItemInCartErrorState(failures: l)),
            (response) {
          productsList = response.data!.products!;
          emit(GetCartSuccessState(getCartResponseEntity: response));
        });
  }

  void updateItemCountInCart(String productId, int count) async {
    emit(UpdateItemCountInCartLoadingState());
    var either = await updateItemCountInCartUseCase.invoke(productId, count);
    either.fold((l) => emit(UpdateItemCountErrorState(failures: l)),
            (response) {
          productsList = response.data!.products!;
          emit(GetCartSuccessState(getCartResponseEntity: response));
        });
  }
}