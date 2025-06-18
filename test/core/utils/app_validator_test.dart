// test/core/utils/app_validator_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:fitness_app/core/utils/app_validator.dart';

void main() {
  group('AppValidators', () {
    //-----------------validateEmail-----------------
    group('validateEmail', () {
      ///empty email
      test('should return error message when email is empty', () {
        //// Arrange
        const email = '';

        //// Act
        final result = AppValidators.validateEmail(email);

        //// Assert
        expect(result, 'Email is required');
      });

      ///invalid email format
      test('should return error message when email format is invalid', () {
        //// Arrange
        const email = 'invalid_email';

        //// Act
        final result = AppValidators.validateEmail(email);

        //// Assert
        expect(result, 'Invalid email format');
      });

      test('should return null when email is valid', () {
        //// Arrange
        const email = 'test@example.com';

        //// Act
        final result = AppValidators.validateEmail(email);

        //// Assert
        expect(result, null);
      });
    });

    //-----------------validatePassword-----------------
    group('validatePassword', () {
      ///empty password
      test('should return error message when password is empty', () {
        //// Arrange
        const password = '';

        //// Act
        final result = AppValidators.validatePassword(password);

        //// Assert
        expect(result, 'Password is required');
      });

      ///invalid password format
      test('should return null when password meets all requirements', () {
        //// Arrange
        const password = 'Test@123';

        //// Act
        final result = AppValidators.validatePassword(password);

        //// Assert
        expect(result, null);
      });

      ///password does not meet requirements
      test('should return error message when password is too short', () {
        //// Arrange
        const password = 'Test@1';

        //// Act
        final result = AppValidators.validatePassword(password);

        //// Assert
        expect(result, contains('minimum 8 characters'));
      });

      ///password does not contain special character
      test(
        'should return error message when password lacks uppercase letter',
        () {
          //// Arrange
          const password = 'test@123';

          //// Act
          final result = AppValidators.validatePassword(password);

          //// Assert
          expect(result, contains('at least one uppercase letter'));
        },
      );
    });

    //-----------------validatePasswordWithStrength-----------------
    group('validatePasswordWithStrength', () {
      ///empty password
      test(
        'should return error message and strength 0 when password is empty',
        () {
          //// Arrange
          const password = '';

          //// Act
          final (error, strength) = AppValidators.validatePasswordWithStrength(
            password,
          );

          //// Assert
          expect(error, 'Password is required');
          expect(strength, 0);
        },
      );

      ///invalid password format
      test('should return null and high strength when password is strong', () {
        //// Arrange
        const password = 'StrongP@ss123';

        //// Act
        final (error, strength) = AppValidators.validatePasswordWithStrength(
          password,
        );

        //// Assert
        expect(error, null);
        expect(strength, greaterThan(3));
      });
    });

    //-----------------validateFirstName and validateLastName-----------------
    group('validateFirstName and validateLastName', () {
      ///empty first name
      test('should return error when first name is empty', () {
        //// Arrange
        const firstName = '';

        //// Act
        final result = AppValidators.validateFirstName(firstName);

        //// Assert
        expect(result, 'First name is required.');
      });

      /// empty last name
      test('should return error when last name is empty', () {
        //// Arrange
        const lastName = '';

        //// Act
        final result = AppValidators.validateLastName(lastName);

        //// Assert
        expect(result, 'Last name is required.');
      });

      ///valid first name
      test('should return error when name contains invalid characters', () {
        //// Arrange
        const name = 'Name123';

        //// Act
        final firstNameResult = AppValidators.validateFirstName(name);
        final lastNameResult = AppValidators.validateLastName(name);

        //// Assert
        expect(
          firstNameResult,
          'First name can only contain letters and spaces.',
        );
        expect(
          lastNameResult,
          'Last name can only contain letters and spaces.',
        );
      });
    });
  });
}
