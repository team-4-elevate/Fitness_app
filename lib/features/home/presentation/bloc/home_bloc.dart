// features/home/presentation/bloc/home_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/app_local_storage/app_secure_storage.dart';
import 'package:fitness_app/core/base_states/base_state.dart';
import 'package:fitness_app/features/home/data/model/daily_recomendation_exercise/exercise.dart';
import 'package:fitness_app/features/home/domain/entities/daily_recommendation_item.dart';
import 'package:fitness_app/features/home/domain/usecase/get_daily_recommendations_usecase.dart';
import 'package:injectable/injectable.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeStateType> {
  final GetDailyRecommendationsUseCase _getDailyRecommendationsUseCase;

  HomeBloc(this._getDailyRecommendationsUseCase)
    : super(const BaseInitialState()) {
    on<LoadHomeData>(_onFetchDailyRecommendations);
    on<FetchDailyRecommendations>(_onFetchDailyRecommendations);
  }

  //-------------------------------------------------------daily to recommendations
  Future<void> _onFetchDailyRecommendations(
    HomeEvent event,
    Emitter<HomeStateType> emit,
  ) async {
    emit(const BaseLoadingState());

    try {
      String targetMuscleGroupId = '67c79f3526895f87ce0aa96b';
      String difficultyLevelId = '67c797e226895f87ce0aa94b';

      if (event is FetchDailyRecommendations) {
        targetMuscleGroupId = event.targetMuscleGroupId;
        difficultyLevelId = event.difficultyLevelId;
      }

      final result = await _getDailyRecommendationsUseCase.call(
        targetMuscleGroupId: targetMuscleGroupId,
        difficultyLevelId: difficultyLevelId,
      );

      result.when(
        success: (data) {
          final recommendations = Exercise.toDailyRecommendationItems(
            data.exercises,
          );

          final homeData = HomeData(dailyRecommendations: recommendations);
          emit(SuccessState(homeData));
        },
        failure: (message) => emit(BaseErrorState(message)),
      );
    } catch (e) {
      emit(BaseErrorState(e.toString()));
    }
  }
}
