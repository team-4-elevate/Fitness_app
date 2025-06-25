// features/home/domain/entities/daily_recommendation_item.dart
import 'package:equatable/equatable.dart';

class DailyRecommendationItem extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final String? bodyRegion;

  const DailyRecommendationItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.bodyRegion,
  });

  @override
  List<Object?> get props => [id, name, imageUrl, bodyRegion];
}
