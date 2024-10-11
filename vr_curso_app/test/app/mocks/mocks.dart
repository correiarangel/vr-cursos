import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vr_curso_app/app/core/shared/services/client_http/dio_client_http.dart';


class DioMock extends Mock implements DioForNative {}

class DioClientHttpMock extends Mock implements DioClientHttp {}

class ResponseMock extends Mock implements Response {}

class DioErrorMock extends Mock implements DioException {}

class RequestOptionsMock extends Mock implements RequestOptions {}


