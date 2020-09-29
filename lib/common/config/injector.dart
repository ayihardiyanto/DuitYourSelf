
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:duit_yourself/common/models/menu.dart';

import 'injector.config.dart' as injection_config;

final getIt = GetIt.instance;

Future<void> setupInjections() async {
  getIt.registerLazySingleton(() => Menu());
  configure();
}

@injectableInit
void configure() => injection_config.$initGetIt(getIt);
