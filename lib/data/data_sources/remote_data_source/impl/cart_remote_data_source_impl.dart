import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce/data/api_manager.dart';
import 'package:ecommerce/data/data_sources/remote_data_source/cart_remote_data_source.dart';
import 'package:ecommerce/domain/failuers.dart';
import 'package:injectable/injectable.dart';


import '../../../../core/widget/shared_prefrence_utils.dart';
import '../../../end_points.dart';
import '../../../model/GetCartResponseDto.dart';

@Injectable(as: CartRemoteDataSource)
class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  ApiManager apiManager;

  CartRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<Either<Failures, GetCartResponseDto>> getCart() async {
    // TODO: implement getCart
    try {
      var checkResult = await Connectivity().checkConnectivity();
      if (checkResult == ConnectivityResult.wifi ||
          checkResult == ConnectivityResult.mobile) {
        var token = SharedPreferenceUtils.getData(key: 'token');
        var response = await apiManager
            .getData(EndPoints.addToCart, headers: {'token': token.toString()});
        var getCartResponse = GetCartResponseDto.fromJson(response.data);
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return Right(getCartResponse);
        } else if (response.statusCode == 401) {
          return Left(ServerError(errorMessage: getCartResponse.message!));
        } else {
          return Left(ServerError(errorMessage: getCartResponse.message!));
        }
      } else {
        // no internet
        return Left(NetworkError(
            errorMessage: 'No Internet connection , Please check'
                'internet.'));
      }
    } catch (e) {
      return Left(Failures(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failures, GetCartResponseDto>> deleteItemInCart(
      String productId) async {
    // TODO: implement deleteItemInCart
    try {
      var checkResult = await Connectivity().checkConnectivity();
      if (checkResult == ConnectivityResult.wifi ||
          checkResult == ConnectivityResult.mobile) {
        var token = SharedPreferenceUtils.getData(key: 'token');
        var response = await apiManager.deleteData(
            '${EndPoints.addToCart}/$productId',
            headers: {'token': token.toString()});
        var deleteItemInCartResponse =
        GetCartResponseDto.fromJson(response.data);
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return Right(deleteItemInCartResponse);
        } else if (response.statusCode == 401) {
          return Left(
              ServerError(errorMessage: deleteItemInCartResponse.message!));
        } else {
          return Left(
              ServerError(errorMessage: deleteItemInCartResponse.message!));
        }
      } else {
        // no internet
        return Left(NetworkError(
            errorMessage: 'No Internet connection , Please check'
                'internet.'));
      }
    } catch (e) {
      return Left(Failures(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failures, GetCartResponseDto>> updateItemCountInCart(
      String productId, int count) async {
    // TODO: implement updateItemCountInCart
    try {
      var checkResult = await Connectivity().checkConnectivity();
      if (checkResult == ConnectivityResult.wifi ||
          checkResult == ConnectivityResult.mobile) {
        var token = SharedPreferenceUtils.getData(key: 'token');
        var response = await apiManager.updateData(
            '${EndPoints.addToCart}/$productId',
            body: {'count': '$count'},
            headers: {'token': token.toString()});
        var updateItemCountInCartResponse =
        GetCartResponseDto.fromJson(response.data);
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return Right(updateItemCountInCartResponse);
        } else if (response.statusCode == 401) {
          return Left(ServerError(
              errorMessage: updateItemCountInCartResponse.message!));
        } else {
          return Left(ServerError(
              errorMessage: updateItemCountInCartResponse.message!));
        }
      } else {
        // no internet
        return Left(NetworkError(
            errorMessage: 'No Internet connection , Please check'
                'internet.'));
      }
    } catch (e) {
      return Left(Failures(errorMessage: e.toString()));
    }
  }
}