// features/edit_profile/presentation/view/pages/edit_profile_screen.dart
import 'dart:ui' as ui;
import 'package:fitness_app/core/app_manger/bloc_handler_mixin.dart';
import 'package:fitness_app/core/routes/app_routes.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/core/utils/app_validator.dart';
import 'package:fitness_app/features/edit_profile/presentation/bloc/edit_profile_bloc.dart';
import 'package:fitness_app/features/edit_profile/presentation/view/pages/physical_info_page_view.dart';
import 'package:fitness_app/features/edit_profile/presentation/view/widgets/editprofile_image.dart';
import 'package:fitness_app/features/edit_profile/presentation/view/widgets/editprofile_text.dart';
import 'package:fitness_app/features/edit_profile/presentation/view/widgets/physical_info_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  //form key and controllers
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _goalController = TextEditingController();
  final TextEditingController _activityLevelController =
      TextEditingController();

  String _currentFirstName = "";
  String _currentLastName = "";
  String _currentEmail = "";
  bool _formChanged = false;

  late final EditProfileBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = context.read<EditProfileBloc>();
    _bloc.add(const FetchProfileDataEvent());
  }

  void _updateFormFields(EditProfileState state) {
    if (state.fetchProfileStatus == Status.success &&
        state.profileData != null &&
        state.profileData.user != null) {
      _formChanged = false;

      _firstnameController.text = state.profileData.user!.firstName ?? "";
      _lastnameController.text = state.profileData.user!.lastName ?? "";
      _emailController.text = state.profileData.user!.email ?? "";
      _weightController.text = state.profileData.user!.weight?.toString() ?? "";
      _goalController.text = state.profileData.user!.goal ?? "";
      _activityLevelController.text =
          state.profileData.user!.activityLevel ?? "";

      setState(() {
        _currentFirstName = state.profileData.user!.firstName ?? "";
        _currentLastName = state.profileData.user!.lastName ?? "";
        _currentEmail = state.profileData.user!.email ?? "";
      });
      _setupControllerListeners();
    }
  }

  void _setupControllerListeners() {
    _firstnameController.removeListener(_onTextFieldChanged);
    _lastnameController.removeListener(_onTextFieldChanged);
    _emailController.removeListener(_onTextFieldChanged);
    _weightController.removeListener(_onTextFieldChanged);
    _goalController.removeListener(_onTextFieldChanged);
    _activityLevelController.removeListener(_onTextFieldChanged);

    _firstnameController.addListener(_onTextFieldChanged);
    _lastnameController.addListener(_onTextFieldChanged);
    _emailController.addListener(_onTextFieldChanged);
    _weightController.addListener(_onTextFieldChanged);
    _goalController.addListener(_onTextFieldChanged);
    _activityLevelController.addListener(_onTextFieldChanged);
  }

  void _onTextFieldChanged() {
    setState(() {
      _currentFirstName = _firstnameController.text;
      _currentLastName = _lastnameController.text;
      _currentEmail = _emailController.text;
      _formChanged = true;
    });

    if (_formKey.currentState?.validate() == true) {
      _bloc.debouncedSaveProfile(
        firstName: _firstnameController.text,
        lastName: _lastnameController.text,
        email: _emailController.text,
        weight: _weightController.text,
        goal: _goalController.text,
        activityLevel: _activityLevelController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<EditProfileBloc, EditProfileState>(
        listenWhen: (previous, current) =>
            previous.updateProfileStatus != current.updateProfileStatus ||
            previous.fetchProfileStatus != current.fetchProfileStatus,
        listener: (context, state) {
          if (state.fetchProfileStatus == Status.success) {
            _updateFormFields(state);
          }
          if (state.updateProfileStatus == Status.success) {
            setState(() {
              _formChanged = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Profile updated successfully!'),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state.updateProfileStatus == Status.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${state.errorMessage}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image:
                        AssetImage('assets/images/exercise_btm_background.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                child: Container(color: AppColors.black.withOpacity(0.3)),
              ),
              SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.r),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          //------------------------------------------- text
                          EditprofileText(),
                          const SizedBox(height: 20),

                          //------------------------------------------- image
                          const EditprofileImage(),
                          const SizedBox(height: 15),

                          //------------------------------------------- name
                          Text(
                            _currentFirstName.isEmpty &&
                                    _currentLastName.isEmpty
                                ? 'Loading...'
                                : '$_currentFirstName $_currentLastName',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 22.r,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 30),

                          //------------------------------------------textform name and email

                          ///first name
                          TextFormField(
                            controller: _firstnameController,
                            keyboardType: TextInputType.name,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: AppValidators.validateFirstName,
                            decoration: InputDecoration(
                                hintText: 'Ahmed',
                                hintStyle: TextStyle(color: AppColors.white),
                                prefixIcon: Padding(
                                  padding:
                                      EdgeInsets.only(left: 16.r, right: 8.r),
                                  child: const Icon(
                                    Icons.person_2_outlined,
                                    color: AppColors.white,
                                  ),
                                )),
                          ),
                          SizedBox(height: 16.r),

                          ///last name
                          TextFormField(
                            controller: _lastnameController,
                            keyboardType: TextInputType.name,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: AppValidators.validateLastName,
                            decoration: InputDecoration(
                                hintText: 'Mohamed',
                                hintStyle: TextStyle(color: AppColors.white),
                                prefixIcon: Padding(
                                  padding:
                                      EdgeInsets.only(left: 16.r, right: 8.r),
                                  child: const Icon(
                                    Icons.person_2_outlined,
                                    color: AppColors.white,
                                  ),
                                )),
                          ),
                          SizedBox(height: 16.r),

                          ///email
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            validator: AppValidators.validateEmail,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: _emailController,
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding:
                                    EdgeInsets.only(left: 16.r, right: 8.r),
                                child: Icon(
                                  Icons.email_outlined,
                                  color: AppColors.white,
                                ),
                              ),
                              hintText: 'Email',
                              hintStyle: TextStyle(color: AppColors.white),
                            ),
                          ),
                          SizedBox(height: 40.r),

                          //-----------------------------------physical info

                          ///your weight
                          PhysicalInfoText(
                            title: "Your Weight",
                            onTap: () async {
                              int currentWeight = 90;
                              if (_weightController.text.isNotEmpty) {
                                currentWeight =
                                    int.tryParse(_weightController.text) ?? 90;
                              }
                              final args = {
                                'infoType': InfoType.weight,
                                'physicalInfo': currentWeight,
                              };

                              final result = await Navigator.pushNamed(
                                context,
                                AppRoutes.physicalinfo,
                                arguments: args,
                              );

                              if (result != null && result is int) {
                                setState(() {
                                  _weightController.text = result.toString();
                                });
                              }
                            },
                          ),
                          SizedBox(height: 8.r),

                          TextFormField(
                            controller: _weightController,
                            keyboardType: TextInputType.number,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            readOnly: true,
                            enabled: false,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 30.r,
                              ),
                              hintText: _weightController.text,
                              hintStyle: TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          SizedBox(height: 16.r),

                          ///your goal
                          PhysicalInfoText(
                            title: "Your Goal",
                            onTap: () async {
                              final args = {
                                'infoType': InfoType.goal,
                                'physicalInfo': _goalController.text,
                              };

                              final result = await Navigator.pushNamed(
                                context,
                                AppRoutes.physicalinfo,
                                arguments: args,
                              );

                              if (result != null && result is String) {
                                setState(() {
                                  _goalController.text = result;
                                });
                              }
                            },
                          ),
                          SizedBox(height: 8.r),
                          TextFormField(
                            controller: _goalController,
                            readOnly: true,
                            enabled: false,
                            keyboardType: TextInputType.name,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 30.r,
                              ),
                              hintText: 'Gain weight',
                              hintStyle: TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          SizedBox(height: 16.r),

                          ///your activity level
                          PhysicalInfoText(
                            title: "Your Activity Level",
                            onTap: () async {
                              final args = {
                                'infoType': InfoType.activityLevel,
                                'physicalInfo': _activityLevelController.text,
                              };

                              final result = await Navigator.pushNamed(
                                context,
                                AppRoutes.physicalinfo,
                                arguments: args,
                              );

                              if (result != null && result is String) {
                                setState(() {
                                  _activityLevelController.text = result;
                                });
                              }
                            },
                          ),
                          SizedBox(height: 8.r),
                          TextFormField(
                            controller: _activityLevelController,
                            keyboardType: TextInputType.name,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            readOnly: true,
                            enabled: false,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 30.r,
                              ),
                              hintText: 'Rookie',
                              hintStyle: TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          SizedBox(height: 30.r),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
