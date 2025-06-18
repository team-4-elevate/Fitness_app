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
  String get networkError => 'لا يوجد اتصال بالإنترنت. يرجى التحقق من شبكتك والمحاولة مرة أخرى.';

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
  String get socketException => 'مشكلة في الاتصال بالخادم. يرجى التحقق من الإنترنت.';

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
  String get login_heyThere => 'أهلاً بك';

  @override
  String get login_welcomeBack => 'مرحباً بعودتك';

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
  String get login_register => ' سجل الآن';

  @override
  String get login_socialTitle => 'تسجيل الدخول الاجتماعي';

  @override
  String get login_socialMessage => 'تسجيل الدخول عبر الشبكات الاجتماعية غير متاح حالياً.';

  @override
  String get login_socialButton => 'حسناً، فهمت';

  @override
  String get login_successTitle => 'تم تسجيل الدخول';

  @override
  String login_successMessage(String user) {
    return 'مرحباً بعودتك، $user!';
  }

  @override
  String get login_failedTitle => 'فشل تسجيل الدخول';

  @override
  String login_failedMessage(String error) {
    return '$error';
  }

  @override
  String get login_failedButton => 'حسناً، فهمت';

  @override
  String get registerSuccess => 'تم التسجيل بنجاح!';

  @override
  String get next => 'التالي';

  @override
  String get finish => 'إنهاء';

  @override
  String get registrationTitle1 => 'أخبرنا عن نفسك!';

  @override
  String get registrationSubtitle1 => 'نحتاج إلى معرفة جنسك';

  @override
  String get registrationTitle2 => 'كم عمرك؟';

  @override
  String get registrationSubtitle2 => 'سيساعدنا ذلك في إعداد خطة مخصصة لك';

  @override
  String get registrationTitle3 => 'ما هو وزنك؟';

  @override
  String get registrationSubtitle3 => 'نستخدم هذا لحساب السعرات الحرارية';

  @override
  String get registrationTitle4 => 'ما هو طولك؟';

  @override
  String get registrationSubtitle4 => 'سيساعدنا ذلك في حساب مؤشر كتلة الجسم';

  @override
  String get registrationTitle5 => 'ما هو هدفك؟';

  @override
  String get registrationSubtitle5 => 'أخبرنا بما تريد تحقيقه';

  @override
  String get registrationTitle6 => 'ما مدى نشاطك؟';

  @override
  String get registrationSubtitle6 => 'يساعدنا مستوى نشاطك في تحديد أهدافك';

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
  String get goalGetFitter => 'تحسين اللياقة';

  @override
  String get goalGainFlexibility => 'زيادة المرونة';

  @override
  String get goalLearnBasics => 'تعلم الأساسيات';

  @override
  String get activityRookie => 'مبتدئ جداً';

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
  String get lastName => 'الاسم الأخير';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get passwordRequired => 'كلمة المرور مطلوبة';

  @override
  String get registerGreeting => 'مرحباً بك';

  @override
  String get createAccount => 'إنشاء حساب';

  @override
  String get register => 'تسجيل';
}
