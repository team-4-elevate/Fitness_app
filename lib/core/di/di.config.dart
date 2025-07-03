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
import '../../features/chat_bot/domain/usecase/delete_conversation_usecase.dart'
    as _i349;
import '../../features/chat_bot/domain/usecase/get_all_conversation_usecase.dart'
    as _i343;
import '../../features/chat_bot/domain/usecase/new_conversation_usecase.dart'
    as _i991;
import '../../features/chat_bot/domain/usecase/save_conversation_usecase.dart'
    as _i416;
import '../../features/chat_bot/domain/usecase/select_conversation_usecase.dart'
    as _i399;
import '../../features/chat_bot/domain/usecase/send_message_usecase.dart'
    as _i94;
import '../../features/chat_bot/presentation/bloc/chat_bloc.dart' as _i821;
import '../../features/edit_profile/data/datasource/remote_data_source/edit_profile_remote_data_source_impl.dart'
    as _i506;
import '../../features/edit_profile/data/datasource/remote_data_source/edit_profile_remote_data_source_interface.dart'
    as _i624;
import '../../features/edit_profile/data/repo/editprofile_repo_impl.dart'
    as _i245;
import '../../features/edit_profile/domain/repo/editprofile_repo.dart' as _i260;
import '../../features/edit_profile/domain/usecases/edit_profile_data_usecase.dart'
    as _i29;
import '../../features/edit_profile/domain/usecases/get_profile_data_usecase.dart'
    as _i742;
import '../../features/edit_profile/domain/usecases/upload_profile_image_usecase.dart'
    as _i774;
import '../../features/edit_profile/presentation/bloc/edit_profile_bloc.dart'
    as _i84;
import '../../features/exercise/data/data_sources/remote/exercise_remote_ds_impl.dart'
    as _i649;
import '../../features/exercise/data/data_sources/remote/exercise_remote_ds_interface.dart'
    as _i139;
import '../../features/exercise/data/repo_impl/exercise_repo_impl.dart'
    as _i824;
import '../../features/exercise/domain/repo_interface/exercise_repo_interface.dart'
    as _i822;
import '../../features/exercise/domain/use_cases/get_exercise_use_case.dart'
    as _i182;
import '../../features/exercise/domain/use_cases/get_levels_use_case.dart'
    as _i233;
import '../../features/exercise/presentation/bloc/exercise_bloc.dart' as _i154;
import '../../features/food_details/data/datasources/remote/food_details_api_remote_data_source.dart'
    as _i479;
import '../../features/food_details/data/datasources/remote/food_details_remote_data_source.dart'
    as _i362;
import '../../features/food_details/data/repositories/food_details_repo_impl.dart'
    as _i958;
import '../../features/food_details/domain/repositories/food_details_repo.dart'
    as _i877;
import '../../features/food_details/domain/usecases/get_food_details_use_case.dart'
    as _i668;
import '../../features/food_details/presentation/cubit/food_details_cubit.dart'
    as _i535;
import '../../features/food_recommendation/data/datasources/food_recommend_remote_data_source.dart'
    as _i483;
import '../../features/food_recommendation/data/datasources/food_recommend_remote_data_source_impl.dart'
    as _i740;
import '../../features/food_recommendation/data/repositories/food_recommend_repo_impl.dart'
    as _i190;
import '../../features/food_recommendation/domain/repositories/food_recommend_repo.dart'
    as _i988;
import '../../features/food_recommendation/domain/usecases/get_meals_categories_use_case.dart'
    as _i520;
import '../../features/food_recommendation/domain/usecases/get_meals_on_category_use_case.dart'
    as _i420;
import '../../features/food_recommendation/presentation/cubit/food_recommendation_viewmodel.dart'
    as _i68;
import '../../features/home/data/datasource/remote_data_source/home_remote_data_source_contract.dart'
    as _i352;
import '../../features/home/data/datasource/remote_data_source/home_remote_data_source_impl.dart'
    as _i395;
