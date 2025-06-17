// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'تطبيق اللياقة';

  @override
  String get hello => 'مرحبًا';

  @override
  String get welcome => 'مرحبًا بك في تطبيق اللياقة';

  @override
  String get networkError => 'لا يوجد اتصال بالإنترنت. يرجى التحقق من الشبكة والمحاولة مرة أخرى.';

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
  String get registrationSubtitle5 => 'أخبرنا بما ترغب في تحقيقه';

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
  String get goalGetFitter => 'أن تصبح أكثر لياقة';

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
  String get activityTrueBeast => 'محترف حقيقي';

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
}
