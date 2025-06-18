// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/datasource/local_data_source/auth_local_data_source_contract.dart'
    as _i111;
import '../../features/auth/data/datasource/local_data_source/auth_local_data_source_impl.dart'
    as _i812;
import '../../features/auth/data/datasource/remote_data_source/auth_remote_data_source_contract.dart'
    as _i1029;
import '../../features/auth/data/datasource/remote_data_source/auth_remote_data_source_impl.dart'
    as _i189;
import '../../features/auth/data/repo/auth_repo_impl.dart' as _i984;
import '../../features/auth/domain/repo/auth_repo.dart' as _i170;
import '../../features/auth/domain/usecases/register_usecase.dart' as _i941;
import '../../features/auth/presentation/register/bloc/register_bloc.dart'
    as _i1034;
import '../api/api_client.dart' as _i277;
import '../api/dio_client.dart' as _i861;
import '../app_local_storage/app_secure_storage.dart' as _i304;
import '../app_local_storage/app_secure_storage_impl.dart' as _i988;
import '../routes/navigation_obsevation.dart' as _i1052;
import '../services/shared_prefs.dart' as _i241;
import '../utils/app_navigator_observer.dart' as _i668;
import '../utils/navigation_services.dart' as _i565;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i1052.AppNavigatorObserver>(
      () => _i1052.AppNavigatorObserver(),
    );
    gh.singleton<_i241.SharedPreferencesService>(
      () => _i241.SharedPreferencesService(),
    );
    gh.singleton<_i668.AppNavigatorObserver>(
      () => _i668.AppNavigatorObserver(),
    );
    gh.singleton<_i565.NavigationService>(() => _i565.NavigationService());
    gh.factory<_i304.AppSecureStorage>(() => _i988.AppSecureStorageImpl());
    gh.factory<_i111.AuthLocalDataSourceContract>(
      () => _i812.AuthLocalDataSourceImpl(gh<_i304.AppSecureStorage>()),
    );
    gh.singleton<_i277.ApiClient>(
      () => _i861.DioApiClient(gh<_i304.AppSecureStorage>()),
    );
    gh.factory<_i1029.AuthRemoteDataSourceContract>(
      () => _i189.AuthRemoteDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.factory<_i170.AuthRepo>(
      () => _i984.AuthRepoImpl(gh<_i1029.AuthRemoteDataSourceContract>()),
    );
    gh.factory<_i941.RegisterUseCase>(
      () => _i941.RegisterUseCase(gh<_i170.AuthRepo>()),
    );
    gh.factory<_i1034.RegisterBloc>(
      () => _i1034.RegisterBloc(gh<_i941.RegisterUseCase>()),
    );
    return this;
  }
}
