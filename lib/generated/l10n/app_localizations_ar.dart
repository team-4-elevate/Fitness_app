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
  String get welcome => 'مرحباً بك في تطبيق اللياقة البدنية';

  @override
  String get networkError =>
      'لا يوجد اتصال بالإنترنت. يرجى التحقق من الشبكة والمحاولة مرة أخرى.';

  @override
  String get serverError => 'خطأ في الخادم. يرجى المحاولة مرة أخرى لاحقاً.';

  @override
  String get unknownError => 'حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.';

  @override
  String get timeout => 'انتهت مهلة الاتصال. يرجى المحاولة مرة أخرى.';

  @override
  String get unauthorized => 'فشل تسجيل الدخول. يرجى المحاولة مرة أخرى.';

  @override
  String get forbidden => 'ليس لديك إذن للوصول.';

  @override
  String get notFound => 'البيانات المطلوبة غير موجودة.';

  @override
  String get validationError => 'البيانات المقدمة غير صحيحة.';

  @override
  String get badRequest => 'طلب غير صحيح.';

  @override
  String get requestCancelled => 'تم إلغاء الطلب.';

  @override
  String get connectionError => 'خطأ في الاتصال. يرجى التحقق من الشبكة.';

  @override
  String get socketException => 'مشكلة في الاتصال. يرجى التحقق من الإنترنت.';

  @override
  String get formatException => 'لا يمكن قراءة البيانات المستلمة.';

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
  String get onBoardingTitle1 => 'ثمن التميز\nهو الانضباط';

  @override
  String get onBoardingDesc1 =>
      'ابدأ رحلتك نحو اللياقة والصحة مع أفضل التمارين والبرامج المصممة خصيصاً لك';

  @override
  String get onBoardingTitle2 => 'اللياقة البدنية لم تكن\nممتعة هكذا من قبل';

  @override
  String get onBoardingDesc2 =>
      'اكتشف طرق جديدة ومثيرة للحفاظ على لياقتك البدنية مع تمارين متنوعة ومسلية';

  @override
  String get onBoardingTitle3 => 'لا مزيد من الأعذار\nافعلها الآن';

  @override
  String get onBoardingDesc3 =>
      'حان الوقت لتحقيق أهدافك في اللياقة البدنية، ابدأ اليوم ولا تؤجل أحلامك';

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
  String get login_forgotPassword => 'نسيت كلمة المرور؟';

  @override
  String get login_orDivider => 'أو';

  @override
  String get login_noAccount => 'ليس لديك حساب؟';

  @override
  String get login_register => ' إنشاء حساب';

  @override
  String get login_socialTitle => 'تسجيل الدخول الاجتماعي';

  @override
  String get login_socialMessage => 'تسجيل الدخول الاجتماعي غير متاح حالياً.';

  @override
  String get login_socialButton => 'حسناً، فهمت';

  @override
  String get login_successTitle => 'تم تسجيل الدخول بنجاح';

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
  String get registerSuccess => 'تم إنشاء الحساب بنجاح!';

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
  String get registrationSubtitle2 => 'هذا يساعدنا في إنشاء خطتك الشخصية';

  @override
  String get registrationTitle3 => 'ما هو وزنك؟';

  @override
  String get registrationSubtitle3 => 'نستخدم هذا لحساب السعرات الحرارية';

  @override
  String data_parse_error_upcoming_workouts(String error) {
    return 'فشل في تحليل التمارين القادمة: $error';
  }

  @override
  String data_parse_error_food_recommendations(String error) {
    return 'فشل في تحليل توصيات الطعام: $error';
  }

  @override
  String data_network_error(String error) {
    return 'خطأ في الشبكة: $error';
  }

  @override
  String domain_error_loading_data(String message) {
    return 'خطأ في تحميل البيانات: $message';
  }

  @override
  String get dailyToRecommendations => 'التوصيات اليومية';

  @override
  String get home_upcoming_workouts => 'التمارين القادمة';

  @override
  String get home_recommendations_for_you => 'توصيات لك';

  @override
  String get home_popular_training => 'التمارين الشائعة';

  @override
  String get home_see_all => 'عرض الكل';

  @override
  String home_error_upcoming_workouts(String error) {
    return 'خطأ في تحميل التمارين القادمة: $error';
  }

  @override
  String home_error_loading_upcoming_workouts(String error) {
    return 'Error loading upcoming workouts: $error';
  }

  @override
  String home_error_food_recommendations(String error) {
    return 'خطأ في تحميل توصيات الطعام: $error';
  }

  @override
  String home_error_loading_food_recommendations(String error) {
    return 'Error loading food recommendations: $error';
  }

  @override
  String home_error_loading_daily_recommendations(String error) {
    return 'Error loading daily recommendations: $error';
  }

  @override
  String get failed_to_parse_upcoming_workouts =>
      'فشل في تحليل التمارين القادمة: ';

  @override
  String get let_s_start_your_day => 'لنبدأ يومك';

  @override
  String get category_gym => 'صالة الألعاب';

  @override
  String get category_fitness => 'لياقة بدنية';

  @override
  String get category_yoga => 'يوغا';

  @override
  String get category_aerobics => 'إيروبكس';

  @override
  String get category_trainer => 'مدرب';

  @override
  String get workout_category_full_body => 'كامل الجسم';

  @override
  String get workout_category_chest => 'الصدر';

  @override
  String get workout_category_arm => 'الذراع';

  @override
  String get workout_category_leg => 'الساق';

  @override
  String get registrationTitle4 => 'ما هو طولك؟';

  @override
  String get registrationSubtitle4 => 'هذا يساعدنا في حساب مؤشر كتلة الجسم';

  @override
  String get registrationTitle5 => 'ما هو هدفك؟';

  @override
  String get registrationSubtitle5 => 'أخبرنا ما تريد تحقيقه';

  @override
  String get registrationTitle6 => 'ما مدى نشاطك؟';

  @override
  String get registrationSubtitle6 => 'مستوى نشاطك يساعدنا في تحديد الأهداف';

  @override
  String get year => 'سنة';

  @override
  String get kg => 'كغ';

  @override
  String get cm => 'سم';

  @override
  String get male => 'ذكر';

  @override
  String get female => 'أنثى';

  @override
  String get goalGainWeight => 'زيادة الوزن';

  @override
  String get goalLoseWeight => 'إنقاص الوزن';

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
  String get lastName => 'اسم العائلة';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get passwordRequired => 'كلمة المرور مطلوبة';

  @override
  String get registerGreeting => 'أهلاً وسهلاً';

  @override
  String get createAccount => 'إنشاء حساب';

  @override
  String get register => 'إنشاء حساب';

  @override
  String get alreadyHaveAnAccount => 'لديك حساب بالفعل؟';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get food_Recommendation_title => 'توصيات الطعام';

  @override
  String get food_Recommendation_no_categories => 'لا توجد فئات';

  @override
  String get food_food_Recommendation_fail_to_loadCategories =>
      'فشل في تحميل الفئات';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get confirmPassword => 'يرجى تأكيد كلمة المرور';

  @override
  String get passwordsDoNotMatch => 'كلمات المرور غير متطابقة';

  @override
  String get enterFourDigitCode => 'يرجى إدخال الرمز المكون من 4 أرقام';

  @override
  String get confirm => 'تأكيد';

  @override
  String get enterYourOtp => 'أدخل رمز التحقق';

  @override
  String get checkYourEmail => 'تحقق من بريدك الإلكتروني';

  @override
  String get otpCode => 'رمز التحقق';

  @override
  String get forgetPassword => 'نسيت كلمة المرور';

  @override
  String get enterYourEmail => 'أدخل بريدك الإلكتروني';

  @override
  String get sendOtp => 'إرسال رمز التحقق';

  @override
  String get didntReceiveVerificationCode => 'لم تستلم رمز التحقق؟';

  @override
  String get resend => 'إعادة الإرسال';

  @override
  String get video_not_available => 'الفيديو غير متاح';

  @override
  String get exercise => 'تمرين';

  @override
  String get no_exercises_found => 'لم يتم العثور على تمارين';

  @override
  String failed_to_load_exercises(Object error) {
    return 'فشل في تحميل التمارين: $error';
  }

  @override
  String get motivational_quote => 'اقتباس تحفيزي';

  @override
  String get enter_old_new_passwords => 'أدخل كلمات المرور القديمة والجديدة';

  @override
  String get update_password => 'تحديث كلمة المرور';

  @override
  String get password_updated_successfully => 'تم تحديث كلمة المرور بنجاح';

  @override
  String get current_password => 'كلمة المرور الحالية';

  @override
  String get new_password => 'كلمة المرور الجديدة';

  @override
  String get confirm_new_password => 'تأكيد كلمة المرور الجديدة';

  @override
  String get please_confirm_password => 'يرجى تأكيد كلمة المرور';

  @override
  String get passwords_do_not_match => 'كلمات المرور غير متطابقة';

  @override
  String get profile_title => 'الملف الشخصي';

  @override
  String get edit_profile => 'تعديل الملف الشخصي';

  @override
  String get change_password => 'تغيير كلمة المرور';

  @override
  String get settings => 'الإعدادات';

  @override
  String get language => 'اللغة';

  @override
  String get notification => 'الإشعارات';

  @override
  String get privacy => 'الخصوصية';

  @override
  String get help => 'المساعدة';

  @override
  String get about => 'حول التطبيق';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String selectedLanguageValue(String lang) {
    return 'اللغة المحددة ($lang)';
  }

  @override
  String get logout_confirmation_title => 'تسجيل الخروج';

  @override
  String get logout_message_body => 'اتريد تسجيل الخروج من حسابك؟';

  @override
  String get cancel => 'الغاء';
}
