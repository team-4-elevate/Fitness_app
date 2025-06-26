// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_generative_ai/google_generative_ai.dart' as _i656;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

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
import '../../features/auth/domain/usecases/forgot_password_use_case.dart'
    as _i18;
import '../../features/auth/domain/usecases/login_use_case.dart' as _i37;
import '../../features/auth/domain/usecases/register_usecase.dart' as _i941;
import '../../features/auth/domain/usecases/reset_password_use_case.dart'
    as _i825;
import '../../features/auth/domain/usecases/verify_otp_use_case.dart' as _i509;
import '../../features/auth/presentation/forget_password/bloc/forget_password_bloc.dart'
    as _i885;
import '../../features/auth/presentation/login/login_view_model.dart' as _i225;
import '../../features/auth/presentation/register/bloc/register_bloc.dart'
    as _i1034;
import '../../features/chat_bot/data/data_sources/local/chat_bot_local_data_source.dart'
    as _i1027;
import '../../features/chat_bot/data/data_sources/local/chat_bot_local_data_source_impl.dart'
    as _i638;
import '../../features/chat_bot/data/data_sources/remote/chat_bot_remote_data_source.dart'
    as _i1003;
import '../../features/chat_bot/data/data_sources/remote/chat_bot_remote_data_source_impl.dart'
    as _i734;
import '../../features/chat_bot/data/repository/chat_bot_repo_impl.dart'
    as _i195;
import '../../features/chat_bot/domain/repository/chat_bot_repo.dart' as _i361;
import '../../features/chat_bot/domain/usecase/send_message_usecase.dart'
    as _i94;
import '../../features/chat_bot/presentation/bloc/chat_bloc.dart' as _i821;
import '../../features/onboarding/data/repo/onboarding_repo_imp.dart' as _i371;
import '../../features/onboarding/domain/repository/onboarding_repo.dart'
    as _i768;
import '../../features/onboarding/domain/usecase/show_onboarding_use_case.dart'
    as _i758;
import '../../features/onboarding/presentation/bloc/onboarding_bloc.dart'
    as _i792;
import '../api/api_client.dart' as _i277;
import '../api/dio_client.dart' as _i861;
import '../app_local_storage/app_local_storage.dart' as _i849;
import '../app_local_storage/app_local_storage_imp.dart' as _i458;
import '../app_local_storage/app_secure_storage.dart' as _i304;
import '../app_local_storage/app_secure_storage_impl.dart' as _i988;
import '../gemini/gemini_module.dart' as _i810;
import '../hive/hive_config.dart' as _i515;
import '../routes/navigation_obsevation.dart' as _i1052;
import '../services/shared_prefs.dart' as _i241;
import '../utils/app_navigator_observer.dart' as _i668;
import 'register_module.dart' as _i291;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    final geminiModule = _$GeminiModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.singleton<_i668.AppNavigatorObserver>(
      () => _i668.AppNavigatorObserver(),
    );
    gh.singleton<_i515.HiveService>(() => _i515.HiveService());
    gh.singleton<_i1052.AppNavigatorObserver>(
      () => _i1052.AppNavigatorObserver(),
    );
    gh.singleton<_i241.SharedPreferencesService>(
      () => _i241.SharedPreferencesService(),
    );
    gh.factory<String>(() => geminiModule.apiKey, instanceName: 'geminiApiKey');
    gh.factory<_i849.AppLocalStorage>(
      () => _i458.AppLocalStorageImpl(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i304.AppSecureStorage>(() => _i988.AppSecureStorageImpl());
    gh.factory<String>(
      () => geminiModule.modelId,
      instanceName: 'geminiModelId',
    );
    gh.factory<_i1027.ChatBotLocalDataSource>(
      () => _i638.ChatBotLocalDataSourceImpl(gh<_i515.HiveService>()),
    );
    gh.factory<_i111.AuthLocalDataSourceContract>(
      () => _i812.AuthLocalDataSourceImpl(gh<_i304.AppSecureStorage>()),
    );
    gh.lazySingleton<_i656.GenerativeModel>(
      () => geminiModule.generativeModel(
        gh<String>(instanceName: 'geminiApiKey'),
        gh<String>(instanceName: 'geminiModelId'),
      ),
    );
    gh.factory<_i768.OnboardingRepo>(
      () => _i371.OnboardingRepoImp(gh<_i849.AppLocalStorage>()),
    );
    gh.singleton<_i277.ApiClient>(
      () => _i861.DioApiClient(gh<_i304.AppSecureStorage>()),
    );
    gh.factory<_i758.ShowOnboardingUseCase>(
      () => _i758.ShowOnboardingUseCase(gh<_i768.OnboardingRepo>()),
    );
    gh.factory<_i792.OnboardingBloc>(
      () => _i792.OnboardingBloc(gh<_i758.ShowOnboardingUseCase>()),
    );
    gh.factory<_i1003.ChatBotRemoteDataSource>(
      () => _i734.ChatBotRemoteDataSourceImpl(gh<_i656.GenerativeModel>()),
    );
    gh.factory<_i1029.AuthRemoteDataSourceContract>(
      () => _i189.AuthRemoteDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.factory<_i361.ChatBotRepo>(
      () => _i195.ChatBotRepoImpl(
        gh<_i1003.ChatBotRemoteDataSource>(),
        gh<_i1027.ChatBotLocalDataSource>(),
      ),
    );
    gh.factory<_i170.AuthRepo>(
      () => _i984.AuthRepoImpl(
        gh<_i1029.AuthRemoteDataSourceContract>(),
        gh<_i304.AppSecureStorage>(),
      ),
    );
    gh.factory<_i941.RegisterUseCase>(
      () => _i941.RegisterUseCase(gh<_i170.AuthRepo>()),
    );
    gh.factory<_i94.SendMessageUsecase>(
      () => _i94.SendMessageUsecase(gh<_i361.ChatBotRepo>()),
    );
    gh.factory<_i1034.RegisterBloc>(
      () => _i1034.RegisterBloc(gh<_i941.RegisterUseCase>()),
    );
    gh.factory<_i37.LoginUseCase>(
      () => _i37.LoginUseCase(gh<_i170.AuthRepo>()),
    );
    gh.factory<_i825.ResetPasswordUseCase>(
      () => _i825.ResetPasswordUseCase(gh<_i170.AuthRepo>()),
    );
    gh.factory<_i18.ForgotPasswordUseCase>(
      () => _i18.ForgotPasswordUseCase(gh<_i170.AuthRepo>()),
    );
    gh.factory<_i509.VerifyOtpUseCase>(
      () => _i509.VerifyOtpUseCase(gh<_i170.AuthRepo>()),
    );
    gh.singleton<_i885.ForgetPasswordBloc>(
      () => _i885.ForgetPasswordBloc(
        gh<_i18.ForgotPasswordUseCase>(),
        gh<_i509.VerifyOtpUseCase>(),
        gh<_i825.ResetPasswordUseCase>(),
      ),
    );
    gh.factory<_i821.ChatBloc>(
      () => _i821.ChatBloc(
        gh<_i94.SendMessageUsecase>(),
        gh<_i361.ChatBotRepo>(),
      ),
    );
    gh.factory<_i225.LoginViewModel>(
      () => _i225.LoginViewModel(gh<_i37.LoginUseCase>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i291.RegisterModule {}

class _$GeminiModule extends _i810.GeminiModule {}
