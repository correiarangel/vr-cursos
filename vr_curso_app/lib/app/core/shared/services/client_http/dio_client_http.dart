

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:vr_curso_app/app/core/shared/failures/exceptions.dart';
import 'package:vr_curso_app/app/core/value/const_http.dart';

import 'i_client_http.dart';

class DioClientHttp implements IClientHttp {
  final Dio _dio;

  DioClientHttp(this._dio);

  @override
  void setBaseUrl(String url) {
    _dio.options.baseUrl = url;
  }

  @override
  void setHeaders(Map<String, String> header) {
    _dio.options.headers = header;
  }

  @override
  Future<BaseResponse> get(String path) async {
    try {
      final response = await _dio.get(path);
      return _responseAdapter(response);
    } on DioException catch (err, s) {
      throw ClientHttpException(
          message: err.message ?? 'Erro client DIO GET', stackTrace: s);
    } on Exception catch (err, s) {
      throw ClientHttpException(message: err.toString(), stackTrace: s);
    }
  }

  @override
  Future<BaseResponse> post(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.post(path, data: data);
      return _responseAdapter(response);
    } on DioException catch (err, s) {
      throw ClientHttpException(
          message: err.message ?? 'Erro client DIO POST', stackTrace: s);
    } on Exception catch (err, s) {
      throw ClientHttpException(message: err.toString(), stackTrace: s);
    }
  }

  @override
  Future<BaseResponse> delete(String path) async {
    try {
      final response = await _dio.delete(path);
      return _responseAdapter(response);
    } on DioException catch (err, s) {
      log('${err.message}    ////////////////****1');
      if (err.message != null &&
          err.message!.contains(ConstHttp.dioErrorValidRequest)) {
                  log('${err.message} ////////////////**************');
        throw ClientHttpException(
            message: ConstHttp.dioMessageErrorValidRequest, stackTrace: s);
      }
      throw ClientHttpException(
          message: err.message ?? 'Erro client DIO GET', stackTrace: s);
    } on Exception catch (err, s) {
      throw ClientHttpException(message: err.toString(), stackTrace: s);
    }
  }

  @override
  Future<BaseResponse> put(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.put(path, data: data);
      return _responseAdapter(response);
    } on DioException catch (err, s) {
      throw ClientHttpException(
          message: err.message ?? 'Erro client DIO GET', stackTrace: s);
    } on Exception catch (err, s) {
      throw ClientHttpException(message: err.toString(), stackTrace: s);
    }
  }

  @override
  Future<BaseResponse> upload(
    String path, {
    List<int>? data,
  }) async {
    try {
      final response = await _dio.put(path, data: data);
      return _responseAdapter(response);
    } on DioException catch (err, s) {
      throw ClientHttpException(
          message: err.message ?? 'Erro client DIO GET', stackTrace: s);
    } on Exception catch (err, s) {
      throw ClientHttpException(message: err.toString(), stackTrace: s);
    }
  }

  BaseResponse _responseAdapter(Response response) {
    return BaseResponse(
      response.data,
      BaseRequest(
        url: response.requestOptions.path,
        method: response.requestOptions.method,
        headers: response.requestOptions.headers.cast(),
        data: response.requestOptions.data,
      ),
    );
  }
}
