import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'di.config.dart';

GetIt getIt = GetIt.instance;

@injectableInit
GetIt configureDependencies()=> getIt.init();