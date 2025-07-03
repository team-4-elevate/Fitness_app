// features/edit_profile/presentation/view/pages/edit_profile_screen.dart
import 'dart:io';
import 'dart:ui' as ui;
import 'package:fitness_app/core/app_manger/bloc_handler_mixin.dart';
import 'package:fitness_app/core/Constant/app_keys.dart';
import 'package:fitness_app/features/edit_profile/domain/entities/activity_level_constants.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/core/utils/app_validator.dart';
import 'package:fitness_app/core/widgets/edit_profile_image.dart';
import 'package:fitness_app/features/edit_profile/domain/entities/physical_info_arguments.dart';
import 'package:fitness_app/features/edit_profile/presentation/bloc/edit_profile_bloc.dart';
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

  late final EditProfileBloc _bloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = context.read<EditProfileBloc>();
    _bloc.add(const FetchProfileDataEvent());
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _emailController.dispose();
    _weightController.dispose();
    _goalController.dispose();
    _activityLevelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<EditProfileBloc, EditProfileState>(
        listenWhen: (previous, current) =>
            previous.updateProfileStatus != current.updateProfileStatus ||
            previous.fetchProfileStatus != current.fetchProfileStatus ||
            previous.uploadImageStatus != current.uploadImageStatus ||
            previous.snackbarMessage != current.snackbarMessage,
        listener: (context, state) {
          if (state.snackbarMessage != null) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.snackbarMessage!),
                backgroundColor:
                    state.isErrorSnackbar ? Colors.red : Colors.green,
              ),
            );
          }
          if (state.fetchProfileStatus == Status.success) {
            context.read<EditProfileBloc>().add(
                  UpdateControllersEvent(
                    controllers: {
                      AppKeys.firstName: _firstnameController,
                      AppKeys.lastName: _lastnameController,
                      AppKeys.email: _emailController,
                      AppKeys.weight: _weightController,
                      AppKeys.goal: _goalController,
                      AppKeys.activityLevel: _activityLevelController,
                    },
                  ),
                );
          }

          if (state.uploadImageStatus == Status.loading) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(context.l10n.upload_image),
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/exercise_btm_background.png'),
                      fit: BoxFit.cover,
                    ),
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
                          EditProfileText(),
                          const SizedBox(height: 20),
                          EditprofileImage(
                            isEditButton: true,
                            img: state.profileData?.user?.photo ?? '',
                            onImageSelected: (File selectedImage) {
                              context.read<EditProfileBloc>().add(
                                    UploadProfileImageEvent(
                                        photo: selectedImage),
                                  );
                            },
                          ),
                          const SizedBox(height: 15),
                          Text(
                            _firstnameController.text.isEmpty &&
                                    _lastnameController.text.isEmpty
                                ? context.l10n.loading
                                : '${_firstnameController.text} ${_lastnameController.text}',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 22.r,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 30),
                          TextFormField(
                            controller: _firstnameController,
                            keyboardType: TextInputType.name,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: AppValidators.validateFirstName,
                            onChanged: (value) {
                              if (value.isNotEmpty &&
                                  _formKey.currentState?.validate() == true) {
                                _bloc.add(UpdateProfileEvent(
                                  fieldName: AppKeys.firstName,
                                  fieldValue: value,
                                ));
                              }
                            },
                            decoration: InputDecoration(
                                hintText: context.l10n.first_name,
                                // hintStyle: TextStyle(color: AppColors.white),
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
                          TextFormField(
                            controller: _lastnameController,
                            keyboardType: TextInputType.name,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: AppValidators.validateLastName,
                            onChanged: (value) {
                              if (value.isNotEmpty &&
                                  _formKey.currentState?.validate() == true) {
                                _bloc.add(UpdateProfileEvent(
                                  fieldName: AppKeys.lastName,
                                  fieldValue: value,
                                ));
                              }
                            },
                            decoration: InputDecoration(
                                hintText: context.l10n.second_name,
                                // hintStyle: TextStyle(color: AppColors.white),
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
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            validator: AppValidators.validateEmail,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: _emailController,
                            onChanged: (value) {
                              if (value.isNotEmpty &&
                                  _formKey.currentState?.validate() == true) {
                                _bloc.add(UpdateProfileEvent(
                                  fieldName: AppKeys.email,
                                  fieldValue: value,
                                ));
                              }
                            },
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding:
                                    EdgeInsets.only(left: 16.r, right: 8.r),
                                child: Icon(
                                  Icons.email_outlined,
                                  color: AppColors.white,
                                ),
                              ),
                              hintText: context.l10n.email_hint,
                              //  hintStyle: TextStyle(color: AppColors.white),
                            ),
                          ),
                          SizedBox(height: 40.r),
                          PhysicalInfoText(
                            title: context.l10n.your_weight,
                            onTap: () {
                              PhysicalInfoArguments.forWeight(
                                      _weightController.text)
                                  .navigateAndUpdateProfile(
                                      context, _weightController);
                            },
                          ),
                          SizedBox(height: 8.r),
                          TextFormField(
                            controller: _weightController,
                            keyboardType: TextInputType.number,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            readOnly: true,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 30.r,
                              ),
                              hintText: context.l10n.weight_hint,
                            ),
                          ),
                          SizedBox(height: 16.r),
                          PhysicalInfoText(
                            title: context.l10n.your_goal,
                            onTap: () {
                              PhysicalInfoArguments.forGoal(
                                      _goalController.text)
                                  .navigateAndUpdateProfile(
                                      context, _goalController);
                            },
                          ),
                          SizedBox(height: 8.r),
                          TextFormField(
                            controller: _goalController,
                            readOnly: true,
                            keyboardType: TextInputType.name,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 30.r,
                              ),
                              hintText: context.l10n.gain_weight,
                            ),
                          ),
                          SizedBox(height: 16.r),
                          PhysicalInfoText(
                            title: context.l10n.your_activity_level,
                            onTap: () {
                              PhysicalInfoArguments.forActivityLevel(
                                      _activityLevelController.text)
                                  .navigateAndUpdateProfile(
                                      context, _activityLevelController);
                            },
                          ),
                          SizedBox(height: 8.r),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            readOnly: true,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 30.r,
                              ),
                              hintText: ActivityLevelConstants.getLabel(
                                  _activityLevelController.text),
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
