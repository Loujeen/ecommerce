import 'package:ecommerce/domain/entities/GetCartResponseEntity.dart';
import 'package:ecommerce/domain/failuers.dart';

abstract class CartStates {}

class CartInitialState extends CartStates {}

class GetCartLoadingState extends CartStates {}

class GetCartErrorState extends CartStates {
  Failures failures;

  GetCartErrorState({required this.failures});
}

class GetCartSuccessState extends CartStates {
  GetCartResponseEntity getCartResponseEntity;

  GetCartSuccessState({required this.getCartResponseEntity});
}

class DeleteItemInCartLoadingState extends CartStates {}

class DeleteItemInCartErrorState extends CartStates {
  Failures failures;

  DeleteItemInCartErrorState({required this.failures});
}

class DeleteItemInCartSuccessState extends CartStates {
  GetCartResponseEntity getCartResponseEntity;

  DeleteItemInCartSuccessState({required this.getCartResponseEntity});
}

class UpdateItemCountInCartLoadingState extends CartStates {}

class UpdateItemCountErrorState extends CartStates {
  Failures failures;

  UpdateItemCountErrorState({required this.failures});
}

class UpdateItemCountSuccessState extends CartStates {
  GetCartResponseEntity getCartResponseEntity;

  UpdateItemCountSuccessState({required this.getCartResponseEntity});
}