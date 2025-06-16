// features/auth/presentation/register/pages/register_details_view.dart
import 'package:fitness_app/core/base_states/base_state.dart';
import 'package:fitness_app/core/routes/app_routes.dart';
import 'package:fitness_app/features/auth/domain/arguments/auth_pages_ui_arguments.dart';
import 'package:fitness_app/features/auth/presentation/register/bloc/register_bloc.dart';
import 'package:fitness_app/features/auth/presentation/register/models/activity_level_option.dart';
import 'package:fitness_app/features/auth/presentation/register/models/goal_option.dart';
import 'package:fitness_app/features/auth/domain/entities/register_details.dart';
import 'package:fitness_app/features/auth/presentation/register/models/registration_steps.dart';
import 'package:fitness_app/features/auth/presentation/auth_common_widgets/custom_auth_view.dart';
import 'package:fitness_app/features/auth/presentation/register/widget/gender_step.dart';
import 'package:fitness_app/features/auth/presentation/register/widget/number_picker_step.dart';
import 'package:fitness_app/features/auth/presentation/register/widget/selection_option_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum Gender { male, female }

class RegisterDetailsView extends StatefulWidget {
  final RegisterDetailsData? initialData;

  const RegisterDetailsView({super.key, this.initialData});

  @override
  State<RegisterDetailsView> createState() => _RegisterDetailsViewState();
}

class _RegisterDetailsViewState extends State<RegisterDetailsView> {
  int _currentStep = 1;
  late RegisterDetailsData _userData;

  @override
  void initState() {
    super.initState();
    _userData = widget.initialData ?? RegisterDetailsData();
    _userData.age ??= 25;
    _userData.weight ??= 90;
    _userData.height ??= 167;
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
    if (_userData.password != null) {
      _userData.rePassword = _userData.password;
    }

    context.read<RegisterBloc>().add(RegisterSubmitted(_userData));
  }

  void _goToPreviousStep() {
    if (_currentStep > 1) {
      setState(() {
        _currentStep--;
      });
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterStateType>(
      listener: (context, state) {
        if (state is LoadingState) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder:
                (context) => const Center(child: CircularProgressIndicator()),
          );
        } else if (state is SuccessState) {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
          
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Registration successful!'),
              backgroundColor: Colors.green,
            ),
          );
          
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.homePage,
            (route) => false, 
          );
         
        } else if (state is ErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text((state as ErrorState).error),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: CustomAuthScreensView(
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
      ),
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
              _userData.weight = value.toInt();
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
              _userData.height = value.toInt();
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