import '../../features/home/data/repo/home_repository_impl.dart' as _i779;
import '../../features/home/domain/repo/home_repository_contract.dart' as _i207;
import '../../features/home/domain/usecases/get_daily_recommendations_usecase.dart'
    as _i1029;
import '../../features/home/domain/usecases/get_food_recommendations.dart'
    as _i588;
import '../../features/home/domain/usecases/get_muscle_groups_use_case.dart'
    as _i208;
import '../../features/home/domain/usecases/get_workouts_by_muscle_group_id.dart'
    as _i598;
import '../../features/home/presentation/bloc/home_bloc.dart' as _i202;
import '../../features/onboarding/data/repo/onboarding_repo_imp.dart' as _i371;
import '../../features/onboarding/domain/repository/onboarding_repo.dart'
    as _i768;
import '../../features/onboarding/domain/usecase/show_onboarding_use_case.dart'
    as _i758;
import '../../features/onboarding/presentation/bloc/onboarding_bloc.dart'
    as _i792;
import '../../features/profile/data/datasources/profile_remote_ds.dart'
    as _i320;
import '../../features/profile/data/datasources/profile_remote_ds_impl.dart'
    as _i177;
import '../../features/profile/data/repositories/profile_repo_impl.dart'
    as _i988;
import '../../features/profile/domain/repositories/profile_repo.dart' as _i790;
import '../../features/profile/domain/usecases/logout_use_case.dart' as _i154;
import '../../features/profile/presentation/bloc/profile_bloc.dart' as _i469;
import '../../features/update_password/data/data_sources/update_password_remote_ds_impl.dart'
    as _i64;
import '../../features/update_password/data/data_sources/update_password_remote_ds_interface.dart'
    as _i91;
import '../../features/update_password/data/repo_impl/update_password_repo_impl.dart'
    as _i541;
import '../../features/update_password/domain/repo_interface/update_password_repo_interface.dart'
    as _i775;
import '../../features/update_password/domain/use_case/update_password_use_case.dart'
    as _i942;
import '../../features/update_password/presentation/bloc/update_password_bloc.dart'
    as _i304;
