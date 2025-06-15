// features/auth/presentation/register/register_details_view.dart
import 'package:fitness_app/features/auth/domain/arguments/auth_pages_ui_arguments.dart';
import 'package:fitness_app/features/auth/domain/models/activity_level_option.dart';
import 'package:fitness_app/features/auth/domain/models/goal_option.dart';
import 'package:fitness_app/features/auth/domain/models/register_details.dart';
import 'package:fitness_app/features/auth/domain/models/registration_steps.dart';
import 'package:fitness_app/features/auth/presentation/auth_common_widgets/custom_auth_view.dart';
import 'package:fitness_app/features/auth/presentation/register/widget/gender_step.dart';
import 'package:fitness_app/features/auth/presentation/register/widget/number_picker_step.dart';
import 'package:fitness_app/features/auth/presentation/register/widget/selection_option_step.dart';
import 'package:flutter/material.dart';

enum Gender { male, female }

class RegisterDetailsView extends StatefulWidget {
  const RegisterDetailsView({super.key});

  @override
  State<RegisterDetailsView> createState() => _RegisterDetailsViewState();
}

class _RegisterDetailsViewState extends State<RegisterDetailsView> {
  int _currentStep = 1;
  late RegisterDetailsData _userData;

  @override
  void initState() {
    super.initState();
    _userData =
        RegisterDetailsData()
          ..age = 25
          ..weight = 90.0
          ..height = 167.0;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _goToNextStep() {
    if (_currentStep < 6) {
      setState(() {
        _currentStep++;
      });
    } else {
      _submitData();
    }
  }

  void _submitData() {
    debugPrint('User data: $_userData');
  }

  void _goToPreviousStep() {
    if (_currentStep > 1) {
      setState(() {
        _currentStep--;
      });
    } else {
      // Return to register screen
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomAuthScreensView(
      args: AuthPagesUiArguments(
        firstTitleArguments: AuthPageTitleArguments(
          isBold: true,
          text: RegistrationSteps.getTitleForStep(_currentStep),
        ),
        secondTitleArguments: AuthPageTitleArguments(
          isBold: false,
          text: RegistrationSteps.getSubtitleForStep(_currentStep),
        ),
        isRegister: true,
        registerStep: _currentStep,
        showSocialLogin: false,
        primaryButtonText: _currentStep < 6 ? 'Next' : 'Finish',
        primaryButtonAction: () {
          bool isValid = _validateCurrentStep();
          if (isValid) {
            _goToNextStep();
          }
        },
        content: _buildStepContent(),
      ),
      currentStep: _currentStep,
      totalSteps: 6,
      isDetailsStep: true,
      onBackPressed: _goToPreviousStep,
    );
  }

  bool _validateCurrentStep() {
    switch (_currentStep) {
      case 1:
        return _userData.gender != null;
      case 2:
        return _userData.age != null;
      case 3:
        return _userData.weight != null;
      case 4:
        return _userData.height != null;
      case 5:
        return _userData.goal != null;
      case 6:
        return _userData.activityLevel != null;
      default:
        return true;
    }
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      ///----------------------------------------gender step----------------------------------------
      case 1:
        return GenderStep(
          userData: _userData,
          onGenderSelected: (gender) {
            setState(() {
              _userData.gender = gender == 'Male' ? Gender.male : Gender.female;
            });
          },
        );

      ///----------------------------------------age step----------------------------------------
      case 2:
        return NumberPickerStep(
          label: 'Year',
          value: _userData.age ?? 25,
          minValue: 5,
          maxValue: 100,
          itemCount: 9,
          itemWidth: 35.0,
          onChanged: (value) {
            setState(() {
              _userData.age = value;
            });
          },
        );

      ///----------------------------------------weight step----------------------------------------
      case 3:
        return NumberPickerStep(
          label: 'Kg',
          value: _userData.weight?.round() ?? 90,
          minValue: 20,
          maxValue: 350,
          itemCount: 9,
          itemWidth: 35.0,
          onChanged: (value) {
            setState(() {
              _userData.weight = value.toDouble();
            });
          },
        );

      ///----------------------------------------height step----------------------------------------
      case 4:
        return NumberPickerStep(
          label: 'Cm',
          value: _userData.height?.round() ?? 167,
          minValue: 140,
          maxValue: 200,
          itemCount: 6,
          itemWidth: 60.0,
          onChanged: (value) {
            setState(() {
              _userData.height = value.toDouble();
            });
          },
        );

      ///----------------------------------------goal step----------------------------------------
      case 5:
        final goalOptions = GoalOption.getGoalOptions();
        return SelectionOptionStep(
          options:
              goalOptions
                  .map(
                    (option) => OptionItem(id: option.id, label: option.label),
                  )
                  .toList(),
          selectedOptionId: _userData.goal,
          onOptionSelected: (goalId) {
            setState(() {
              _userData.goal = goalId;
            });
          },
        );

      ///----------------------------------------activity level step----------------------------------------
      case 6:
        final activityOptions = ActivityLevelOption.getActivityLevelOptions();
        return SelectionOptionStep(
          options:
              activityOptions
                  .map(
                    (option) => OptionItem(id: option.id, label: option.label),
                  )
                  .toList(),
          selectedOptionId: _userData.activityLevel,
          onOptionSelected: (activityId) {
            setState(() {
              _userData.activityLevel = activityId;
            });
          },
        );
      default:
        return const SizedBox();
    }
  }
}
