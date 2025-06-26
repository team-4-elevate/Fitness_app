import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/food_details/data/datasources/remote/food_details_remote_data_source.dart';
import 'package:fitness_app/features/food_details/domain/entities/meal_entity.dart';
import 'package:fitness_app/features/food_details/domain/repositories/food_details_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: FoodDetailsRepo)
class FoodDetailsRepoImpl implements FoodDetailsRepo {
  final FoodDetailsRemoteDataSource _dataSource;

  FoodDetailsRepoImpl(this._dataSource);
  @override
  Future<ApiResult<MealEntity>> getFoodDetails(String mealID) async {
    final response = await _dataSource.getFoodDetails(mealID);
    return response.map(
      (data) => data.toEntity(),
    );
  }
}