import '../api/api_client.dart' as _i277;
import '../api/dio_client.dart' as _i861;
import '../app_data/app_bloc.dart' as _i399;
import '../app_local_storage/app_local_storage.dart' as _i849;
import '../app_local_storage/app_local_storage_imp.dart' as _i458;
import '../app_local_storage/app_secure_storage.dart' as _i304;
import '../app_local_storage/app_secure_storage_impl.dart' as _i988;
import '../gemini/gemini_module.dart' as _i810;
import '../hive/hive_config.dart' as _i515;
import '../routes/navigation_obsevation.dart' as _i1052;
import '../services/localization_manager.dart' as _i2;
import '../services/shared_prefs.dart' as _i241;
import '../utils/app_navigator_observer.dart' as _i668;
import 'register_module.dart' as _i291;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    final geminiModule = _$GeminiModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.factory<_i991.NewConversationUsecase>(
        () => _i991.NewConversationUsecase());
    gh.singleton<_i515.HiveService>(() => _i515.HiveService());
    gh.singleton<_i1052.AppNavigatorObserver>(
        () => _i1052.AppNavigatorObserver());
    gh.singleton<_i2.LocalizationManager>(() => _i2.LocalizationManager());
    gh.singleton<_i241.SharedPreferencesService>(
        () => _i241.SharedPreferencesService());
    gh.singleton<_i668.AppNavigatorObserver>(
        () => _i668.AppNavigatorObserver());
    gh.factory<String>(
      () => geminiModule.apiKey,
      instanceName: 'geminiApiKey',
    );
    gh.factory<_i849.AppLocalStorage>(
        () => _i458.AppLocalStorageImpl(gh<_i460.SharedPreferences>()));
    gh.factory<_i304.AppSecureStorage>(() => _i988.AppSecureStorageImpl());
    gh.factory<String>(
      () => geminiModule.modelId,
      instanceName: 'geminiModelId',
    );
    gh.factory<_i1027.ChatBotLocalDataSource>(
        () => _i638.ChatBotLocalDataSourceImpl(gh<_i515.HiveService>()));
    gh.factory<_i111.AuthLocalDataSourceContract>(
        () => _i812.AuthLocalDataSourceImpl(gh<_i304.AppSecureStorage>()));
    gh.lazySingleton<_i399.AppBloc>(() => _i399.AppBloc(
          gh<_i111.AuthLocalDataSourceContract>(),
          gh<_i304.AppSecureStorage>(),
        ));
    gh.lazySingleton<_i656.GenerativeModel>(() => geminiModule.generativeModel(
          gh<String>(instanceName: 'geminiApiKey'),
          gh<String>(instanceName: 'geminiModelId'),
        ));
    gh.factory<_i768.OnboardingRepo>(
        () => _i371.OnboardingRepoImp(gh<_i849.AppLocalStorage>()));
    gh.singleton<_i277.ApiClient>(
        () => _i861.DioApiClient(gh<_i304.AppSecureStorage>()));
    gh.factory<_i483.FoodRecommendRemoteDataSource>(
        () => _i740.FoodRecommendRemoteDataSourceImpl(gh<_i277.ApiClient>()));
    gh.factory<_i91.UpdatePasswordRemoteDsInterface>(
        () => _i64.UpdatePasswordRemoteDsImpl(gh<_i277.ApiClient>()));
    gh.factory<_i362.FoodDetailsRemoteDataSource>(
        () => _i479.FoodDetailsApiRemoteDataSource(gh<_i277.ApiClient>()));
    gh.factory<_i624.EditProfileRemoteDataSourceInterface>(
        () => _i506.EditProfileRemoteDataSourceImpl(gh<_i277.ApiClient>()));
    gh.factory<_i775.UpdatePasswordRepoInterface>(
        () => _i541.UpdatePasswordRepoImpl(
              gh<_i91.UpdatePasswordRemoteDsInterface>(),
              gh<_i111.AuthLocalDataSourceContract>(),
            ));
    gh.factory<_i758.ShowOnboardingUseCase>(
        () => _i758.ShowOnboardingUseCase(gh<_i768.OnboardingRepo>()));
    gh.factory<_i792.OnboardingBloc>(
        () => _i792.OnboardingBloc(gh<_i758.ShowOnboardingUseCase>()));
    gh.factory<_i1003.ChatBotRemoteDataSource>(
        () => _i734.ChatBotRemoteDataSourceImpl(gh<_i656.GenerativeModel>()));
    gh.factory<_i139.ExerciseRemoteDsInterface>(
        () => _i649.ExerciseRemoteDsImpl(gh<_i277.ApiClient>()));
    gh.factory<_i942.UpdatePasswordUseCase>(() =>
        _i942.UpdatePasswordUseCase(gh<_i775.UpdatePasswordRepoInterface>()));
    gh.factory<_i352.HomeRemoteDataSource>(
        () => _i395.HomeRemoteDataSourceImpl(gh<_i277.ApiClient>()));
    gh.factory<_i1029.AuthRemoteDataSourceContract>(
        () => _i189.AuthRemoteDataSourceImpl(gh<_i277.ApiClient>()));
    gh.factory<_i304.UpdatePasswordBloc>(
        () => _i304.UpdatePasswordBloc(gh<_i942.UpdatePasswordUseCase>()));
    gh.factory<_i320.ProfileRemoteDs>(
        () => _i177.ProfileRemoteDsImpl(gh<_i277.ApiClient>()));
    gh.factory<_i260.EditProfileRepo>(() => _i245.EditProfileRepoImpl(
        remoteDataSource: gh<_i624.EditProfileRemoteDataSourceInterface>()));
    gh.factory<_i988.FoodRecommendRepo>(() =>
        _i190.FoodRecommendRepoImpl(gh<_i483.FoodRecommendRemoteDataSource>()));
    gh.factory<_i520.GetMealsCategoriesUseCase>(
        () => _i520.GetMealsCategoriesUseCase(gh<_i988.FoodRecommendRepo>()));
    gh.factory<_i420.GetMealsOnCategoryUseCase>(
        () => _i420.GetMealsOnCategoryUseCase(gh<_i988.FoodRecommendRepo>()));
    gh.factory<_i207.HomeRepository>(
        () => _i779.HomeRepositoryImpl(gh<_i352.HomeRemoteDataSource>()));
    gh.factory<_i361.ChatBotRepo>(() => _i195.ChatBotRepoImpl(
          gh<_i1003.ChatBotRemoteDataSource>(),
          gh<_i1027.ChatBotLocalDataSource>(),
        ));
    gh.factory<_i877.FoodDetailsRepo>(() =>
        _i958.FoodDetailsRepoImpl(gh<_i362.FoodDetailsRemoteDataSource>()));
    gh.factory<_i29.EditProfileDataUseCase>(
        () => _i29.EditProfileDataUseCase(gh<_i260.EditProfileRepo>()));
    gh.factory<_i742.GetProfileDataUseCase>(
        () => _i742.GetProfileDataUseCase(gh<_i260.EditProfileRepo>()));
    gh.lazySingleton<_i774.UploadProfileImageUseCase>(
        () => _i774.UploadProfileImageUseCase(gh<_i260.EditProfileRepo>()));
    gh.factory<_i349.DeleteConversationUsecase>(
        () => _i349.DeleteConversationUsecase(gh<_i361.ChatBotRepo>()));
    gh.factory<_i84.EditProfileBloc>(() => _i84.EditProfileBloc(
          getProfileDataUseCase: gh<_i742.GetProfileDataUseCase>(),
          editProfileDataUseCase: gh<_i29.EditProfileDataUseCase>(),
          uploadProfileImageUseCase: gh<_i774.UploadProfileImageUseCase>(),
          securestorage: gh<_i304.AppSecureStorage>(),
        ));
    gh.factory<_i208.GetMuscleGroupsUseCase>(
        () => _i208.GetMuscleGroupsUseCase(gh<_i207.HomeRepository>()));
    gh.factory<_i598.GetWorkoutsByMuscleGroupId>(
        () => _i598.GetWorkoutsByMuscleGroupId(gh<_i207.HomeRepository>()));
    gh.factory<_i588.GetFoodRecommendations>(
        () => _i588.GetFoodRecommendations(gh<_i207.HomeRepository>()));
    gh.factory<_i822.ExerciseRepoInterface>(
        () => _i824.ExerciseRepoImpl(gh<_i139.ExerciseRemoteDsInterface>()));
    gh.factory<_i68.FoodRecommendationViewModel>(
        () => _i68.FoodRecommendationViewModel(
              gh<_i520.GetMealsCategoriesUseCase>(),
              gh<_i420.GetMealsOnCategoryUseCase>(),
            ));
    gh.factory<_i170.AuthRepo>(() => _i984.AuthRepoImpl(
          gh<_i1029.AuthRemoteDataSourceContract>(),
          gh<_i304.AppSecureStorage>(),
        ));
    gh.factory<_i790.ProfileRepo>(() => _i988.ProfileRepoImpl(
          gh<_i320.ProfileRemoteDs>(),
          gh<_i304.AppSecureStorage>(),
        ));
    gh.factory<_i1029.GetDailyRecommendationsUseCase>(() =>
        _i1029.GetDailyRecommendationsUseCase(gh<_i207.HomeRepository>()));
    gh.factory<_i941.RegisterUseCase>(
        () => _i941.RegisterUseCase(gh<_i170.AuthRepo>()));
    gh.factory<_i343.GetAllConversationUsecase>(
        () => _i343.GetAllConversationUsecase(gh<_i361.ChatBotRepo>()));
    gh.factory<_i416.SaveConversationUsecase>(
        () => _i416.SaveConversationUsecase(gh<_i361.ChatBotRepo>()));
    gh.factory<_i399.SelectConversationUsecase>(
        () => _i399.SelectConversationUsecase(gh<_i361.ChatBotRepo>()));
    gh.factory<_i94.SendMessageUsecase>(
        () => _i94.SendMessageUsecase(gh<_i361.ChatBotRepo>()));
    gh.factory<_i202.HomeBloc>(() => _i202.HomeBloc(
          gh<_i1029.GetDailyRecommendationsUseCase>(),
          gh<_i588.GetFoodRecommendations>(),
          gh<_i208.GetMuscleGroupsUseCase>(),
          gh<_i598.GetWorkoutsByMuscleGroupId>(),
        ));
    gh.factory<_i668.GetFoodDetailsUseCase>(
        () => _i668.GetFoodDetailsUseCase(gh<_i877.FoodDetailsRepo>()));
    gh.factory<_i535.FoodDetailsCubit>(
        () => _i535.FoodDetailsCubit(gh<_i668.GetFoodDetailsUseCase>()));
    gh.factory<_i1034.RegisterBloc>(
        () => _i1034.RegisterBloc(gh<_i941.RegisterUseCase>()));
    gh.factory<_i182.GetExercisesUseCase>(
        () => _i182.GetExercisesUseCase(gh<_i822.ExerciseRepoInterface>()));
    gh.factory<_i233.GetLevelsUseCase>(
        () => _i233.GetLevelsUseCase(gh<_i822.ExerciseRepoInterface>()));
    gh.factory<_i18.ForgotPasswordUseCase>(
        () => _i18.ForgotPasswordUseCase(gh<_i170.AuthRepo>()));
    gh.factory<_i37.LoginUseCase>(
        () => _i37.LoginUseCase(gh<_i170.AuthRepo>()));
    gh.factory<_i825.ResetPasswordUseCase>(
        () => _i825.ResetPasswordUseCase(gh<_i170.AuthRepo>()));
    gh.factory<_i509.VerifyOtpUseCase>(
        () => _i509.VerifyOtpUseCase(gh<_i170.AuthRepo>()));
    gh.singleton<_i885.ForgetPasswordBloc>(() => _i885.ForgetPasswordBloc(
          gh<_i18.ForgotPasswordUseCase>(),
          gh<_i509.VerifyOtpUseCase>(),
          gh<_i825.ResetPasswordUseCase>(),
        ));
    gh.factory<_i154.ExercisePageBloc>(() => _i154.ExercisePageBloc(
          getLevelsUseCase: gh<_i233.GetLevelsUseCase>(),
          getExercisesUseCase: gh<_i182.GetExercisesUseCase>(),
        ));
    gh.factory<_i154.LogoutUseCase>(
        () => _i154.LogoutUseCase(gh<_i790.ProfileRepo>()));
    gh.factory<_i821.ChatBloc>(() => _i821.ChatBloc(
          gh<_i94.SendMessageUsecase>(),
          gh<_i991.NewConversationUsecase>(),
          gh<_i399.SelectConversationUsecase>(),
          gh<_i343.GetAllConversationUsecase>(),
          gh<_i416.SaveConversationUsecase>(),
          gh<_i349.DeleteConversationUsecase>(),
        ));
    gh.factory<_i469.ProfileBloc>(() => _i469.ProfileBloc(
          gh<_i154.LogoutUseCase>(),
          gh<_i2.LocalizationManager>(),
        ));
    gh.factory<_i225.LoginViewModel>(
        () => _i225.LoginViewModel(gh<_i37.LoginUseCase>()));
    return this;
  }
}

class _$RegisterModule extends _i291.RegisterModule {}

class _$GeminiModule extends _i810.GeminiModule {}
