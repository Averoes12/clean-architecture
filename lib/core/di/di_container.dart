import 'package:clean_architecture/core/di/di_container.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> initDi() async {
  getIt.init();
  return getIt.allReady();
}
