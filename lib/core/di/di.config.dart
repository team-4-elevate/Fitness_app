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

import '../api/api_client.dart' as _i277;
import '../api/dio_client.dart' as _i861;
import '../app_local_storage/app_secure_storage.dart' as _i304;
import '../app_local_storage/app_secure_storage_impl.dart' as _i988;
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
    gh.singleton<_i565.NavigationService>(() => _i565.NavigationService());
    gh.singleton<_i668.AppNavigatorObserver>(
      () => _i668.AppNavigatorObserver(),
    );
    gh.singleton<_i241.SharedPreferencesService>(
      () => _i241.SharedPreferencesService(),
    );
    gh.factory<_i304.AppSecureStorage>(() => _i988.AppSecureStorageImpl());
    gh.singleton<_i277.ApiClient>(
      () => _i861.DioApiClient(
        gh<_i304.AppSecureStorage>(),
        gh<_i565.NavigationService>(),
      ),
    );
    return this;
  }
}
