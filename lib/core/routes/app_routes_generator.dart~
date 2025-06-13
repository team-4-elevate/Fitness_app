import 'package:flutter/material.dart';
import 'package:online_exam_app/Features/auth/presentation/pages/forgot_passowrd/forgot_password_page.dart';
import 'package:online_exam_app/Features/auth/presentation/pages/login/login_page.dart';
import 'package:online_exam_app/Features/auth/presentation/pages/otp_page/otp_verification_page.dart';
import 'package:online_exam_app/Features/auth/presentation/pages/reset_passowrod/reset_password_page.dart';
import 'package:online_exam_app/Features/auth/presentation/pages/signup/sign_up_page.dart';
import 'package:online_exam_app/Features/exams/presentation/pages/exam_score_screen.dart';
import 'package:online_exam_app/Features/exams/presentation/pages/exam_screen.dart';
import 'package:online_exam_app/Features/home/presentation/pages/layout_screen.dart';
import 'package:online_exam_app/Features/exams/presentation/pages/exams_on_subject_screen.dart';
import 'package:online_exam_app/Features/user_profile/presentation/pages/change_password_page.dart';
import 'package:online_exam_app/Features/user_profile/presentation/pages/profile_page.dart';
import 'package:online_exam_app/Features/user_results/presentation/pages/answers_view.dart';
import 'package:online_exam_app/Features/user_results/presentation/pages/result_page.dart';
import 'package:online_exam_app/core/routes/app_routes.dart';
import '../../Features/exams/presentation/pages/instructions_screen.dart';
import '../../Features/home/presentation/pages/home_screen.dart';
import '../../main.dart';

class AppRoutesGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.loginPage:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case AppRoutes.signUpPage:
        return MaterialPageRoute(
          builder: (_) => const SignUpPage(),
        );
      case AppRoutes.forgotPass:
        return MaterialPageRoute(
          builder: (_) => ForgotPasswordPage(),
        );
      case AppRoutes.layoutScreen:
        return MaterialPageRoute(builder: (_) => const LayoutScreen());
      case AppRoutes.otpPage:
        return MaterialPageRoute(
          builder: (_) => OtpVerificationPage(),
        );
      case AppRoutes.resetPasswordPage:
        return MaterialPageRoute(
          builder: (_) => const ResetPasswordPage(),
        );
      case AppRoutes.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRoutes.profilePage:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case AppRoutes.resultPage:
        return MaterialPageRoute(builder: (_) => const ResultPage());
      case AppRoutes.subjectDetails:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ExamsOnSubjectScreen());
      case AppRoutes.resultAnswersPage:
        return MaterialPageRoute(
          builder: (_) => const AnswersView(),
        );
      case AppRoutes.instructionsScreen:
        return MaterialPageRoute(
          // settings: settings,
          builder: (_) => ExamInstructionsScreen(),
        );
      case AppRoutes.examScreen:
        return MaterialPageRoute(
          // settings: settings,
          builder: (_) => const ExamScreen(),
        );
      case AppRoutes.examScoreScreen:
        return MaterialPageRoute(
          builder: (_) => const ExamScoreScreen(),
        );
      case AppRoutes.changePasswordScreen:
        return MaterialPageRoute(
          builder: (_) => const ChangePasswordPage(),
        );
      default:
        return
         token == null? MaterialPageRoute(builder: (_) => const LoginPage()):
          MaterialPageRoute(builder: (_) => const LayoutScreen());
    }
  }
}
