// features/home/data/model/daily_recomendation_exercise/exercise.dart
import 'package:fitness_app/features/home/domain/entities/daily_recommendation_item.dart';

class Exercise {
  String? id;
  String? exercise;
  String? shortYoutubeDemonstration;
  String? inDepthYoutubeExplanation;
  String? difficultyLevel;
  String? targetMuscleGroup;
  String? primeMoverMuscle;
  dynamic secondaryMuscle;
  dynamic tertiaryMuscle;
  String? primaryEquipment;
  int? primaryItems;
  dynamic secondaryEquipment;
  int? secondaryItems;
  String? posture;
  String? singleOrDoubleArm;
  String? continuousOrAlternatingArms;
  String? grip;
  String? loadPositionEnding;
  String? continuousOrAlternatingLegs;
  String? footElevation;
  String? combinationExercises;
  String? movementPattern1;
  dynamic movementPattern2;
  dynamic movementPattern3;
  String? planeOfMotion1;
  dynamic planeOfMotion2;
  dynamic planeOfMotion3;
  String? bodyRegion;
  String? forceType;
  String? mechanics;
  String? laterality;
  String? primaryExerciseClassification;
  String? shortYoutubeDemonstrationLink;
  String? inDepthYoutubeExplanationLink;

  Exercise({
    this.id,
    this.exercise,
    this.shortYoutubeDemonstration,
    this.inDepthYoutubeExplanation,
    this.difficultyLevel,
    this.targetMuscleGroup,
    this.primeMoverMuscle,
    this.secondaryMuscle,
    this.tertiaryMuscle,
    this.primaryEquipment,
    this.primaryItems,
    this.secondaryEquipment,
    this.secondaryItems,
    this.posture,
    this.singleOrDoubleArm,
    this.continuousOrAlternatingArms,
    this.grip,
    this.loadPositionEnding,
    this.continuousOrAlternatingLegs,
    this.footElevation,
    this.combinationExercises,
    this.movementPattern1,
    this.movementPattern2,
    this.movementPattern3,
    this.planeOfMotion1,
    this.planeOfMotion2,
    this.planeOfMotion3,
    this.bodyRegion,
    this.forceType,
    this.mechanics,
    this.laterality,
    this.primaryExerciseClassification,
    this.shortYoutubeDemonstrationLink,
    this.inDepthYoutubeExplanationLink,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        id: json['_id'] as String?,
        exercise: json['exercise'] as String?,
        shortYoutubeDemonstration:
            json['short_youtube_demonstration'] as String?,
        inDepthYoutubeExplanation:
            json['in_depth_youtube_explanation'] as String?,
        difficultyLevel: json['difficulty_level'] as String?,
        targetMuscleGroup: json['target_muscle_group'] as String?,
        primeMoverMuscle: json['prime_mover_muscle'] as String?,
        secondaryMuscle: json['secondary_muscle'] as dynamic,
        tertiaryMuscle: json['tertiary_muscle'] as dynamic,
        primaryEquipment: json['primary_equipment'] as String?,
        primaryItems: json['_primary_items'] as int?,
        secondaryEquipment: json['secondary_equipment'] as dynamic,
        secondaryItems: json['_secondary_items'] as int?,
        posture: json['posture'] as String?,
        singleOrDoubleArm: json['single_or_double_arm'] as String?,
        continuousOrAlternatingArms:
            json['continuous_or_alternating_arms'] as String?,
        grip: json['grip'] as String?,
        loadPositionEnding: json['load_position_ending'] as String?,
        continuousOrAlternatingLegs:
            json['continuous_or_alternating_legs'] as String?,
        footElevation: json['foot_elevation'] as String?,
        combinationExercises: json['combination_exercises'] as String?,
        movementPattern1: json['movement_pattern_1'] as String?,
        movementPattern2: json['movement_pattern_2'] as dynamic,
        movementPattern3: json['movement_pattern_3'] as dynamic,
        planeOfMotion1: json['plane_of_motion_1'] as String?,
        planeOfMotion2: json['plane_of_motion_2'] as dynamic,
        planeOfMotion3: json['plane_of_motion_3'] as dynamic,
        bodyRegion: json['body_region'] as String?,
        forceType: json['force_type'] as String?,
        mechanics: json['mechanics'] as String?,
        laterality: json['laterality'] as String?,
        primaryExerciseClassification:
            json['primary_exercise_classification'] as String?,
        shortYoutubeDemonstrationLink:
            json['short_youtube_demonstration_link'] as String?,
        inDepthYoutubeExplanationLink:
            json['in_depth_youtube_explanation_link'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'exercise': exercise,
        'short_youtube_demonstration': shortYoutubeDemonstration,
        'in_depth_youtube_explanation': inDepthYoutubeExplanation,
        'difficulty_level': difficultyLevel,
        'target_muscle_group': targetMuscleGroup,
        'prime_mover_muscle': primeMoverMuscle,
        'secondary_muscle': secondaryMuscle,
        'tertiary_muscle': tertiaryMuscle,
        'primary_equipment': primaryEquipment,
        '_primary_items': primaryItems,
        'secondary_equipment': secondaryEquipment,
        '_secondary_items': secondaryItems,
        'posture': posture,
        'single_or_double_arm': singleOrDoubleArm,
        'continuous_or_alternating_arms': continuousOrAlternatingArms,
        'grip': grip,
        'load_position_ending': loadPositionEnding,
        'continuous_or_alternating_legs': continuousOrAlternatingLegs,
        'foot_elevation': footElevation,
        'combination_exercises': combinationExercises,
        'movement_pattern_1': movementPattern1,
        'movement_pattern_2': movementPattern2,
        'movement_pattern_3': movementPattern3,
        'plane_of_motion_1': planeOfMotion1,
        'plane_of_motion_2': planeOfMotion2,
        'plane_of_motion_3': planeOfMotion3,
        'body_region': bodyRegion,
        'force_type': forceType,
        'mechanics': mechanics,
        'laterality': laterality,
        'primary_exercise_classification': primaryExerciseClassification,
        'short_youtube_demonstration_link': shortYoutubeDemonstrationLink,
        'in_depth_youtube_explanation_link': inDepthYoutubeExplanationLink,
      };

  //convert YouTube video to image
  String? _extractYouTubeId(String? url) {
    if (url == null || url.isEmpty) return null;

    if (url.contains('youtu.be')) {
      final uri = Uri.tryParse(url);
      if (uri != null) {
        final pathSegments = uri.pathSegments;
        if (pathSegments.isNotEmpty) {
          return pathSegments.last;
        }
      }
    }
    RegExp regExp = RegExp(
      r'(?:youtube\.com\/(?:[^\/]+\/.+\/|(?:v|e(?:mbed)?)\/|.*[?&]v=)|youtu\.be\/)([^"&?\/ ]{11})',
    );

    Match? match = regExp.firstMatch(url);
    return match?.group(1);
  }

  String _getYouTubeThumbnailUrl(String? youtubeUrl) {
    final videoId = _extractYouTubeId(youtubeUrl);
    if (videoId != null) {
      return 'https://img.youtube.com/vi/$videoId/hqdefault.jpg';
    }
    return 'assets/images/fit1.png';
  }

  //------------------------------------------toDailyRecommendationItem
  DailyRecommendationItem toDailyRecommendationItem() {
    final thumbnailUrl = _getYouTubeThumbnailUrl(shortYoutubeDemonstrationLink);

    return DailyRecommendationItem(
      id: id ?? '',
      name: exercise ?? 'Unknown Exercise',
      imageUrl: thumbnailUrl,
      bodyRegion: bodyRegion,
    );
  }

  static List<DailyRecommendationItem> toDailyRecommendationItems(
    List<Exercise> exercises,
  ) {
    return exercises
        .map((exercise) => exercise.toDailyRecommendationItem())
        .toList();
  }
}
