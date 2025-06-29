// features/edit_profile/pages/edit_profile_screen.dart
import 'dart:ui' as ui;

import 'package:fitness_app/core/routes/app_routes.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/core/utils/app_validator.dart';
import 'package:fitness_app/features/edit_profile/pages/physical_info_page_view.dart';
import 'package:fitness_app/features/edit_profile/widgets/editprofile_image.dart';
import 'package:fitness_app/features/edit_profile/widgets/editprofile_text.dart';
import 'package:fitness_app/features/edit_profile/widgets/physical_info_text.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  //form key
  final _formKey = GlobalKey<FormState>();
  //weight controller
  final _weightController = TextEditingController();
  //goal controller
  final _goalController = TextEditingController();
  //activity level controller
  final _activityLevelController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _weightController.text = "90";
    _goalController.text = "Gain Weight";
    _activityLevelController.text = "Rookie";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/exercise_btm_background.png'),
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
                      'Ahmed Mohamed',
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
                      keyboardType: TextInputType.name,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: AppValidators.validateFirstName,
                      decoration: InputDecoration(
                          hintText: 'Ahmed',
                          hintStyle: TextStyle(color: AppColors.white),
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 16.r, right: 8.r),
                            child: const Icon(
                              Icons.person_2_outlined,
                              color: AppColors.white,
                            ),
                          )),
                    ),
                    SizedBox(height: 16.r),

                    ///last name
                    TextFormField(
                      keyboardType: TextInputType.name,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: AppValidators.validateLastName,
                      decoration: InputDecoration(
                          hintText: 'Mohamed',
                          hintStyle: TextStyle(color: AppColors.white),
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 16.r, right: 8.r),
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 16.r, right: 8.r),
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
                      keyboardType: TextInputType.name,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      keyboardType: TextInputType.name,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: AppValidators.validateLastName,
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

                    ///your goal
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
                      keyboardType: TextInputType.name,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: AppValidators.validateLastName,
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
                    SizedBox(height: 160.r),
                  ],
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
