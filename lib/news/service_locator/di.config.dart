// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:news_app/news/modal/model/data_source/main_layer_data_source.dart'
    as _i153;
import 'package:news_app/news/repository/main_layer_repository.dart' as _i851;
import 'package:news_app/news/view_modal/main_layer_cubit/main_layer_cubit.dart'
    as _i511;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i851.MainLayerRepository>(
      () => _i851.MainLayerRepository(
        dataSource: gh<_i153.MainLayerDataSource>(),
      ),
    );
    gh.factory<_i511.MainLayerCubit>(
      () => _i511.MainLayerCubit(
        mainLayerRepository: gh<_i851.MainLayerRepository>(),
      ),
    );
    return this;
  }
}
