import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:vr_curso_app/app/core/shared/services/client_http/i_client_http.dart';
import 'package:vr_curso_app/app/core/shared/services/overlay/i_overlay_service.dart';
import 'package:vr_curso_app/app/core/shared/services/shared_preferences/i_local_storage.dart';
import 'package:vr_curso_app/app/core/value/const_http.dart';

import 'shared/services/client_http/dio_client_http.dart';
import 'shared/services/overlay/asuka_overlay_service.dart';
import 'shared/services/shared_preferences/shared_preferences_service.dart';

class CoreModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.addInstance<Dio>(_dioBind());
    i.add<IClientHttp>(DioClientHttp.new);

    i.add<ILocalStorage>(SharedPreferencesService.new);
    i.add<IOverlayService>(AsukaOverlayService.new);

  }

  // Método para criar a instância de Dio
  Dio _dioBind() => Dio(
        BaseOptions(
          baseUrl: ConstHttp.base,
          receiveTimeout: const Duration(seconds: 15),
          connectTimeout: const Duration(seconds: 15),
          headers: {
            "Accept": "*/*",
            "Content-Type":"application/json",
          },
          
        ),
      );
}
