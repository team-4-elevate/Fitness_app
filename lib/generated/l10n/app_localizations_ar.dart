// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'تطبيق اللياقة البدنية';

  @override
  String get hello => 'مرحبا';

  @override
  String get welcome => 'مرحبا بك في تطبيق اللياقة البدنية';

  @override
  String get networkError =>
      'لا يوجد اتصال بالإنترنت. يرجى التحقق من شبكتك والمحاولة مرة أخرى.';

  @override
  String get serverError => 'خطأ في الخادم. يرجى المحاولة لاحقاً.';

  @override
  String get unknownError => 'حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.';

  @override
  String get timeout => 'انتهت مدة الانتظار. يرجى المحاولة مرة أخرى.';

  @override
  String get unauthorized => 'فشل تسجيل الدخول. يرجى المحاولة مرة أخرى.';

  @override
  String get forbidden => 'لا تملك صلاحية الوصول.';

  @override
  String get notFound => 'لم يتم العثور على البيانات المطلوبة.';

  @override
  String get validationError => 'البيانات المدخلة غير صحيحة.';

  @override
  String get badRequest => 'طلب غير صحيح.';

  @override
  String get requestCancelled => 'تم إلغاء الطلب.';

  @override
  String get connectionError => 'خطأ في الاتصال بالشبكة.';

  @override
  String get socketException =>
      'مشكلة في الاتصال بالخادم. يرجى التحقق من الإنترنت.';

  @override
  String get formatException => 'تعذر قراءة البيانات المستلمة.';

  @override
  String errorWithMessage(String message) {
    return 'حدث خطأ: $message';
  }

  @override
  String errorWithStatusCode(String status) {
    return 'حدث خطأ (كود: $status).';
  }

  @override
  String get skip => 'Skip';

  @override
  String get next => 'Next';

  @override
  String get back => 'Back';

  @override
  String get doIt => 'Do IT';

  @override
  String get onBoardingTitle1 => 'The Price Of Excellence\n is Discipline';

  @override
  String get onBoardingDesc1 =>
      'Lorem ipsum dolor sit amet consectetur. Eu urna ut gravida quis id pretium purus. Mauris massa';

  @override
  String get onBoardingTitle2 => 'Fitness Has Never Been So\n Much Fun';

  @override
  String get onBoardingDesc2 =>
      'Lorem ipsum dolor sit amet consectetur. Eu urna ut gravida quis id pretium purus. Mauris massa';

  @override
  String get onBoardingTitle3 => 'NO MORE EXCUSES\n Do It Now';

  @override
  String get onBoardingDesc3 =>
      'Lorem ipsum dolor sit amet consectetur. Eu urna ut gravida quis id pretium purus. Mauris massa';
}
