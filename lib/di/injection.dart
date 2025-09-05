import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection_container.dart' as ic;

final GetIt getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  await ic.init();
  // Injectable se encargará de registrar automáticamente las dependencias
  // No necesitamos llamar getIt.init() aquí
}
