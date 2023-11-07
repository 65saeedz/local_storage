import 'package:get_it/get_it.dart';
import 'package:hive_test2/utils/hive_storage.dart';

final dependencyLocator = GetIt.instance;

void setupGetItDependencies() {
  dependencyLocator.registerLazySingleton<HiveStorage>(() => HiveStorage());
}
