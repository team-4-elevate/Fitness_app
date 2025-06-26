import 'package:bloc_test/bloc_test.dart';
import 'package:fitness_app/core/base_states/app_states.dart';
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/auth/data/model/login_models/login_request/login_request.dart';
import 'package:fitness_app/features/auth/data/model/login_models/login_response/login_response.dart';
import 'package:fitness_app/features/auth/data/model/login_models/login_response/user.dart';
import 'package:fitness_app/features/auth/presentation/login/login_intent.dart';
import 'package:fitness_app/features/auth/presentation/login/login_state.dart';
import 'package:fitness_app/features/auth/presentation/login/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../data/datasource/remote_data_source/mocks.dart';
import '../../data/datasource/remote_data_source/mocks.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    setupDummyValues();
  });

  group('LoginViewModel Tests', () {
    late LoginViewModel loginViewModel;
    late MockLoginUseCase mockLoginUseCase;

    final mockUser = User(
      id: '12345',
      firstName: 'John',
      lastName: 'Doe',
      email: 'test@example.com',
      gender: 'male',
      age: 25,
      weight: 70,
      height: 175,
      activityLevel: 'level1',
      goal: 'muscle gain',
      photo: 'https://example.com/photo.jpg',
      createdAt: DateTime.parse('2023-06-17T10:00:00.000Z'),
    );

    final mockLoginResponse = LoginResponse(
      message: 'Login successful',
      user: mockUser,
      token: 'mock_jwt_token_12345',
    );

    setUp(() {
      mockLoginUseCase = MockLoginUseCase();
      loginViewModel = LoginViewModel(mockLoginUseCase);
    });

    tearDown(() {
      if (!loginViewModel.isClosed) {
        loginViewModel.close();
      }
    });

    group('Initial State', () {
      test('should have correct initial state', () {
        expect(loginViewModel.state, equals(const LoginState()));
        expect(loginViewModel.state.loginState, isNull);
        expect(loginViewModel.state.navigateToResetPassword, isFalse);
        expect(loginViewModel.state.navigateToSignUp, isFalse);
        expect(loginViewModel.state.navigateToHome, isFalse);
        expect(loginViewModel.state.showSocialLoginMessage, isFalse);
        expect(loginViewModel.state.emailError, isNull);
        expect(loginViewModel.state.passwordError, isNull);
        expect(loginViewModel.state.isFormValid, isFalse);
      });

      test('should have correct initial controllers and form key', () {
        expect(loginViewModel.emailController.text, isEmpty);
        expect(loginViewModel.passwordController.text, isEmpty);
        expect(loginViewModel.formKey, isA<GlobalKey<FormState>>());
        expect(loginViewModel.isPasswordVisible.value, isTrue);
        expect(loginViewModel.emailError, isNull);
        expect(loginViewModel.passwordError, isNull);
        expect(loginViewModel.isFormValid, isFalse);
      });
    });

    group('Validation Tests', () {
      group('Email Validation', () {
        test('should show error for invalid email format', () {
          loginViewModel.emailController.text = 'invalid-email';
          loginViewModel.loginIntent(LoginIntent.validateEmail);

          expect(loginViewModel.emailError, isNotNull);
          expect(loginViewModel.state.emailError, isNotNull);
          expect(loginViewModel.isFormValid, isFalse);
          expect(loginViewModel.state.isFormValid, isFalse);
        });

        test('should clear error for valid email format', () {
          loginViewModel.emailController.text = 'test@example.com';
          loginViewModel.loginIntent(LoginIntent.validateEmail);

          expect(loginViewModel.emailError, isNull);
          expect(loginViewModel.state.emailError, isNull);
          expect(loginViewModel.isFormValid, isTrue);
          expect(loginViewModel.state.isFormValid, isTrue);
        });

        test('should show error for empty email', () {
          loginViewModel.emailController.text = '';
          loginViewModel.loginIntent(LoginIntent.validateEmail);

          expect(loginViewModel.emailError, isNotNull);
          expect(loginViewModel.isFormValid, isFalse);
        });

        test('should validate various email formats correctly', () {
          final testCases = [
            {'email': 'test@example.com', 'shouldBeValid': true},
            {'email': 'user.name@domain.co.uk', 'shouldBeValid': true},
            {'email': 'invalid-email', 'shouldBeValid': false},
            {'email': '@example.com', 'shouldBeValid': false},
            {'email': 'test@', 'shouldBeValid': false},
            {'email': '', 'shouldBeValid': false},
            {'email': 'test.example.com', 'shouldBeValid': false},
          ];

          for (final testCase in testCases) {
            loginViewModel.emailController.text = testCase['email'] as String;
            loginViewModel.loginIntent(LoginIntent.validateEmail);

            if (testCase['shouldBeValid'] as bool) {
              expect(
                loginViewModel.emailError,
                isNull,
                reason: 'Email ${testCase['email']} should be valid',
              );
            } else {
              expect(
                loginViewModel.emailError,
                isNotNull,
                reason: 'Email ${testCase['email']} should be invalid',
              );
            }
          }
        });
      });

      group('Password Validation', () {
        test('should show error for weak password', () {
          loginViewModel.passwordController.text = '123';
          loginViewModel.loginIntent(LoginIntent.validatePassword);

          expect(loginViewModel.passwordError, isNotNull);
          expect(loginViewModel.isFormValid, isFalse);
        });

        test('should clear error for strong password', () {
          loginViewModel.passwordController.text = 'Test@123';
          loginViewModel.loginIntent(LoginIntent.validatePassword);

          expect(loginViewModel.passwordError, isNull);
          expect(loginViewModel.isFormValid, isTrue);
          expect(loginViewModel.state.isFormValid, isTrue);
        });

        test('should show error for empty password', () {
          loginViewModel.passwordController.text = '';
          loginViewModel.loginIntent(LoginIntent.validatePassword);

          expect(loginViewModel.passwordError, isNotNull);
          expect(loginViewModel.isFormValid, isFalse);
        });

        test('should validate various password formats correctly', () {
          final testCases = [
            {'password': 'Test@123', 'shouldBeValid': true},
            {'password': 'MyP@ssw0rd', 'shouldBeValid': true},
            {'password': '123', 'shouldBeValid': false},
            {'password': 'password', 'shouldBeValid': false},
            {'password': 'PASSWORD', 'shouldBeValid': false},
            {'password': '', 'shouldBeValid': false},
            {'password': 'Test123', 'shouldBeValid': false},
          ];

          for (final testCase in testCases) {
            loginViewModel.passwordController.text =
                testCase['password'] as String;
            loginViewModel.loginIntent(LoginIntent.validatePassword);

            if (testCase['shouldBeValid'] as bool) {
              expect(
                loginViewModel.passwordError,
                isNull,
                reason: 'Password ${testCase['password']} should be valid',
              );
            } else {
              expect(
                loginViewModel.passwordError,
                isNotNull,
                reason: 'Password ${testCase['password']} should be invalid',
              );
            }
          }
        });
      });

      group('Form Validation', () {
        test(
          'should set isFormValid to true when both email and password are valid',
          () {
            loginViewModel.emailController.text = 'test@example.com';
            loginViewModel.passwordController.text = 'Test@123';

            loginViewModel.loginIntent(LoginIntent.validateEmail);
            loginViewModel.loginIntent(LoginIntent.validatePassword);

            expect(loginViewModel.isFormValid, isTrue);
            expect(loginViewModel.state.isFormValid, isTrue);
            expect(loginViewModel.emailError, isNull);
            expect(loginViewModel.passwordError, isNull);
          },
        );

        test('should set isFormValid to false when email is invalid', () {
          loginViewModel.emailController.text = 'invalid-email';
          loginViewModel.passwordController.text = 'Test@123';

          loginViewModel.loginIntent(LoginIntent.validateEmail);
          loginViewModel.loginIntent(LoginIntent.validatePassword);

          expect(loginViewModel.isFormValid, isFalse);
          expect(loginViewModel.state.isFormValid, isFalse);
        });

        test('should set isFormValid to false when password is invalid', () {
          loginViewModel.emailController.text = 'test@example.com';
          loginViewModel.passwordController.text = '123';

          loginViewModel.loginIntent(LoginIntent.validateEmail);
          loginViewModel.loginIntent(LoginIntent.validatePassword);

          expect(loginViewModel.isFormValid, isFalse);
          expect(loginViewModel.state.isFormValid, isFalse);
        });

        test('should set isFormValid to false when both are invalid', () {
          loginViewModel.emailController.text = 'invalid-email';
          loginViewModel.passwordController.text = '123';

          loginViewModel.loginIntent(LoginIntent.validateEmail);
          loginViewModel.loginIntent(LoginIntent.validatePassword);

          expect(loginViewModel.isFormValid, isFalse);
          expect(loginViewModel.state.isFormValid, isFalse);
        });
      });

      group('Clear Validation Errors', () {
        test('should clear all validation errors', () {
          // Set invalid data first
          loginViewModel.emailController.text = 'invalid-email';
          loginViewModel.passwordController.text = '123';
          loginViewModel.loginIntent(LoginIntent.validateEmail);
          loginViewModel.loginIntent(LoginIntent.validatePassword);

          // Verify errors exist
          expect(loginViewModel.emailError, isNotNull);
          expect(loginViewModel.passwordError, isNotNull);
          expect(loginViewModel.isFormValid, isFalse);

          // Clear errors
          loginViewModel.loginIntent(LoginIntent.clearValidationErrors);

          // Verify errors are cleared
          expect(loginViewModel.emailError, isNull);
          expect(loginViewModel.passwordError, isNull);
          expect(loginViewModel.isFormValid, isFalse);
          expect(loginViewModel.state.emailError, isNull);
          expect(loginViewModel.state.passwordError, isNull);
          expect(loginViewModel.state.isFormValid, isFalse);
        });
      });
    });

    group('Login Button Pressed with Validation', () {
      test('should not proceed with login when form is invalid', () {
        loginViewModel.emailController.text = 'invalid-email';
        loginViewModel.passwordController.text = '123';

        loginViewModel.loginIntent(LoginIntent.loginButtonPressed);

        expect(loginViewModel.emailError, isNotNull);
        expect(loginViewModel.passwordError, isNotNull);
        expect(loginViewModel.isFormValid, isFalse);
        expect(loginViewModel.state.loginState, isNull);

        verifyNever(mockLoginUseCase.call(any));
      });

      blocTest<LoginViewModel, LoginState>(
        'should proceed with login when form is valid',
        build: () {
          when(
            mockLoginUseCase.call(any),
          ).thenAnswer((_) async => ApiSuccess(mockLoginResponse));
          return loginViewModel;
        },
        setUp: () {
          loginViewModel.emailController.text = 'test@example.com';
          loginViewModel.passwordController.text = 'Test@123';
        },
        act: (cubit) => cubit.loginIntent(LoginIntent.loginButtonPressed),
        expect: () => [
          predicate<LoginState>(
            (state) =>
                state.emailError == null &&
                state.passwordError == null &&
                state.isFormValid == true &&
                state.loginState == null,
          ),
          predicate<LoginState>(
            (state) => state.loginState is LoadingState<LoginResponse>,
          ),
          predicate<LoginState>(
            (state) => state.loginState is SuccessState<LoginResponse>,
          ),
        ],
        verify: (_) {
          verify(mockLoginUseCase.call(any)).called(1);
        },
      );

      test('should trim email before validation and login', () async {
        const emailWithSpaces = '  test@example.com  ';
        const trimmedEmail = 'test@example.com';

        when(
          mockLoginUseCase.call(any),
        ).thenAnswer((_) async => ApiSuccess(mockLoginResponse));

        loginViewModel.emailController.text = emailWithSpaces;
        loginViewModel.passwordController.text = 'Test@123';

        loginViewModel.loginIntent(LoginIntent.loginButtonPressed);
        await Future.delayed(Duration.zero);

        final captured = verify(mockLoginUseCase.call(captureAny)).captured;
        final capturedRequest = captured.first as LoginRequest;
        expect(capturedRequest.email, equals(trimmedEmail));
      });
    });

    group('Reset States with Validation', () {
      test('should reset all states including validation errors', () {
        loginViewModel.emailController.text = 'test@example.com';
        loginViewModel.passwordController.text = 'Test@123';
        loginViewModel.loginIntent(LoginIntent.validateEmail);
        loginViewModel.loginIntent(LoginIntent.validatePassword);

        // Verify data exists
        expect(loginViewModel.emailController.text, isNotEmpty);
        expect(loginViewModel.passwordController.text, isNotEmpty);
        expect(loginViewModel.isFormValid, isTrue);

        // Reset
        loginViewModel.loginIntent(LoginIntent.resetStates);

        // Verify reset
        expect(loginViewModel.emailController.text, isEmpty);
        expect(loginViewModel.passwordController.text, isEmpty);
        expect(loginViewModel.emailError, isNull);
        expect(loginViewModel.passwordError, isNull);
        expect(loginViewModel.isFormValid, isFalse);
        expect(loginViewModel.state, equals(const LoginState()));
      });
    });

    group('Navigation Intents', () {
      blocTest<LoginViewModel, LoginState>(
        'should emit state with navigateToResetPassword true',
        build: () => loginViewModel,
        act: (cubit) =>
            cubit.loginIntent(LoginIntent.forgotPasswordButtonPressed),
        expect: () => [
          predicate<LoginState>(
            (state) => state.navigateToResetPassword == true,
          ),
        ],
      );

      blocTest<LoginViewModel, LoginState>(
        'should emit state with showSocialLoginMessage true',
        build: () => loginViewModel,
        act: (cubit) => cubit.loginIntent(LoginIntent.socialLoginButtonPressed),
        expect: () => [
          predicate<LoginState>(
            (state) => state.showSocialLoginMessage == true,
          ),
        ],
      );

      blocTest<LoginViewModel, LoginState>(
        'should emit state with navigateToSignUp true',
        build: () => loginViewModel,
        act: (cubit) => cubit.loginIntent(LoginIntent.registerButtonPressed),
        expect: () => [
          predicate<LoginState>((state) => state.navigateToSignUp == true),
        ],
      );
    });

    group('Password Visibility', () {
      test('should toggle password visibility correctly', () {
        expect(loginViewModel.isPasswordVisible.value, isTrue);

        loginViewModel.loginIntent(LoginIntent.changePasswordVisibility);
        expect(loginViewModel.isPasswordVisible.value, isFalse);

        loginViewModel.loginIntent(LoginIntent.changePasswordVisibility);
        expect(loginViewModel.isPasswordVisible.value, isTrue);
      });
    });

    group('Error Handling', () {
      blocTest<LoginViewModel, LoginState>(
        'should handle use case throwing exception',
        build: () {
          when(
            mockLoginUseCase.call(any),
          ).thenThrow(Exception('Network error'));
          return loginViewModel;
        },
        setUp: () {
          loginViewModel.emailController.text = 'test@example.com';
          loginViewModel.passwordController.text = 'Test@123';
        },
        act: (cubit) => cubit.loginIntent(LoginIntent.loginButtonPressed),
        expect: () => [
          predicate<LoginState>(
            (state) =>
                state.emailError == null &&
                state.passwordError == null &&
                state.isFormValid == true &&
                state.loginState == null,
          ),
          predicate<LoginState>(
            (state) => state.loginState is LoadingState<LoginResponse>,
          ),
          predicate<LoginState>(
            (state) => state.loginState is ErrorState<LoginResponse>,
          ),
        ],
      );
    });

    group('Complex Scenarios', () {
      test(
        'should handle validation state updates correctly during typing simulation',
        () {
          final emailSteps = [
            't',
            'te',
            'tes',
            'test',
            'test@',
            'test@e',
            'test@ex',
            'test@example.com',
          ];

          for (final email in emailSteps) {
            loginViewModel.emailController.text = email;
            loginViewModel.loginIntent(LoginIntent.validateEmail);

            if (email == 'test@example.com') {
              expect(loginViewModel.emailError, isNull);
            } else {
              expect(loginViewModel.emailError, isNotNull);
            }
          }
        },
      );

      test('should maintain validation state during multiple interactions', () {
        // Setup
        loginViewModel.emailController.text = 'test@example.com';
        loginViewModel.passwordController.text = 'Test@123';

        loginViewModel.loginIntent(LoginIntent.validateEmail);
        expect(loginViewModel.emailError, isNull);
        expect(loginViewModel.isFormValid, isTrue);

        loginViewModel.loginIntent(LoginIntent.validatePassword);
        expect(loginViewModel.passwordError, isNull);
        expect(loginViewModel.isFormValid, isTrue);

        loginViewModel.loginIntent(LoginIntent.forgotPasswordButtonPressed);
        expect(loginViewModel.state.navigateToResetPassword, isTrue);
        expect(loginViewModel.isFormValid, isTrue);

        loginViewModel.loginIntent(LoginIntent.socialLoginButtonPressed);
        expect(loginViewModel.state.showSocialLoginMessage, isTrue);
        expect(loginViewModel.state.navigateToResetPassword, isTrue);
        expect(loginViewModel.isFormValid, isTrue);
      });
    });

    group('copyWith Method', () {
      test('should preserve navigation states correctly', () {
        expect(loginViewModel.state.navigateToResetPassword, isFalse);
        expect(loginViewModel.state.showSocialLoginMessage, isFalse);

        loginViewModel.loginIntent(LoginIntent.forgotPasswordButtonPressed);
        expect(loginViewModel.state.navigateToResetPassword, isTrue);
        expect(loginViewModel.state.showSocialLoginMessage, isFalse);

        loginViewModel.loginIntent(LoginIntent.socialLoginButtonPressed);
        expect(loginViewModel.state.navigateToResetPassword, isTrue);
        expect(loginViewModel.state.showSocialLoginMessage, isTrue);
      });

      test(
        'should handle validation state updates without affecting navigation',
        () {
          loginViewModel.loginIntent(LoginIntent.forgotPasswordButtonPressed);
          expect(loginViewModel.state.navigateToResetPassword, isTrue);

          loginViewModel.emailController.text = 'test@example.com';
          loginViewModel.loginIntent(LoginIntent.validateEmail);

          expect(loginViewModel.state.navigateToResetPassword, isTrue);
          expect(loginViewModel.state.emailError, isNull);
        },
      );

      test(
        'should handle clearEmailError and clearPasswordError flags correctly',
        () {
          // Set errors first
          loginViewModel.emailController.text = 'invalid-email';
          loginViewModel.passwordController.text = '123';
          loginViewModel.loginIntent(LoginIntent.validateEmail);
          loginViewModel.loginIntent(LoginIntent.validatePassword);

          // Verify errors exist
          expect(loginViewModel.state.emailError, isNotNull);
          expect(loginViewModel.state.passwordError, isNotNull);

          // Clear using the clear flags
          loginViewModel.loginIntent(LoginIntent.clearValidationErrors);

          // Verify errors are cleared
          expect(loginViewModel.state.emailError, isNull);
          expect(loginViewModel.state.passwordError, isNull);
        },
      );
    });

    group('State Management with Clear Flags', () {
      test('should use clearEmailError flag correctly', () {
        // Set email error
        loginViewModel.emailController.text = 'invalid-email';
        loginViewModel.loginIntent(LoginIntent.validateEmail);
        expect(loginViewModel.state.emailError, isNotNull);

        // Clear only email error
        final newState = loginViewModel.state.copyWith(clearEmailError: true);
        expect(newState.emailError, isNull);
      });

      test('should use clearPasswordError flag correctly', () {
        // Set password error
        loginViewModel.passwordController.text = '123';
        loginViewModel.loginIntent(LoginIntent.validatePassword);
        expect(loginViewModel.state.passwordError, isNotNull);

        // Clear only password error
        final newState = loginViewModel.state.copyWith(
          clearPasswordError: true,
        );
        expect(newState.passwordError, isNull);
      });

      test('should use both clear flags together', () {
        loginViewModel.emailController.text = 'invalid-email';
        loginViewModel.passwordController.text = '123';
        loginViewModel.loginIntent(LoginIntent.validateEmail);
        loginViewModel.loginIntent(LoginIntent.validatePassword);

        expect(loginViewModel.state.emailError, isNotNull);
        expect(loginViewModel.state.passwordError, isNotNull);

        // Clear both errors
        final newState = loginViewModel.state.copyWith(
          clearEmailError: true,
          clearPasswordError: true,
        );

        expect(newState.emailError, isNull);
        expect(newState.passwordError, isNull);
      });
    });

    group('should dispose', () {
      test('should dispose controllers when closed', () {
        final viewModel = LoginViewModel(mockLoginUseCase);
        viewModel.emailController.text = 'test';
        viewModel.passwordController.text = 'test';
        expect(() => viewModel.close(), returnsNormally);
      });
    });
  });
}
