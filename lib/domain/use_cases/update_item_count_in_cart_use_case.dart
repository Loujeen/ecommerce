import 'package:dartz/dartz.dart';
import 'package:ecommerce/domain/repository/cart_repository.dart';
import 'package:injectable/injectable.dart';

import '../entities/GetCartResponseEntity.dart';
import '../failuers.dart';

@injectable
class UpdateItemCountInCartUseCase {
  CartRepository cartRepository;

  UpdateItemCountInCartUseCase({required this.cartRepository});

  Future<Either<Failures, GetCartResponseEntity>> invoke(
      String productId, int count) {
    return cartRepository.updateItemCountInCart(productId, count);
  }
}