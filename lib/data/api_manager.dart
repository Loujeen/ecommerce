import 'package:dio/dio.dart';
import 'package:ecommerce/core/resources/constants_manager.dart';
import 'package:injectable/injectable.dart';

@singleton
class ApiManager {
  late Dio dio;

  ApiManager() {
    dio = Dio();
  }

  Future<Response> getData(String endPoint,
      {Map<String, dynamic>? queryParameters, Map<String, dynamic>? headers}) {
    return dio.get(AppConstants.baseUrl + endPoint,
        queryParameters: queryParameters,
        options: Options(validateStatus: ((status) => true), headers: headers));
  }

  Future<Response> postData(String endPoint,
      {Map<String, dynamic>? headers, Map<String, dynamic>? body}) {
    return dio.post(AppConstants.baseUrl + endPoint,
        data: body,
        options: Options(headers: headers, validateStatus: ((status) => true)));
  }

  Future<Response> deleteData(String endPoint,
      {Map<String, dynamic>? headers, Map<String, dynamic>? body}) {
    return dio.delete(AppConstants.baseUrl + endPoint,
        data: body,
        options: Options(headers: headers, validateStatus: ((status) => true)));
  }

  Future<Response> updateData(String endPoint,
      {Map<String, dynamic>? headers, Map<String, dynamic>? body}) {
    return dio.put(AppConstants.baseUrl + endPoint,
        data: body,
        options: Options(headers: headers, validateStatus: ((status) => true)));
  }
}