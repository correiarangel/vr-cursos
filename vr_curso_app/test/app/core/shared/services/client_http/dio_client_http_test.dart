import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vr_curso_app/app/core/shared/failures/exceptions.dart';
import 'package:vr_curso_app/app/core/shared/services/client_http/dio_client_http.dart';
import 'package:vr_curso_app/app/core/shared/services/client_http/i_client_http.dart';

import '../../../../mocks/mocks.dart';

void main() {
  late Dio dio;
  late DioClientHttp dioClient;

  setUp(() {
    dio = DioMock();
    dioClient = DioClientHttp(dio);
  });

  group('DioClientHttp happy way', () {
    test(
        'Must be return url, when the function'
        ' DioClintHTTP is called whit set base url', () {
      //Arrange
      when(() => dio.options).thenReturn(BaseOptions());
      //act
      dioClient.setBaseUrl('https://pub.dev/packages/mocktail');
      //expecd
      expect(dio.options.baseUrl, 'https://pub.dev/packages/mocktail');
    });

    test(
        'Must be return Map, when the function'
        ' setHeaders is called', () {
      Map<String, dynamic> mapHeaders = {
        'content-type': 'application/json; charset=utf-8',
        'teste': 'test'
      };
      //Arrrege
      when(() => dio.options).thenReturn(BaseOptions());
      //act
      dioClient.setHeaders(
          {'content-type': 'application/json; charset=utf-8', 'teste': 'test'});
      //expecd
      expect(dio.options.headers, mapHeaders);
    });

    test('Must be return BaseResponse, when the function Get is called',
        () async {
      //Arrange
      final response = ResponseMock();
      when(() => response.data).thenReturn({});
      when(() => response.requestOptions).thenReturn(RequestOptions(path: ''));
      when(() => dio.get(any())).thenAnswer((_) async => response);
      //act
      final result = await dioClient.get('url');
      //expect
      expect(result, isA<BaseResponse>());
    });

    test('Must be return BaseResponse, when the function Post is called',
        () async {
      //Arrege
      final response = ResponseMock();
      when(() => response.requestOptions).thenReturn(RequestOptions(path: ''));
      when(() => dio.post(any(), data: {}))
          .thenAnswer((_) => Future.value(response));
      //act
      final dioClient = DioClientHttp(dio);
      final result = await dioClient.post('url', data: {});
      //expect
      expect(result, isA<BaseResponse>());
    });

    test('Must be return BaseResponse, when the function Delete is called',
        () async {
      //Arrege
      final response = ResponseMock();
      when(() => response.requestOptions).thenReturn(RequestOptions(path: ''));
      when(() => dio.delete(any())).thenAnswer(
        (_) => Future.value(response),
      );
      //act
      final result = await dioClient.delete('url');
      //expect
      expect(result, isA<BaseResponse>());
    });

    test('Must be return BaseResponse, when the function Put is called',
        () async {
      //Arrege
      final response = ResponseMock();
      when(() => response.requestOptions).thenReturn(RequestOptions(path: ''));
      when(() => dio.put(any(), data: {})).thenAnswer(
        (_) => Future.value(response),
      );
      //act
      final result = await dioClient.put('url', data: {});
      //expect
      expect(result, isA<BaseResponse>());
    });
  });



  group('DioClientHttp sad way', () {
  test('Should throw DioError when GET request fails', () async {
    // Arrange
    when(() => dio.get(any())).thenThrow(DioException(
      requestOptions: RequestOptions(path: 'url'),
      response: Response(
        requestOptions: RequestOptions(path: 'url'),
        statusCode: 500,
        statusMessage: 'Internal Server Error',
      ),
    ));

    // Act & Assert
   // final result = await dioClient.get('url');
    expect(()=>dioClient.get('url'), throwsA(isA<ClientHttpException>()));
  });
    });

    test('Should throw DioError when POST request fails', () async {
      // Arrange
      when(() => dio.post(any(), data: any(named: 'data'))).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: 'url'),
          response: Response(
            requestOptions: RequestOptions(path: 'url'),
            statusCode: 400,
            statusMessage: 'Bad Request',
          ),
        ),
      );

      // Act & Assert
      expect(() => dioClient.post('url', data: {}), throwsA(isA<ClientHttpException>()));
    });

    test('Should throw DioError when DELETE request fails', () async {
      // Arrange
      when(() => dio.delete(any())).thenThrow(DioException(
        requestOptions: RequestOptions(path: 'url'),
        response: Response(
          requestOptions: RequestOptions(path: 'url'),
          statusCode: 404,
          statusMessage: 'Not Found',
        ),
      ));

      // Act & Assert
      expect(() => dioClient.delete('url'), throwsA(isA<ClientHttpException>()));
    });

    test('Should throw DioError when PUT request fails', () async {
      // Arrange
      when(() => dio.put(any(), data: any(named: 'data'))).thenThrow(DioException(
        requestOptions: RequestOptions(path: 'url'),
        response: Response(
          requestOptions: RequestOptions(path: 'url'),
          statusCode: 403,
          statusMessage: 'Forbidden',
        ),
      ));

      // Act & Assert
      expect(() => dioClient.put('url', data: {}), throwsA(isA<ClientHttpException>()));
    });

    test('Should throw DioError when UPLOAD request fails', () async {
      // Arrange
      when(() => dio.put(any(), data: any(named: 'data'))).thenThrow(DioException(
        requestOptions: RequestOptions(path: 'url'),
        response: Response(
          requestOptions: RequestOptions(path: 'url'),
          statusCode: 413,
          statusMessage: 'Payload Too Large',
        ),
      ));

      // Act & Assert
      expect(() => dioClient.upload('url', data: []), throwsA(isA<ClientHttpException>()));
    });
  
}
