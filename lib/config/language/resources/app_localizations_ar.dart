// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get login_header => 'تسجيل الدخول إلى الحساب';

  @override
  String get login_header2 => 'يرجى تسجيل الدخول إلى حسابك';

  @override
  String get signIn => 'تسجيل الدخول';

  @override
  String get userName => 'اسم المستخدم';

  @override
  String get userNameValidationMsg0 => 'يرجى إدخال اسم المستخدم';

  @override
  String get userNameHint => 'أدخل اسم المستخدم';

  @override
  String get password => 'كلمة المرور';

  @override
  String get passwordHint => 'أدخل كلمة المرور';

  @override
  String get passWordValidationMsg0 => 'يرجى إدخال كلمة المرور';

  @override
  String get passWordValidationMsg1 =>
      'يجب أن تكون كلمة المرور على الأقل 6 أحرف';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get count => 'العدد';

  @override
  String get none => 'لا شيء';

  @override
  String get discount => 'خصم';

  @override
  String greeting(Object username) {
    return 'مرحبًا، $username';
  }

  @override
  String get sub_greeting => 'ابدأ تسوقك بكل متعة!';

  @override
  String get search => 'بحث';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get section_brands => 'العلامات التجارية';

  @override
  String get section_new_arrivals => 'وصل حديثًا 🔥';

  @override
  String get section_categories => 'الفئات';

  @override
  String get all_products => 'كل المنتجات';

  @override
  String get see_all => 'عرض الكل';

  @override
  String get my_cart => 'سلة التسوق';

  @override
  String get summary => 'الملخص';

  @override
  String get select_all => 'تحديد الكل';

  @override
  String get delete => 'حذف';

  @override
  String get tva => 'الضريبة';

  @override
  String get total_ht_amount => 'المجموع بدون ضريبة';

  @override
  String get total_ttc_amount => 'المجموع مع الضريبة';

  @override
  String checkout_button(Object count) {
    return 'الدفع ($count)';
  }

  @override
  String get payment => 'الدفع';

  @override
  String get client => 'العميل';

  @override
  String get edit => 'تعديل';

  @override
  String get full_name => 'الاسم الكامل';

  @override
  String get phone_mobile => 'الهاتف / الجوال';

  @override
  String get fax => 'الفاكس';

  @override
  String items(Object count) {
    return 'العناصر ($count)';
  }

  @override
  String get quantity => 'الكمية';

  @override
  String get checkout => 'الدفع';

  @override
  String get myOrders => 'طلباتي';

  @override
  String get status => 'الحالة';

  @override
  String get deliverTo => 'تسليم إلى';

  @override
  String get note => 'ملاحظة';

  @override
  String get totalAmount => 'المبلغ الإجمالي';

  @override
  String get viewDetails => 'عرض التفاصيل';

  @override
  String get onGoing => 'قيد التنفيذ';

  @override
  String get history => 'السجل';

  @override
  String get noReference => 'لا توجد مرجعية بعد';

  @override
  String get orderDetails => 'تفاصيل الطلب';

  @override
  String get orderRef => 'مرجع الطلب';

  @override
  String get orderNote => 'ملاحظة الطلب';

  @override
  String get orderItemNote => 'ملاحظة عنصر الطلب';

  @override
  String get orderItems => 'عناصر الطلب';

  @override
  String get shippingAddress => 'عنوان الشحن';

  @override
  String get orderSummary => 'ملخص الطلب';

  @override
  String get paymentMethod => 'طريقة الدفع';

  @override
  String get paymentMethodElectronicBanking => 'الدفع الإلكتروني';

  @override
  String get currencyAbbreviation => 'د.ج';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get accountSettings => 'إعدادات الحساب';

  @override
  String get preferences => 'التفضيلات';

  @override
  String get changePassword => 'تغيير كلمة المرور';

  @override
  String get language => 'اللغة';

  @override
  String get legalAndPolicies => 'القوانين والسياسات';

  @override
  String get helpAndSupport => 'المساعدة والدعم';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get changePasswordDescription =>
      'الرجاء إدخال كلمة المرور الحالية والجديدة لتغيير كلمة المرور';

  @override
  String get currentPassword => 'كلمة المرور الحالية';

  @override
  String get newPassword => 'كلمة المرور الجديدة';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get resetPassword => 'إعادة تعيين كلمة المرور';

  @override
  String get showLess => 'عرض أقل';

  @override
  String get showMore => 'عرض المزيد';

  @override
  String get noAdditionalNotes => 'لا توجد ملاحظات إضافية لهذا العنصر.';

  @override
  String get gotIt => 'فهمت';

  @override
  String get tack_order => 'تتبع الطلب';

  @override
  String get noSearchHistory => 'لا يوجد سجل بحث';

  @override
  String get searchHistory => 'سجل البحث';

  @override
  String get clearAll => 'مسح الكل';

  @override
  String get popularSearches => 'عمليات البحث الشائعة';

  @override
  String get searchHint => 'ابحث...';

  @override
  String get filters => 'فلاتر';

  @override
  String get reset => 'إعادة تعيين';

  @override
  String get apply => 'تطبيق';

  @override
  String get isService => 'خدمة';

  @override
  String get select_brand => 'اختر العلامة التجارية';

  @override
  String get select_category => 'اختر الفئة';

  @override
  String get all_brands => 'جميع العلامات التجارية';

  @override
  String get all_categories => 'جميع الفئات';

  @override
  String get price_range => 'نطاق السعر';

  @override
  String get min => 'الحد الأدنى';

  @override
  String get max => 'الحد الأقصى';

  @override
  String get order_success_title => 'تم الطلب بنجاح';

  @override
  String get order_success_description =>
      'سيتم تجهيز طلبك من قبل الموظف وسيصل إلى منزلك خلال 3 إلى 4 أيام';

  @override
  String get order_tracking => 'تتبع الطلب';

  @override
  String get close => 'إغلاق';

  @override
  String get save => 'حفظ';

  @override
  String get home => 'الرئيسية';

  @override
  String get cart => 'السلة';

  @override
  String get enterOrderNotes => 'أدخل أي تعليمات أو ملاحظات لهذا الطلب';

  @override
  String get selectPaymentMethod => 'اختر طريقة الدفع';

  @override
  String get add_cart => 'أضف إلى السلة';

  @override
  String get similar_products => 'منتجات مشابهة';

  @override
  String get option => 'خيار';

  @override
  String get articles => 'الاصناف';

  @override
  String get description => 'الوصف';

  @override
  String get price => 'السعر';

  @override
  String get show_more => 'Show more';

  @override
  String get show_less => 'Show less';

  @override
  String get please_select_article => 'يرجى اختيار منتج';

  @override
  String get article_added_success => 'تمت إضافة المنتج إلى السلة بنجاح';

  @override
  String get article_added_failed => 'فشل في إضافة المنتج إلى السلة';

  @override
  String get please_select_shipping_address => 'يرجى اختيار عنوان الشحن';

  @override
  String get please_select_payment_method => 'يرجى اختيار طريقة الدفع';

  @override
  String get clear_cart => 'إفراغ السلة';

  @override
  String get clear_cart_confirmation => 'هل أنت متأكد أنك تريد إفراغ السلة؟';

  @override
  String get clear => 'إفراغ!';

  @override
  String get cancel => 'إلغاء';

  @override
  String get logoutConfirmation => 'هل أنت متأكد أنك تريد تسجيل الخروج؟';

  @override
  String get logoutAction => 'تسجيل الخروج';

  @override
  String get cancelAction => 'لا';

  @override
  String get changePasswordTitle => 'تغيير كلمة المرور';

  @override
  String get how_we_can_help => 'كيف يمكننا مساعدتك؟';

  @override
  String get topQuestions => 'الأسئلة الشائعة';

  @override
  String get searchPrompt => 'اكتب ما تبحث عنه';

  @override
  String get see_more => 'المزيد';

  @override
  String get updateClientTitle => 'تحديث بيانات العميل';

  @override
  String get updateClientDescription => 'يمكنك إرسال هذا الطلب إلى شخص آخر';

  @override
  String get firstName => 'الاسم الأول';

  @override
  String get lastName => 'الاسم الأخير';

  @override
  String get phone => 'الهاتف';

  @override
  String get mobile => 'الجوال';

  @override
  String get updateClientButton => 'تحديث العميل';

  @override
  String get addressTitle => 'العنوان';

  @override
  String get selectLocation => 'حدد الموقع';

  @override
  String get confirmButton => 'تأكيد';

  @override
  String get updateAddressTitle => 'تحديث تفاصيل العنوان';

  @override
  String get updateAddressDescription =>
      'سيتم استخدام هذا العنوان لتقديم الطلبات';

  @override
  String get addressField => 'العنوان';

  @override
  String get cityField => 'المدينة';

  @override
  String get wilaya => 'الولاية';

  @override
  String get town => 'البلدية';

  @override
  String get position => 'الموقع';

  @override
  String get editAddress => 'تعديل العنوان';

  @override
  String get field_required => 'الحقل ضروري';

  @override
  String get trade_name => 'الاسم التجاري';

  @override
  String get unknown => 'غير معروف';

  @override
  String get no_shipping_address => 'لا يوجد عنوان شحن';

  @override
  String get please_fill_trade_name => 'يرجى إدخال الاسم التجاري';

  @override
  String get please_provide_phone_number => 'يرجى تقديم رقم الهاتف';

  @override
  String get phone_min_length =>
      'يجب أن يحتوي رقم الهاتف على 10 أحرف على الأقل.';

  @override
  String get fax_max_length => 'يجب ألا يتجاوز الفاكس 15 حرفًا.';

  @override
  String get mobile_min_length =>
      'يجب أن يحتوي رقم الجوال على 10 أحرف على الأقل.';

  @override
  String get mobile_max_length => 'يجب ألا يتجاوز رقم الجوال 15 حرفًا.';

  @override
  String get select_language => 'اختر اللغة';

  @override
  String get select_language_description =>
      'اختر اللغة التي تفضل استخدامها في التطبيق.';

  @override
  String get wait_for_approval => 'بانتظار الموافقة';

  @override
  String get wait_for_approval_desc => 'تم تقديم طلبك وهو في انتظار التأكيد.';

  @override
  String get confirmed => 'تم التأكيد';

  @override
  String get confirmed_desc => 'تم تأكيد طلبك ويتم الآن تحضيره.';

  @override
  String get completed => 'اكتمل';

  @override
  String get completed_desc => 'تم تنفيذ وتوصيل طلبك.';

  @override
  String get canceled => 'ملغى';

  @override
  String get canceled_desc => 'تم إلغاء طلبك.';
}
