import 'package:flutter_modular/flutter_modular.dart';
import '../../core/core_module.dart';
import 'domain/usecases/send_message_usecase.dart';

import 'domain/repositories/i_message_repository.dart';
import 'external/message_datasource.dart';
import 'infra/datasources/i_message_datasource.dart';
import 'infra/repositories/message_reposytory.dart';

class MessageModule extends Module {
   @override
  final List<Module> imports = [CoreModule()]; 
  @override
  void exportedBinds(Injector i) {
    i.add<IMessageDatasource>(MessageDatasource.new);
    i.add<IMessageRepository>(MessageRepository.new);
    i.add<ISendMessageUsecase>(SendMessageUsecase.new);
  }
}
