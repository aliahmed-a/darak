// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'DARAK';

  @override
  String get splashTagline => 'مجمعك السكني، في جيبك';

  @override
  String get commonTryAgain => 'حاول مرة أخرى';

  @override
  String get commonSomethingWentWrong => 'حدث خطأ ما.';

  @override
  String get commonCancel => 'إلغاء';

  @override
  String get commonLoadMore => 'تحميل المزيد';

  @override
  String get commonBack => 'رجوع';

  @override
  String get commonRemove => 'إزالة';

  @override
  String get commonConfirm => 'تأكيد';

  @override
  String get commonOk => 'موافق';

  @override
  String get commonDone => 'تم';

  @override
  String get commonCopy => 'نسخ';

  @override
  String get commonNotSet => 'غير محدد';

  @override
  String get commonActive => 'نشط';

  @override
  String get commonInactive => 'غير نشط';

  @override
  String get commonNothingHereYet => 'لا يوجد شيء هنا بعد.';

  @override
  String get commonSearch => 'بحث';

  @override
  String get commonNoMatches => 'لا توجد نتائج';

  @override
  String get commonDiscard => 'تجاهل';

  @override
  String get commonKeepEditing => 'متابعة التعديل';

  @override
  String get discardChangesTitle => 'تجاهل التغييرات؟';

  @override
  String get discardChangesBody => 'لن يتم حفظ ما أدخلته.';

  @override
  String get validationChooseProperty => 'اختر الوحدة';

  @override
  String propertyFloor(String floor) {
    return 'الطابق $floor';
  }

  @override
  String unitAndCompound(String unit, String compound) {
    return 'الوحدة $unit · $compound';
  }

  @override
  String unitOnly(String unit) {
    return 'الوحدة $unit';
  }

  @override
  String dueDate(String date) {
    return 'الاستحقاق $date';
  }

  @override
  String validDateRange(String from, String until) {
    return 'سارٍ من $from إلى $until';
  }

  @override
  String payAmount(String amount) {
    return 'ادفع $amount';
  }

  @override
  String amountOverdue(String amount) {
    return '$amount متأخر';
  }

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navRequests => 'الطلبات';

  @override
  String get navCommunity => 'المجتمع';

  @override
  String get navAccount => 'الحساب';

  @override
  String get navGuardVisitors => 'الزوار';

  @override
  String get navGuardContractors => 'المقاولون';

  @override
  String get loginTitle => 'تسجيل الدخول إلى حسابك';

  @override
  String get loginEmail => 'البريد الإلكتروني';

  @override
  String get loginPassword => 'كلمة المرور';

  @override
  String get loginEnterEmail => 'أدخل بريدك الإلكتروني';

  @override
  String get loginEnterPassword => 'أدخل كلمة المرور';

  @override
  String get loginSignIn => 'تسجيل الدخول';

  @override
  String get loginNoAccount => 'ليس لديك حساب؟ إنشاء حساب';

  @override
  String get loginFailed => 'فشل تسجيل الدخول. حاول مرة أخرى.';

  @override
  String get registerTitle => 'إنشاء حساب';

  @override
  String get registerFullName => 'الاسم الكامل';

  @override
  String get registerEnterFullName => 'أدخل اسمك الكامل';

  @override
  String get registerEnterValidEmail => 'أدخل بريدًا إلكترونيًا صحيحًا';

  @override
  String get registerAtLeast8Chars => '8 أحرف على الأقل';

  @override
  String get registerConfirmPassword => 'تأكيد كلمة المرور';

  @override
  String get registerPasswordsDoNotMatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get registerSubmit => 'إنشاء حساب';

  @override
  String get registerReceivedTitle => 'تم استلام التسجيل';

  @override
  String get dashboardTitle => 'الرئيسية';

  @override
  String dashboardWelcome(String name) {
    return 'مرحبًا، $name';
  }

  @override
  String get dashboardTotalOutstanding => 'إجمالي المستحق';

  @override
  String get dashboardUnpaidBills => 'فواتير غير مدفوعة';

  @override
  String get dashboardRentDue => 'إيجار مستحق';

  @override
  String get dashboardInstallments => 'الأقساط';

  @override
  String get dashboardPayments => 'المدفوعات';

  @override
  String get dashboardUpcomingDue => 'المستحقات القادمة';

  @override
  String get dashboardRecentPayments => 'المدفوعات الأخيرة';

  @override
  String get dashboardYourProperties => 'عقاراتك';

  @override
  String get notificationsTitle => 'الإشعارات';

  @override
  String get notificationsMarkAllRead => 'تحديد الكل كمقروء';

  @override
  String get notificationsEmpty => 'لا توجد إشعارات بعد.';

  @override
  String get billsTitle => 'فواتير الخدمات';

  @override
  String get billsEmpty => 'لا توجد فواتير خدمات بعد.';

  @override
  String get billDetailTitle => 'تفاصيل الفاتورة';

  @override
  String billingCycle(String month, String year) {
    return 'دورة الفوترة $month/$year';
  }

  @override
  String issuedAndDue(String issued, String due) {
    return 'صدرت في $issued · الاستحقاق $due';
  }

  @override
  String get amountSubtotal => 'المجموع الفرعي';

  @override
  String get amountPreviousBalance => 'الرصيد السابق';

  @override
  String get amountLateFee => 'رسوم التأخير';

  @override
  String get amountDiscount => 'الخصم';

  @override
  String get amountTotal => 'الإجمالي';

  @override
  String get amountPaid => 'المدفوع';

  @override
  String get amountRemaining => 'المتبقي';

  @override
  String get amountAmount => 'المبلغ';

  @override
  String get lineItems => 'بنود الفاتورة';

  @override
  String get notes => 'ملاحظات';

  @override
  String lineItemDetail(String description, String quantity, String price) {
    return '$description · $quantity × $price';
  }

  @override
  String get rentTitle => 'فواتير الإيجار';

  @override
  String get rentEmpty => 'لا توجد فواتير إيجار بعد.';

  @override
  String rentPeriodUnit(String month, String year, String unit) {
    return '$month/$year · الوحدة $unit';
  }

  @override
  String get amountRent => 'مبلغ الإيجار';

  @override
  String get installmentsTitle => 'الأقساط';

  @override
  String get installmentsEmpty => 'لا توجد أقساط بعد.';

  @override
  String installmentNumber(String number) {
    return 'القسط رقم $number';
  }

  @override
  String get fieldDueDate => 'تاريخ الاستحقاق';

  @override
  String get violationFinesTitle => 'غرامات المخالفات';

  @override
  String get violationFinesEmpty => 'لا توجد غرامات مخالفات.';

  @override
  String get violationFineDetailTitle => 'غرامة المخالفة';

  @override
  String get violationFineAppeal => 'استئناف';

  @override
  String get violationFineCancellationReason => 'سبب الإلغاء';

  @override
  String get paymentsTitle => 'المدفوعات';

  @override
  String get paymentsEmpty => 'لا توجد مدفوعات بعد.';

  @override
  String get paymentDetailTitle => 'تفاصيل الدفعة';

  @override
  String paymentTypeAndMethod(String type, String method) {
    return '$type · $method';
  }

  @override
  String paymentCreated(String date) {
    return 'أُنشئت في $date';
  }

  @override
  String paymentCompleted(String date) {
    return 'اكتملت في $date';
  }

  @override
  String paymentIssued(String date) {
    return 'صدرت في $date';
  }

  @override
  String get paymentAttempts => 'المحاولات';

  @override
  String get startPaymentTitle => 'الدفع الآن';

  @override
  String get startPaymentMethod => 'طريقة الدفع';

  @override
  String get startPaymentSimulateSuccess => 'محاكاة النجاح';

  @override
  String get startPaymentSimulateFailure => 'محاكاة الفشل';

  @override
  String startPaymentDemoGateway(String method) {
    return 'بوابة $method التجريبية';
  }

  @override
  String get startPaymentMockNotice =>
      'هذه بوابة دفع تجريبية تُستخدم للخادم التجريبي. قم بمحاكاة النتيجة أدناه.';

  @override
  String get maintenanceTitle => 'طلبات الصيانة';

  @override
  String get maintenanceEmpty => 'لا توجد طلبات صيانة بعد.';

  @override
  String get maintenanceDetailTitle => 'طلب الصيانة';

  @override
  String get maintenanceCancelRequest => 'إلغاء الطلب';

  @override
  String get maintenanceCloseRequest => 'إغلاق الطلب';

  @override
  String get maintenanceNotesOptional => 'ملاحظات (اختياري)';

  @override
  String get maintenanceResolutionNotes => 'ملاحظات الحل';

  @override
  String get maintenanceCostEstimate => 'التكلفة التقديرية';

  @override
  String get maintenanceActualCost => 'التكلفة الفعلية';

  @override
  String get maintenanceTimeline => 'الجدول الزمني';

  @override
  String maintenanceAssignedTo(String name) {
    return 'أُسند إلى $name';
  }

  @override
  String get maintenanceTimelineCreated => 'أُنشئ';

  @override
  String get maintenanceTimelineAssigned => 'أُسند';

  @override
  String get maintenanceTimelineStarted => 'بدأ';

  @override
  String get maintenanceTimelineResolved => 'حُل';

  @override
  String get maintenanceTimelineClosed => 'أُغلق';

  @override
  String get maintenanceTimelineCancelled => 'أُلغي';

  @override
  String get createMaintenanceTitle => 'طلب صيانة جديد';

  @override
  String get fieldProperty => 'العقار';

  @override
  String get fieldTitle => 'العنوان';

  @override
  String get fieldDescription => 'الوصف';

  @override
  String get fieldPriority => 'الأولوية';

  @override
  String get createMaintenanceEnterTitle => 'أدخل عنوانًا';

  @override
  String get createMaintenanceDescribeIssue => 'صف المشكلة';

  @override
  String get createMaintenanceSubmit => 'إرسال الطلب';

  @override
  String get createMaintenanceSuccess => 'تم إرسال طلب الصيانة';

  @override
  String get visitorPassesTitle => 'تصاريح الزوار';

  @override
  String get visitorPassesEmpty => 'لا توجد تصاريح زوار بعد.';

  @override
  String get visitorPassDetailTitle => 'تصريح الزائر';

  @override
  String get visitorPassCancelConfirmTitle => 'إلغاء تصريح الزائر؟';

  @override
  String get visitorPassCancelConfirmBody =>
      'لن يعود رمز الدخول صالحًا عند البوابة.';

  @override
  String get visitorPassCancelPass => 'إلغاء التصريح';

  @override
  String get visitorPassAccessCode => 'رمز الدخول';

  @override
  String get visitorPassAccessCodeNotice =>
      'لأسباب أمنية، يظهر الرمز مرة واحدة فقط، مباشرة بعد إنشاء التصريح.';

  @override
  String visitorPassCheckedIn(String date) {
    return 'تم الدخول في $date';
  }

  @override
  String visitorPassCheckedOut(String date) {
    return 'تم الخروج في $date';
  }

  @override
  String get createVisitorPassTitle => 'تصريح زائر جديد';

  @override
  String get fieldVisitorName => 'اسم الزائر';

  @override
  String get fieldPhoneNumber => 'رقم الهاتف';

  @override
  String get fieldReasonForVisit => 'سبب الزيارة';

  @override
  String get fieldValidFrom => 'صالح من';

  @override
  String get fieldValidUntil => 'صالح حتى';

  @override
  String get createVisitorPassEnterName => 'أدخل اسمًا';

  @override
  String get createVisitorPassEnterPhone => 'أدخل رقم هاتف';

  @override
  String get createVisitorPassEnterReason => 'أدخل سببًا';

  @override
  String get createVisitorPassSubmit => 'إنشاء التصريح';

  @override
  String get createVisitorPassSuccess => 'تم إنشاء التصريح';

  @override
  String get createVisitorPassValidUntilError =>
      'يجب أن يكون تاريخ الانتهاء بعد تاريخ البدء.';

  @override
  String get createVisitorPassCreatedTitle => 'تم إنشاء تصريح الزائر';

  @override
  String get createVisitorPassCreatedBody =>
      'شارك رمز الدخول هذا مع زائرك الآن — لن يظهر إلا هذه المرة فقط.';

  @override
  String get createVisitorPassCodeCopied => 'تم نسخ رمز الدخول';

  @override
  String get complaintsTitle => 'الشكاوى';

  @override
  String get complaintsEmpty => 'لا توجد شكاوى بعد.';

  @override
  String get complaintDetailTitle => 'الشكوى';

  @override
  String get complaintManagementResponse => 'رد الإدارة';

  @override
  String get createComplaintTitle => 'شكوى جديدة';

  @override
  String get fieldPropertyOptional => 'العقار (اختياري)';

  @override
  String get fieldPropertyGeneral => 'عام / غير مرتبط بوحدة معينة';

  @override
  String get createComplaintDescribe => 'صف شكواك';

  @override
  String get createComplaintSubmit => 'إرسال الشكوى';

  @override
  String get createComplaintSuccess => 'تم إرسال الشكوى';

  @override
  String get announcementsEmpty => 'لا توجد إعلانات بعد.';

  @override
  String get announcementDetailTitle => 'الإعلان';

  @override
  String announcementExpires(String date) {
    return 'تنتهي في $date';
  }

  @override
  String get pollsEmpty => 'لا توجد استطلاعات مفتوحة حاليًا.';

  @override
  String get pollDetailTitle => 'الاستطلاع';

  @override
  String pollCloses(String date) {
    return 'يُغلق في $date';
  }

  @override
  String get pollVoted => 'تم التصويت';

  @override
  String pollOpenRange(String from, String to) {
    return 'مفتوح من $from إلى $to';
  }

  @override
  String get pollMultipleChoicesAllowed => 'يُسمح باختيارات متعددة';

  @override
  String get pollAlreadyVoted => 'لقد صوّتَ بالفعل في هذا الاستطلاع.';

  @override
  String get pollSubmitVote => 'إرسال التصويت';

  @override
  String get financialDisputesTitle => 'المنازعات المالية';

  @override
  String get financialDisputesEmpty => 'لا توجد منازعات مالية بعد.';

  @override
  String get financialDisputeDetailTitle => 'المنازعة المالية';

  @override
  String financialDisputeTypeAndReference(String type, String reference) {
    return '$type · $reference';
  }

  @override
  String financialDisputeSubmitted(String date) {
    return 'أُرسلت في $date';
  }

  @override
  String get financialDisputeManagementNotes => 'ملاحظات الإدارة';

  @override
  String get financialDisputeResolution => 'الحل';

  @override
  String get createFinancialDisputeTitle => 'منازعة مالية جديدة';

  @override
  String get fieldWhatDisputing => 'ما الذي تعترض عليه؟';

  @override
  String get fieldReason => 'السبب';

  @override
  String get fieldMessage => 'الرسالة';

  @override
  String get createFinancialDisputeSelectTarget =>
      'اختر ما تريد الاعتراض عليه.';

  @override
  String get createFinancialDisputeEnterReason => 'أدخل سببًا';

  @override
  String get createFinancialDisputeDescribe => 'صف المنازعة';

  @override
  String get createFinancialDisputeSubmit => 'إرسال المنازعة';

  @override
  String get createFinancialDisputeSuccess => 'تم إرسال المنازعة';

  @override
  String get createFinancialDisputeSelectItem => 'اختر عنصرًا';

  @override
  String get createFinancialDisputeNothingAvailable =>
      'لا يوجد شيء متاح للاعتراض عليه.';

  @override
  String get createFinancialDisputeCouldNotLoad => 'تعذر تحميل الخيارات.';

  @override
  String get violationAppealsTitle => 'استئنافات المخالفات';

  @override
  String get violationAppealsEmpty => 'لا توجد استئنافات مخالفات بعد.';

  @override
  String get violationAppealDetailTitle => 'استئناف المخالفة';

  @override
  String violationAppealFineAmount(String amount) {
    return 'مبلغ الغرامة $amount';
  }

  @override
  String violationAppealReducedTo(String amount) {
    return 'خُفّضت إلى $amount';
  }

  @override
  String get createViolationAppealTitle => 'استئناف مخالفة جديد';

  @override
  String get createViolationAppealAppealing => 'الاستئناف على';

  @override
  String get createViolationAppealEnterReason => 'أدخل سببًا';

  @override
  String get createViolationAppealExplain => 'اشرح استئنافك';

  @override
  String get createViolationAppealSubmit => 'إرسال الاستئناف';

  @override
  String get createViolationAppealSuccess => 'تم إرسال الاستئناف';

  @override
  String get familyMembersTitle => 'أفراد العائلة';

  @override
  String get familyMembersEmpty => 'لم تتم إضافة أفراد عائلة بعد.';

  @override
  String get familyMemberRemoveTitle => 'إزالة فرد العائلة؟';

  @override
  String familyMemberRemoveConfirm(String name) {
    return 'إزالة $name من أفراد عائلتك؟';
  }

  @override
  String familyMemberBorn(String date) {
    return 'تاريخ الميلاد $date';
  }

  @override
  String get familyMemberEditTitle => 'تعديل فرد العائلة';

  @override
  String get familyMemberAddTitle => 'إضافة فرد عائلة';

  @override
  String get familyMemberSave => 'حفظ التغييرات';

  @override
  String get familyMemberSavedSuccess => 'تم حفظ البيانات';

  @override
  String get familyMemberAdd => 'إضافة فرد العائلة';

  @override
  String get fieldFullName => 'الاسم الكامل';

  @override
  String get fieldRelationship => 'صلة القرابة';

  @override
  String get fieldPhoneNumberOptional => 'رقم الهاتف (اختياري)';

  @override
  String get fieldDateOfBirthOptional => 'تاريخ الميلاد (اختياري)';

  @override
  String get familyMemberEnterName => 'أدخل اسمًا';

  @override
  String get familyMemberEnterRelationship => 'أدخل صلة القرابة';

  @override
  String get emergencyContactsTitle => 'جهات اتصال الطوارئ';

  @override
  String get emergencyContactsEmpty => 'لم تتم إضافة جهات اتصال طوارئ بعد.';

  @override
  String get emergencyContactRemoveTitle => 'إزالة جهة اتصال الطوارئ؟';

  @override
  String emergencyContactRemoveConfirm(String name) {
    return 'إزالة $name من جهات اتصال الطوارئ؟';
  }

  @override
  String get emergencyContactEditTitle => 'تعديل جهة اتصال الطوارئ';

  @override
  String get emergencyContactAddTitle => 'إضافة جهة اتصال طوارئ';

  @override
  String get emergencyContactAdd => 'إضافة جهة اتصال';

  @override
  String get emergencyContactSavedSuccess => 'تم حفظ جهة الاتصال';

  @override
  String get emergencyContactEnterPhone => 'أدخل رقم هاتف';

  @override
  String get documentsTitle => 'المستندات';

  @override
  String get documentsEmpty => 'لا توجد مستندات بعد.';

  @override
  String documentMeta(String category, String size, String date) {
    return '$category · $size · $date';
  }

  @override
  String documentCouldNotOpen(String message) {
    return 'تعذر فتح الملف: $message';
  }

  @override
  String get accountTitle => 'الحساب';

  @override
  String get accountFamilyMembers => 'أفراد العائلة';

  @override
  String get accountEmergencyContacts => 'جهات اتصال الطوارئ';

  @override
  String get accountDocuments => 'المستندات';

  @override
  String get accountUtilityBills => 'فواتير الخدمات';

  @override
  String get accountRentInvoices => 'فواتير الإيجار';

  @override
  String get accountInstallments => 'الأقساط';

  @override
  String get accountPaymentHistory => 'سجل المدفوعات';

  @override
  String get accountFinancialDisputes => 'المنازعات المالية';

  @override
  String get accountViolationFines => 'غرامات المخالفات';

  @override
  String get accountViolationAppeals => 'استئنافات المخالفات';

  @override
  String get accountSettings => 'الإعدادات';

  @override
  String get accountSignOut => 'تسجيل الخروج';

  @override
  String get requestsTitle => 'الطلبات';

  @override
  String get requestsMaintenanceTitle => 'طلبات الصيانة';

  @override
  String get requestsMaintenanceSubtitle => 'الإبلاغ عن مشكلة في وحدتك';

  @override
  String get requestsVisitorPassesTitle => 'تصاريح الزوار';

  @override
  String get requestsVisitorPassesSubtitle =>
      'امنح زائرًا حق الدخول من البوابة';

  @override
  String get requestsComplaintsTitle => 'الشكاوى';

  @override
  String get requestsComplaintsSubtitle => 'تقديم شكوى إلى الإدارة';

  @override
  String get communityTitle => 'المجتمع';

  @override
  String get communityAnnouncementsTab => 'الإعلانات';

  @override
  String get communityPollsTab => 'الاستطلاعات';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get settingsAppearance => 'المظهر';

  @override
  String get settingsThemeSystem => 'النظام';

  @override
  String get settingsThemeLight => 'فاتح';

  @override
  String get settingsThemeDark => 'داكن';

  @override
  String get settingsLanguage => 'اللغة';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get settingsLanguageArabic => 'العربية';

  @override
  String get statusUnpaid => 'غير مدفوع';

  @override
  String get statusPartiallyPaid => 'مدفوع جزئيًا';

  @override
  String get statusPaid => 'مدفوع';

  @override
  String get statusOverdue => 'متأخر';

  @override
  String get statusCancelled => 'ملغى';

  @override
  String get paymentTargetTypeUtilityBill => 'فاتورة خدمات';

  @override
  String get paymentTargetTypePropertyInstallment => 'قسط عقاري';

  @override
  String get paymentTargetTypeRentInvoice => 'فاتورة إيجار';

  @override
  String get paymentTargetTypeViolationFine => 'غرامة مخالفة';

  @override
  String get paymentTargetTypePaymentPlanInstallment => 'قسط خطة الدفع';

  @override
  String get paymentTargetTypePropertySaleContract => 'عقد بيع عقار';

  @override
  String get announcementCategoryGeneral => 'عام';

  @override
  String get announcementCategoryMaintenance => 'صيانة';

  @override
  String get announcementCategoryUtility => 'خدمات';

  @override
  String get announcementCategoryPayment => 'دفع';

  @override
  String get announcementCategorySecurity => 'أمن';

  @override
  String get announcementCategoryEvent => 'فعالية';

  @override
  String get announcementCategoryEmergency => 'طوارئ';

  @override
  String get announcementCategoryRule => 'قاعدة';

  @override
  String get announcementCategoryOther => 'أخرى';

  @override
  String get announcementPriorityLow => 'منخفضة';

  @override
  String get announcementPriorityNormal => 'عادية';

  @override
  String get announcementPriorityHigh => 'عالية';

  @override
  String get announcementPriorityCritical => 'حرجة';

  @override
  String get complaintStatusOpen => 'مفتوحة';

  @override
  String get complaintStatusUnderReview => 'قيد المراجعة';

  @override
  String get complaintStatusResolved => 'محلولة';

  @override
  String get complaintStatusRejected => 'مرفوضة';

  @override
  String get complaintStatusConvertedToViolation => 'حُوّلت إلى مخالفة';

  @override
  String get documentApprovalStatusNotRequired => 'غير مطلوبة';

  @override
  String get documentApprovalStatusPendingReview => 'قيد المراجعة';

  @override
  String get documentApprovalStatusApproved => 'معتمدة';

  @override
  String get documentApprovalStatusRejected => 'مرفوضة';

  @override
  String get documentCategoryResidentIdentity => 'هوية الساكن';

  @override
  String get documentCategoryOwnershipContract => 'عقد ملكية';

  @override
  String get documentCategoryLeaseContract => 'عقد إيجار';

  @override
  String get documentCategoryPaymentReceipt => 'إيصال دفع';

  @override
  String get documentCategoryMaintenanceAttachment => 'مرفق صيانة';

  @override
  String get documentCategoryComplaintAttachment => 'مرفق شكوى';

  @override
  String get documentCategoryViolationAttachment => 'مرفق مخالفة';

  @override
  String get documentCategoryAdministrative => 'إداري';

  @override
  String get documentCategoryOther => 'أخرى';

  @override
  String get financialDisputeStatusOpen => 'مفتوحة';

  @override
  String get financialDisputeStatusUnderReview => 'قيد المراجعة';

  @override
  String get financialDisputeStatusNeedResidentResponse => 'بحاجة إلى ردك';

  @override
  String get financialDisputeStatusAccepted => 'مقبولة';

  @override
  String get financialDisputeStatusRejected => 'مرفوضة';

  @override
  String get financialDisputeStatusResolved => 'محلولة';

  @override
  String get financialDisputeStatusCancelled => 'ملغاة';

  @override
  String get financialDisputeTargetTypeUtilityBill => 'فاتورة خدمات';

  @override
  String get financialDisputeTargetTypePayment => 'دفعة';

  @override
  String get financialDisputeTargetTypeViolationFine => 'غرامة مخالفة';

  @override
  String get financialDisputeTargetTypeRentInvoice => 'فاتورة إيجار';

  @override
  String get financialDisputeTargetTypePropertyInstallment => 'قسط';

  @override
  String get financialDisputeTargetTypeFinancialAdjustment => 'تسوية مالية';

  @override
  String get maintenancePriorityLow => 'منخفضة';

  @override
  String get maintenancePriorityMedium => 'متوسطة';

  @override
  String get maintenancePriorityHigh => 'عالية';

  @override
  String get maintenancePriorityEmergency => 'طارئة';

  @override
  String get maintenanceStatusOpen => 'مفتوح';

  @override
  String get maintenanceStatusAssigned => 'مُسند';

  @override
  String get maintenanceStatusInProgress => 'قيد التنفيذ';

  @override
  String get maintenanceStatusResolved => 'محلول';

  @override
  String get maintenanceStatusClosed => 'مغلق';

  @override
  String get maintenanceStatusRejected => 'مرفوض';

  @override
  String get maintenanceStatusCancelled => 'ملغى';

  @override
  String get paymentMethodZainCash => 'زين كاش';

  @override
  String get paymentMethodMasterCard => 'ماستركارد';

  @override
  String get paymentMethodCash => 'نقدًا';

  @override
  String get paymentMethodBankTransfer => 'تحويل بنكي';

  @override
  String get paymentMethodManualAdminPayment => 'دفعة مسجلة من الإدارة';

  @override
  String get paymentStatusPending => 'قيد الانتظار';

  @override
  String get paymentStatusSucceeded => 'ناجحة';

  @override
  String get paymentStatusFailed => 'فاشلة';

  @override
  String get paymentStatusCancelled => 'ملغاة';

  @override
  String get paymentStatusRefunded => 'مستردة';

  @override
  String get pollStatusDraft => 'مسودة';

  @override
  String get pollStatusOpen => 'مفتوح';

  @override
  String get pollStatusClosed => 'مغلق';

  @override
  String get pollStatusArchived => 'مؤرشف';

  @override
  String get violationAppealStatusSubmitted => 'مُرسل';

  @override
  String get violationAppealStatusUnderReview => 'قيد المراجعة';

  @override
  String get violationAppealStatusNeedResidentResponse => 'بحاجة إلى ردك';

  @override
  String get violationAppealStatusAccepted => 'مقبول';

  @override
  String get violationAppealStatusRejected => 'مرفوض';

  @override
  String get violationAppealStatusFineReduced => 'تم تخفيض الغرامة';

  @override
  String get violationAppealStatusFineCancelled => 'أُلغيت الغرامة';

  @override
  String get violationAppealStatusCancelled => 'ملغى';

  @override
  String get visitorPassStatusPending => 'قيد الانتظار';

  @override
  String get visitorPassStatusApproved => 'معتمد';

  @override
  String get visitorPassStatusCheckedIn => 'تم الدخول';

  @override
  String get visitorPassStatusCheckedOut => 'تم الخروج';

  @override
  String get visitorPassStatusExpired => 'منتهي الصلاحية';

  @override
  String get visitorPassStatusCancelled => 'ملغى';

  @override
  String get visitorPassStatusDenied => 'مرفوض';

  @override
  String get visitorAccessActionCheckIn => 'تم الدخول';

  @override
  String get visitorAccessActionCheckOut => 'تم الخروج';

  @override
  String get visitorAccessActionDenied => 'مرفوض';

  @override
  String get visitorAccessActionVerified => 'تم التحقق';

  @override
  String get visitorAccessActionCredentialFailed => 'فشل رمز الدخول';

  @override
  String get guardVisitorsTitle => 'زوار اليوم';

  @override
  String get guardVisitorsEmpty => 'لا يوجد زوار متوقعون اليوم.';

  @override
  String get guardVerifyCodeTitle => 'التحقق من رمز الدخول';

  @override
  String get guardVerifyCodeLabel => 'رمز الدخول';

  @override
  String get guardVerifyCodeSubmit => 'تحقق';

  @override
  String get guardVisitorDetailTitle => 'تصريح الزائر';

  @override
  String get guardCheckIn => 'تسجيل الدخول';

  @override
  String get guardCheckOut => 'تسجيل الخروج';

  @override
  String get guardNotesOptional => 'ملاحظات (اختياري)';

  @override
  String get guardEnterAccessCode => 'أدخل رمز الدخول';

  @override
  String get guardDeny => 'رفض';

  @override
  String get guardDenyTitle => 'رفض الدخول';

  @override
  String get guardDenyReasonLabel => 'السبب';

  @override
  String get guardEnterDenyReason => 'أدخل سببًا';

  @override
  String get guardAccessLogTitle => 'سجل الدخول';

  @override
  String get guardAccessLogEmpty => 'لا توجد إدخالات في سجل الدخول بعد.';

  @override
  String get contractorStatusPendingApproval => 'بانتظار الموافقة';

  @override
  String get contractorStatusApproved => 'معتمد';

  @override
  String get contractorStatusDenied => 'مرفوض';

  @override
  String get contractorStatusCheckedIn => 'تم الدخول';

  @override
  String get contractorStatusCheckedOut => 'تم الخروج';

  @override
  String get contractorStatusClosed => 'مغلق';

  @override
  String get contractorStatusCancelled => 'ملغى';

  @override
  String get contractorStatusExpired => 'منتهي الصلاحية';

  @override
  String get contractorRiskLevelLow => 'خطورة منخفضة';

  @override
  String get contractorRiskLevelMedium => 'خطورة متوسطة';

  @override
  String get contractorRiskLevelHigh => 'خطورة عالية';

  @override
  String get contractorRiskLevelCritical => 'خطورة حرجة';

  @override
  String get guardContractorsTitle => 'مقاولو اليوم';

  @override
  String get guardContractorsEmpty => 'لا يوجد مقاولون متوقعون اليوم.';

  @override
  String get guardContractorDetailTitle => 'تصريح المقاول';
}
