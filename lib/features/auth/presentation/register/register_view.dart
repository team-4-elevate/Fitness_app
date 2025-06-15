// features/auth/presentation/register/register_view.dart
import 'package:fitness_app/core/routes/app_routes.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/core/utils/app_validator.dart';
import 'package:fitness_app/features/auth/domain/arguments/auth_pages_ui_arguments.dart';
import 'package:fitness_app/features/auth/presentation/auth_common_widgets/custom_auth_view.dart';
import 'package:fitness_app/features/auth/presentation/register/widget/password_strength_indicator.dart';
import 'package:fitness_app/features/auth/presentation/auth_common_widgets/social_buttons.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/auth/presentation/register/register_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool _obscurePassword = true;
  bool _hasFirstNameError = false;
  bool _hasLastNameError = false;
  bool _hasEmailError = false;
  bool _hasPasswordError = false;
  int _passwordStrength = 0;

  // Controllers to track current values
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  //form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _firstNameController.addListener(_updateFirstNameErrorState);
    _lastNameController.addListener(_updateLastNameErrorState);
    _emailController.addListener(_updateEmailErrorState);
    _passwordController.addListener(_updatePasswordErrorState);
  }

  @override
  void dispose() {
    _firstNameController.removeListener(_updateFirstNameErrorState);
    _lastNameController.removeListener(_updateLastNameErrorState);
    _emailController.removeListener(_updateEmailErrorState);
    _passwordController.removeListener(_updatePasswordErrorState);

    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _updateFirstNameErrorState() {
    final error = AppValidators.validateFirstName(_firstNameController.text);
    final hasError = error != null;
    if (hasError != _hasFirstNameError) {
      setState(() {
        _hasFirstNameError = hasError;
      });
    }
  }

  void _updateLastNameErrorState() {
    final error = AppValidators.validateLastName(_lastNameController.text);
    final hasError = error != null;
    if (hasError != _hasLastNameError) {
      setState(() {
        _hasLastNameError = hasError;
      });
    }
  }

  void _updateEmailErrorState() {
    final error = AppValidators.validateEmail(_emailController.text);
    final hasError = error != null;
    if (hasError != _hasEmailError) {
      setState(() {
        _hasEmailError = hasError;
      });
    }
  }

  void _updatePasswordErrorState() {
    final (error, strength) = AppValidators.validatePasswordWithStrength(
      _passwordController.text,
    );
    final hasError = error != null;
    if (hasError != _hasPasswordError || strength != _passwordStrength) {
      setState(() {
        _hasPasswordError = hasError;
        _passwordStrength = strength;
      });
    }
  }

  void _updateAllErrorStates() {
    if (!mounted) return;

    setState(() {
      _hasFirstNameError =
          AppValidators.validateFirstName(_firstNameController.text) != null;
      _hasLastNameError =
          AppValidators.validateLastName(_lastNameController.text) != null;
      _hasEmailError =
          AppValidators.validateEmail(_emailController.text) != null;
      _hasPasswordError =
          AppValidators.validatePassword(_passwordController.text) != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: CustomAuthScreensView(
        //-----------------------------------------------------title arguments
        args: AuthPagesUiArguments(
          firstTitleArguments: const AuthPageTitleArguments(
            isBold: false,
            text: 'Hi there',
          ),
          secondTitleArguments: const AuthPageTitleArguments(
            isBold: true,
            text: 'Create An Account',
          ),

          isRegister: true,
          registerStep: 1,
          showSocialLogin: true,
          primaryButtonText: "Register",
          primaryButtonAction: () {
            final isValid = _formKey.currentState?.validate() ?? false;

            WidgetsBinding.instance.addPostFrameCallback((_) {
              _updateAllErrorStates();
            });

            if (isValid) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const RegisterDetailsView();
                  },
                ),
              );
            }
          },

          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Register ",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  SizedBox(height: 16.r),

                  //------------------------------------------------------first name
                  SizedBox(
                    height: _hasFirstNameError ? 60.r : 38.r,
                    width: double.infinity,
                    child: TextFormField(
                      controller: _firstNameController,
                      keyboardType: TextInputType.name,
                      validator: AppValidators.validateFirstName,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        errorText:
                            _hasFirstNameError
                                ? AppValidators.validateFirstName(
                                  _firstNameController.text,
                                )
                                : null,
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 16.r, right: 8.r),
                          child: SvgPicture.asset(
                            'assets/icons/user.svg',
                            height: 24.r,
                            width: 24.r,
                          ),
                        ),
                        hintText: 'First Name',
                      ),
                    ),
                  ),
                  SizedBox(height: 16.r),

                  //------------------------------------------------------second name
                  SizedBox(
                    height: _hasLastNameError ? 60.r : 38.r,
                    width: double.infinity,
                    child: TextFormField(
                      controller: _lastNameController,
                      keyboardType: TextInputType.name,
                      validator: AppValidators.validateLastName,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        errorText:
                            _hasLastNameError
                                ? AppValidators.validateLastName(
                                  _lastNameController.text,
                                )
                                : null,
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 16.r, right: 8.r),
                          child: SvgPicture.asset(
                            'assets/icons/user.svg',
                            height: 24.r,
                            width: 24.r,
                          ),
                        ),
                        hintText: 'Last Name',
                      ),
                    ),
                  ),

                  SizedBox(height: 16.r),

                  //------------------------------------------------------email
                  SizedBox(
                    height: _hasEmailError ? 60.r : 38.r,
                    width: double.infinity,
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: AppValidators.validateEmail,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        errorText:
                            _hasEmailError
                                ? AppValidators.validateEmail(
                                  _emailController.text,
                                )
                                : null,
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 16.r, right: 8.r),
                          child: Icon(Icons.email_outlined),
                        ),
                        hintText: 'Email',
                      ),
                    ),
                  ),

                  SizedBox(height: 16.r),

                  //------------------------------------------------------Password
                  SizedBox(
                    height: _hasPasswordError ? 60.r : 38.r,
                    width: double.infinity,
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      keyboardType: TextInputType.visiblePassword,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (_passwordStrength <= 0) {
                          return "Password is Required";
                        }
                      },

                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 16.r, right: 8.r),
                          child: Icon(Icons.lock_outline_sharp),
                        ),
                        hintText: 'Password',
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 20.r),
                            child: SvgPicture.asset(
                              'assets/icons/eye.svg',
                              height: 24.r,
                              width: 24.r,
                              colorFilter: ColorFilter.mode(
                                _obscurePassword
                                    ? Colors.white.withOpacity(0.7)
                                    : AppColors.primaryOrange,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10.r),

                  if (_passwordController.text.isNotEmpty) ...[
                    SizedBox(height: 8.r),
                    PasswordStrengthIndicator(strength: _passwordStrength),
                  ],

                  if (_passwordController.text.isNotEmpty) ...[
                    SizedBox(height: 24.r),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
