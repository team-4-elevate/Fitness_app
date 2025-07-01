// features/edit_profile/domain/entities/physical_info_arguments.dart
import 'package:fitness_app/core/Constant/app_keys.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/core/routes/app_routes.dart';
import 'package:fitness_app/features/edit_profile/presentation/bloc/edit_profile_bloc.dart';
import 'package:fitness_app/features/edit_profile/presentation/view/pages/physical_info_page_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhysicalInfoArguments {
  final InfoType infoType;
  final dynamic physicalInfo;

  const PhysicalInfoArguments({
    required this.infoType,
    required this.physicalInfo,
  });
  
  Future<void> navigateAndUpdateProfile(BuildContext context, TextEditingController controller) async {
    final result = await Navigator.pushNamed(
      context,
      AppRoutes.physicalinfo,
      arguments: this,
    );
    
    if (result != null && context.mounted) {
      switch (infoType) {
        case InfoType.weight:
          if (result is int) {
            controller.text = result.toString();
            context.read<EditProfileBloc>().add(UpdateProfileEvent(
              fieldName: AppKeys.weight,
              fieldValue: result.toString(),
            ));
          }
          break;
          
        case InfoType.goal:
          if (result is String) {
            controller.text = result;
            context.read<EditProfileBloc>().add(UpdateProfileEvent(
              fieldName: AppKeys.goal,
              fieldValue: result,
            ));
          }
          break;
          
        case InfoType.activityLevel:
          if (result is String) {
            controller.text = result;
            context.read<EditProfileBloc>().add(UpdateProfileEvent(
              fieldName: AppKeys.activityLevel,
              fieldValue: result,
            ));
          }
          break;
      }
    }
  }
  
  static PhysicalInfoArguments forWeight(String value) {
    final int currentWeight = int.tryParse(value) ?? 90;
    return PhysicalInfoArguments(
      infoType: InfoType.weight,
      physicalInfo: currentWeight,
    );
  }
  
  static PhysicalInfoArguments forGoal(String value) {
    return PhysicalInfoArguments(
      infoType: InfoType.goal,
      physicalInfo: value,
    );
  }
  
  static PhysicalInfoArguments forActivityLevel(String value) {
    return PhysicalInfoArguments(
      infoType: InfoType.activityLevel,
      physicalInfo: value,
    );
  }
}
