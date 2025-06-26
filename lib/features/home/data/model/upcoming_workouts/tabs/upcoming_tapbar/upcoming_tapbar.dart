import 'muscles_group.dart';

class UpcomingTapbar {
  String? message;
  List<MusclesGroup>? musclesGroup;

  UpcomingTapbar({this.message, this.musclesGroup});

  factory UpcomingTapbar.fromJson(Map<String, dynamic> json) {
    return UpcomingTapbar(
      message: json['message'] as String?,
      musclesGroup:
          (json['musclesGroup'] as List<dynamic>?)
              ?.map((e) => MusclesGroup.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'musclesGroup': musclesGroup?.map((e) => e.toJson()).toList(),
  };
}
