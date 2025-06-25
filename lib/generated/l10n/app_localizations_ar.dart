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
  String get hello => 'مرحبًا';

  @override
  String get welcome => 'مرحبًا بك في تطبيق اللياقة البدنية';

  @override
  String get networkError =>
      'لا يوجد اتصال بالإنترنت. يرجى التحقق من الشبكة والمحاولة مرة أخرى.';

  @override
  String get serverError => 'خطأ في الخادم. يرجى المحاولة لاحقًا.';

  @override
  String get unknownError => 'حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.';

  @override
  String get timeout => 'انتهت مهلة الاتصال. يرجى المحاولة مرة أخرى.';

  @override
  String get unauthorized => 'فشل تسجيل الدخول. يرجى المحاولة مرة أخرى.';

  @override
  String get forbidden => 'ليس لديك إذن للوصول.';

  @override
  String get notFound => 'لم يتم العثور على البيانات المطلوبة.';

  @override
  String get validationError => 'البيانات المقدمة غير صالحة.';

  @override
  String get badRequest => 'طلب غير صالح.';

  @override
  String get requestCancelled => 'تم إلغاء الطلب.';

  @override
  String get connectionError => 'خطأ في الاتصال. يرجى التحقق من الشبكة.';

  @override
  String get socketException => 'مشكلة في الاتصال. يرجى التحقق من الإنترنت.';

  @override
  String get formatException => 'تعذر قراءة البيانات المستلمة.';

  @override
  String errorWithMessage(String message) {
    return 'حدث خطأ: $message';
  }

  @override
  String errorWithStatusCode(String status) {
    return 'حدث خطأ (الرمز: $status).';
  }

  @override
  String get skip => 'تخطي';

  @override
  String get back => 'رجوع';

  @override
  String get doIt => 'لنبدأ';

  @override
  String get onBoardingTitle1 => 'مرحبًا بك في تطبيق اللياقة البدنية';

  @override
  String get onBoardingDesc1 =>
      'هذا التطبيق مصمم لمساعدتك في تحقيق أهداف لياقتك البدنية.';

  @override
  String get onBoardingTitle2 => 'تخصيص تجربتك';

  @override
  String get onBoardingDesc2 =>
      'أخبرنا عن أهدافك ومستوى لياقتك لنقدم لك خطة مخصصة.';

  @override
  String get onBoardingTitle3 => 'ابدأ رحلتك';

  @override
  String get onBoardingDesc3 => 'دعنا نبدأ رحلتك نحو حياة أكثر صحة ولياقة.';

  @override
  String get login_heyThere => 'مرحبًا بك';

  @override
  String get login_welcomeBack => 'مرحبًا بعودتك';

  @override
  String get login_title => 'تسجيل الدخول';

  @override
  String get login_emailLabel => 'البريد الإلكتروني';

  @override
  String get login_emailHint => 'أدخل بريدك الإلكتروني';

  @override
  String get login_passwordLabel => 'كلمة المرور';

  @override
  String get login_passwordHint => 'أدخل كلمة المرور';

  @override
  String get login_forgotPassword => 'هل نسيت كلمة المرور؟';

  @override
  String get login_orDivider => 'أو';

  @override
  String get login_noAccount => 'ليس لديك حساب؟';

  @override
  String get login_register => ' سجل';

  @override
  String get login_socialTitle => 'تسجيل الدخول الاجتماعي';

  @override
  String get login_socialMessage => 'تسجيل الدخول الاجتماعي غير متوفر بعد.';

  @override
  String get login_socialButton => 'حسنًا فهمت';

  @override
  String get login_successTitle => 'تم تسجيل الدخول بنجاح';

  @override
  String login_successMessage(String user) {
    return 'مرحبًا بعودتك، $user!';
  }

  @override
  String get login_failedTitle => 'فشل تسجيل الدخول';

  @override
  String login_failedMessage(String error) {
    return '$error';
  }

  @override
  String get login_failedButton => 'حسنًا فهمت';

  @override
  String get registerSuccess => 'تم التسجيل بنجاح!';

  @override
  String get next => 'التالي';

  @override
  String get finish => 'إنهاء';

  @override
  String get registrationTitle1 => 'أخبرنا عن نفسك!';

  @override
  String get registrationSubtitle1 => 'نحتاج لمعرفة جنسك';

  @override
  String get registrationTitle2 => 'كم عمرك؟';

  @override
  String get registrationSubtitle2 => 'يساعدنا هذا في إنشاء خطتك الشخصية';

  @override
  String get registrationTitle3 => 'ما هو وزنك؟';

  @override
  String get registrationSubtitle3 => 'نستخدم هذا لحساب السعرات الحرارية';

  @override
  String get registrationTitle4 => 'ما هو طولك؟';

  @override
  String get registrationSubtitle4 => 'يساعدنا هذا في حساب مؤشر كتلة الجسم';

  @override
  String get registrationTitle5 => 'ما هو هدفك؟';

  @override
  String get registrationSubtitle5 => 'أخبرنا بما تريد تحقيقه';

  @override
  String get registrationTitle6 => 'ما مدى نشاطك؟';

  @override
  String get registrationSubtitle6 => 'مستوى نشاطك يساعدنا في تحديد الأهداف';

  @override
  String get year => 'سنة';

  @override
  String get kg => 'كجم';

  @override
  String get cm => 'سم';

  @override
  String get male => 'ذكر';

  @override
  String get female => 'أنثى';

  @override
  String get goalGainWeight => 'زيادة الوزن';

  @override
  String get goalLoseWeight => 'فقدان الوزن';

  @override
  String get goalGetFitter => 'أن أصبح أكثر لياقة';

  @override
  String get goalGainFlexibility => 'زيادة المرونة';

  @override
  String get goalLearnBasics => 'تعلم الأساسيات';

  @override
  String get activityRookie => 'مبتدئ';

  @override
  String get activityBeginner => 'مبتدئ';

  @override
  String get activityIntermediate => 'متوسط';

  @override
  String get activityAdvanced => 'متقدم';

  @override
  String get activityTrueBeast => 'محترف';

  @override
  String get firstName => 'الاسم الأول';

  @override
  String get lastName => 'اسم العائلة';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get passwordRequired => 'كلمة المرور مطلوبة';

  @override
  String get registerGreeting => 'مرحبًا بك';

  @override
  String get createAccount => 'إنشاء حساب';

  @override
  String get register => 'تسجيل';

  @override
  String get alreadyHaveAnAccount => 'هل لديك حساب بالفعل؟';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get food_Recommendation_title => 'اقتراحات للاكل';

  @override
  String get food_Recommendation_no_categories => 'لايوجد بيانات';

  @override
  String get food_food_Recommendation_fail_to_loadCategories =>
      'خطأ في تحميل الاصناف';

  @override
  String get retry => 'حاول مره اخري';

  @override
  String get confirmPassword => 'يرجى تأكيد كلمة المرور';

  @override
  String get passwordsDoNotMatch => 'كلمات المرور غير متطابقة';

  @override
  String get enterFourDigitCode => 'يرجى إدخال رمز مكون من 4 أرقام';

  @override
  String get confirm => 'تأكيد';

  @override
  String get enterYourOtp => 'أدخل رمز التحقق';

  @override
  String get checkYourEmail => 'تحقق من بريدك الإلكتروني';

  @override
  String get otpCode => 'رمز التحقق';

  @override
  String get forgetPassword => 'نسيان كلمة المرور';

  @override
  String get enterYourEmail => 'أدخل بريدك الإلكتروني';

  @override
  String get sendOtp => 'إرسال رمز التحقق';

  @override
  String get didntReceiveVerificationCode => 'لم تستلم رمز التحقق؟';

  @override
  String get resend => 'اعادة الارسال';

  @override
  String get exercise => 'تمرين';

  @override
  String get motivational_quote =>
      'كل قطرة عرق هي صوت للحياة التي لم تعشها بعد.';

  @override
  String get no_exercises_found => 'لم يتم العثور على تمارين';

  @override
  String get failed_to_load_exercises => 'فشل في تحميل التمارين';

  @override
  String get video_not_available =>
      'الفيديو غير متاح، يرجى المحاولة مرة أخرى لاحقاً';
}
