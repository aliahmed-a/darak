import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'DARAK'**
  String get appName;

  /// No description provided for @splashTagline.
  ///
  /// In en, this message translates to:
  /// **'Your compound, in your pocket'**
  String get splashTagline;

  /// No description provided for @commonTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get commonTryAgain;

  /// No description provided for @commonSomethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong.'**
  String get commonSomethingWentWrong;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonLoadMore.
  ///
  /// In en, this message translates to:
  /// **'Load more'**
  String get commonLoadMore;

  /// No description provided for @commonBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get commonBack;

  /// No description provided for @commonRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get commonRemove;

  /// No description provided for @commonConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get commonConfirm;

  /// No description provided for @commonOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get commonOk;

  /// No description provided for @commonDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get commonDone;

  /// No description provided for @commonCopy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get commonCopy;

  /// No description provided for @commonNotSet.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get commonNotSet;

  /// No description provided for @commonActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get commonActive;

  /// No description provided for @commonInactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get commonInactive;

  /// No description provided for @commonNothingHereYet.
  ///
  /// In en, this message translates to:
  /// **'Nothing here yet.'**
  String get commonNothingHereYet;

  /// No description provided for @unitAndCompound.
  ///
  /// In en, this message translates to:
  /// **'Unit {unit} · {compound}'**
  String unitAndCompound(String unit, String compound);

  /// No description provided for @unitOnly.
  ///
  /// In en, this message translates to:
  /// **'Unit {unit}'**
  String unitOnly(String unit);

  /// No description provided for @dueDate.
  ///
  /// In en, this message translates to:
  /// **'Due {date}'**
  String dueDate(String date);

  /// No description provided for @validDateRange.
  ///
  /// In en, this message translates to:
  /// **'Valid {from} → {until}'**
  String validDateRange(String from, String until);

  /// No description provided for @payAmount.
  ///
  /// In en, this message translates to:
  /// **'Pay {amount}'**
  String payAmount(String amount);

  /// No description provided for @amountOverdue.
  ///
  /// In en, this message translates to:
  /// **'{amount} overdue'**
  String amountOverdue(String amount);

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navRequests.
  ///
  /// In en, this message translates to:
  /// **'Requests'**
  String get navRequests;

  /// No description provided for @navCommunity.
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get navCommunity;

  /// No description provided for @navAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get navAccount;

  /// No description provided for @navGuardVisitors.
  ///
  /// In en, this message translates to:
  /// **'Visitors'**
  String get navGuardVisitors;

  /// No description provided for @navGuardContractors.
  ///
  /// In en, this message translates to:
  /// **'Contractors'**
  String get navGuardContractors;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to your account'**
  String get loginTitle;

  /// No description provided for @loginEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get loginEmail;

  /// No description provided for @loginPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get loginPassword;

  /// No description provided for @loginEnterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get loginEnterEmail;

  /// No description provided for @loginEnterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get loginEnterPassword;

  /// No description provided for @loginSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get loginSignIn;

  /// No description provided for @loginNoAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? Register'**
  String get loginNoAccount;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed. Please try again.'**
  String get loginFailed;

  /// No description provided for @registerTitle.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get registerTitle;

  /// No description provided for @registerFullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get registerFullName;

  /// No description provided for @registerEnterFullName.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get registerEnterFullName;

  /// No description provided for @registerEnterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get registerEnterValidEmail;

  /// No description provided for @registerAtLeast8Chars.
  ///
  /// In en, this message translates to:
  /// **'At least 8 characters'**
  String get registerAtLeast8Chars;

  /// No description provided for @registerConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get registerConfirmPassword;

  /// No description provided for @registerPasswordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get registerPasswordsDoNotMatch;

  /// No description provided for @registerSubmit.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get registerSubmit;

  /// No description provided for @registerReceivedTitle.
  ///
  /// In en, this message translates to:
  /// **'Registration received'**
  String get registerReceivedTitle;

  /// No description provided for @dashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get dashboardTitle;

  /// No description provided for @dashboardWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome, {name}'**
  String dashboardWelcome(String name);

  /// No description provided for @dashboardTotalOutstanding.
  ///
  /// In en, this message translates to:
  /// **'Total outstanding'**
  String get dashboardTotalOutstanding;

  /// No description provided for @dashboardUnpaidBills.
  ///
  /// In en, this message translates to:
  /// **'Unpaid bills'**
  String get dashboardUnpaidBills;

  /// No description provided for @dashboardRentDue.
  ///
  /// In en, this message translates to:
  /// **'Rent due'**
  String get dashboardRentDue;

  /// No description provided for @dashboardInstallments.
  ///
  /// In en, this message translates to:
  /// **'Installments'**
  String get dashboardInstallments;

  /// No description provided for @dashboardPayments.
  ///
  /// In en, this message translates to:
  /// **'Payments'**
  String get dashboardPayments;

  /// No description provided for @dashboardUpcomingDue.
  ///
  /// In en, this message translates to:
  /// **'Upcoming due'**
  String get dashboardUpcomingDue;

  /// No description provided for @dashboardRecentPayments.
  ///
  /// In en, this message translates to:
  /// **'Recent payments'**
  String get dashboardRecentPayments;

  /// No description provided for @dashboardYourProperties.
  ///
  /// In en, this message translates to:
  /// **'Your properties'**
  String get dashboardYourProperties;

  /// No description provided for @notificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// No description provided for @notificationsMarkAllRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all read'**
  String get notificationsMarkAllRead;

  /// No description provided for @notificationsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No notifications yet.'**
  String get notificationsEmpty;

  /// No description provided for @billsTitle.
  ///
  /// In en, this message translates to:
  /// **'Utility bills'**
  String get billsTitle;

  /// No description provided for @billsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No utility bills yet.'**
  String get billsEmpty;

  /// No description provided for @billDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Bill detail'**
  String get billDetailTitle;

  /// No description provided for @billingCycle.
  ///
  /// In en, this message translates to:
  /// **'Billing cycle {month}/{year}'**
  String billingCycle(String month, String year);

  /// No description provided for @issuedAndDue.
  ///
  /// In en, this message translates to:
  /// **'Issued {issued} · Due {due}'**
  String issuedAndDue(String issued, String due);

  /// No description provided for @amountSubtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get amountSubtotal;

  /// No description provided for @amountPreviousBalance.
  ///
  /// In en, this message translates to:
  /// **'Previous balance'**
  String get amountPreviousBalance;

  /// No description provided for @amountLateFee.
  ///
  /// In en, this message translates to:
  /// **'Late fee'**
  String get amountLateFee;

  /// No description provided for @amountDiscount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get amountDiscount;

  /// No description provided for @amountTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get amountTotal;

  /// No description provided for @amountPaid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get amountPaid;

  /// No description provided for @amountRemaining.
  ///
  /// In en, this message translates to:
  /// **'Remaining'**
  String get amountRemaining;

  /// No description provided for @amountAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amountAmount;

  /// No description provided for @lineItems.
  ///
  /// In en, this message translates to:
  /// **'Line items'**
  String get lineItems;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @lineItemDetail.
  ///
  /// In en, this message translates to:
  /// **'{description} · {quantity} x {price}'**
  String lineItemDetail(String description, String quantity, String price);

  /// No description provided for @rentTitle.
  ///
  /// In en, this message translates to:
  /// **'Rent invoices'**
  String get rentTitle;

  /// No description provided for @rentEmpty.
  ///
  /// In en, this message translates to:
  /// **'No rent invoices yet.'**
  String get rentEmpty;

  /// No description provided for @rentPeriodUnit.
  ///
  /// In en, this message translates to:
  /// **'{month}/{year} · Unit {unit}'**
  String rentPeriodUnit(String month, String year, String unit);

  /// No description provided for @amountRent.
  ///
  /// In en, this message translates to:
  /// **'Rent amount'**
  String get amountRent;

  /// No description provided for @installmentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Installments'**
  String get installmentsTitle;

  /// No description provided for @installmentsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No installments yet.'**
  String get installmentsEmpty;

  /// No description provided for @installmentNumber.
  ///
  /// In en, this message translates to:
  /// **'Installment #{number}'**
  String installmentNumber(String number);

  /// No description provided for @fieldDueDate.
  ///
  /// In en, this message translates to:
  /// **'Due date'**
  String get fieldDueDate;

  /// No description provided for @violationFinesTitle.
  ///
  /// In en, this message translates to:
  /// **'Violation fines'**
  String get violationFinesTitle;

  /// No description provided for @violationFinesEmpty.
  ///
  /// In en, this message translates to:
  /// **'No violation fines.'**
  String get violationFinesEmpty;

  /// No description provided for @violationFineDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Violation fine'**
  String get violationFineDetailTitle;

  /// No description provided for @violationFineAppeal.
  ///
  /// In en, this message translates to:
  /// **'Appeal'**
  String get violationFineAppeal;

  /// No description provided for @violationFineCancellationReason.
  ///
  /// In en, this message translates to:
  /// **'Cancellation reason'**
  String get violationFineCancellationReason;

  /// No description provided for @paymentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Payments'**
  String get paymentsTitle;

  /// No description provided for @paymentsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No payments yet.'**
  String get paymentsEmpty;

  /// No description provided for @paymentDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment detail'**
  String get paymentDetailTitle;

  /// No description provided for @paymentTypeAndMethod.
  ///
  /// In en, this message translates to:
  /// **'{type} · {method}'**
  String paymentTypeAndMethod(String type, String method);

  /// No description provided for @paymentCreated.
  ///
  /// In en, this message translates to:
  /// **'Created {date}'**
  String paymentCreated(String date);

  /// No description provided for @paymentCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed {date}'**
  String paymentCompleted(String date);

  /// No description provided for @paymentIssued.
  ///
  /// In en, this message translates to:
  /// **'Issued {date}'**
  String paymentIssued(String date);

  /// No description provided for @paymentAttempts.
  ///
  /// In en, this message translates to:
  /// **'Attempts'**
  String get paymentAttempts;

  /// No description provided for @startPaymentTitle.
  ///
  /// In en, this message translates to:
  /// **'Pay now'**
  String get startPaymentTitle;

  /// No description provided for @startPaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment method'**
  String get startPaymentMethod;

  /// No description provided for @startPaymentSimulateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Simulate success'**
  String get startPaymentSimulateSuccess;

  /// No description provided for @startPaymentSimulateFailure.
  ///
  /// In en, this message translates to:
  /// **'Simulate failure'**
  String get startPaymentSimulateFailure;

  /// No description provided for @startPaymentDemoGateway.
  ///
  /// In en, this message translates to:
  /// **'{method} demo gateway'**
  String startPaymentDemoGateway(String method);

  /// No description provided for @startPaymentMockNotice.
  ///
  /// In en, this message translates to:
  /// **'This is a mock provider used for the demo backend. Simulate the outcome below.'**
  String get startPaymentMockNotice;

  /// No description provided for @maintenanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Maintenance requests'**
  String get maintenanceTitle;

  /// No description provided for @maintenanceEmpty.
  ///
  /// In en, this message translates to:
  /// **'No maintenance requests yet.'**
  String get maintenanceEmpty;

  /// No description provided for @maintenanceDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Maintenance request'**
  String get maintenanceDetailTitle;

  /// No description provided for @maintenanceCancelRequest.
  ///
  /// In en, this message translates to:
  /// **'Cancel request'**
  String get maintenanceCancelRequest;

  /// No description provided for @maintenanceCloseRequest.
  ///
  /// In en, this message translates to:
  /// **'Close request'**
  String get maintenanceCloseRequest;

  /// No description provided for @maintenanceNotesOptional.
  ///
  /// In en, this message translates to:
  /// **'Notes (optional)'**
  String get maintenanceNotesOptional;

  /// No description provided for @maintenanceResolutionNotes.
  ///
  /// In en, this message translates to:
  /// **'Resolution notes'**
  String get maintenanceResolutionNotes;

  /// No description provided for @maintenanceCostEstimate.
  ///
  /// In en, this message translates to:
  /// **'Cost estimate'**
  String get maintenanceCostEstimate;

  /// No description provided for @maintenanceActualCost.
  ///
  /// In en, this message translates to:
  /// **'Actual cost'**
  String get maintenanceActualCost;

  /// No description provided for @maintenanceTimeline.
  ///
  /// In en, this message translates to:
  /// **'Timeline'**
  String get maintenanceTimeline;

  /// No description provided for @maintenanceAssignedTo.
  ///
  /// In en, this message translates to:
  /// **'Assigned to {name}'**
  String maintenanceAssignedTo(String name);

  /// No description provided for @maintenanceTimelineCreated.
  ///
  /// In en, this message translates to:
  /// **'Created'**
  String get maintenanceTimelineCreated;

  /// No description provided for @maintenanceTimelineAssigned.
  ///
  /// In en, this message translates to:
  /// **'Assigned'**
  String get maintenanceTimelineAssigned;

  /// No description provided for @maintenanceTimelineStarted.
  ///
  /// In en, this message translates to:
  /// **'Started'**
  String get maintenanceTimelineStarted;

  /// No description provided for @maintenanceTimelineResolved.
  ///
  /// In en, this message translates to:
  /// **'Resolved'**
  String get maintenanceTimelineResolved;

  /// No description provided for @maintenanceTimelineClosed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get maintenanceTimelineClosed;

  /// No description provided for @maintenanceTimelineCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get maintenanceTimelineCancelled;

  /// No description provided for @createMaintenanceTitle.
  ///
  /// In en, this message translates to:
  /// **'New maintenance request'**
  String get createMaintenanceTitle;

  /// No description provided for @fieldProperty.
  ///
  /// In en, this message translates to:
  /// **'Property'**
  String get fieldProperty;

  /// No description provided for @fieldTitle.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get fieldTitle;

  /// No description provided for @fieldDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get fieldDescription;

  /// No description provided for @fieldPriority.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get fieldPriority;

  /// No description provided for @createMaintenanceEnterTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter a title'**
  String get createMaintenanceEnterTitle;

  /// No description provided for @createMaintenanceDescribeIssue.
  ///
  /// In en, this message translates to:
  /// **'Describe the issue'**
  String get createMaintenanceDescribeIssue;

  /// No description provided for @createMaintenanceSubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit request'**
  String get createMaintenanceSubmit;

  /// No description provided for @visitorPassesTitle.
  ///
  /// In en, this message translates to:
  /// **'Visitor passes'**
  String get visitorPassesTitle;

  /// No description provided for @visitorPassesEmpty.
  ///
  /// In en, this message translates to:
  /// **'No visitor passes yet.'**
  String get visitorPassesEmpty;

  /// No description provided for @visitorPassDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Visitor pass'**
  String get visitorPassDetailTitle;

  /// No description provided for @visitorPassCancelConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Cancel visitor pass?'**
  String get visitorPassCancelConfirmTitle;

  /// No description provided for @visitorPassCancelConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'The access code will no longer be valid at the gate.'**
  String get visitorPassCancelConfirmBody;

  /// No description provided for @visitorPassCancelPass.
  ///
  /// In en, this message translates to:
  /// **'Cancel pass'**
  String get visitorPassCancelPass;

  /// No description provided for @visitorPassAccessCode.
  ///
  /// In en, this message translates to:
  /// **'Access code'**
  String get visitorPassAccessCode;

  /// No description provided for @visitorPassAccessCodeNotice.
  ///
  /// In en, this message translates to:
  /// **'For security, the code is only shown once, right after you create the pass.'**
  String get visitorPassAccessCodeNotice;

  /// No description provided for @visitorPassCheckedIn.
  ///
  /// In en, this message translates to:
  /// **'Checked in {date}'**
  String visitorPassCheckedIn(String date);

  /// No description provided for @visitorPassCheckedOut.
  ///
  /// In en, this message translates to:
  /// **'Checked out {date}'**
  String visitorPassCheckedOut(String date);

  /// No description provided for @createVisitorPassTitle.
  ///
  /// In en, this message translates to:
  /// **'New visitor pass'**
  String get createVisitorPassTitle;

  /// No description provided for @fieldVisitorName.
  ///
  /// In en, this message translates to:
  /// **'Visitor\'s name'**
  String get fieldVisitorName;

  /// No description provided for @fieldPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get fieldPhoneNumber;

  /// No description provided for @fieldReasonForVisit.
  ///
  /// In en, this message translates to:
  /// **'Reason for visit'**
  String get fieldReasonForVisit;

  /// No description provided for @fieldValidFrom.
  ///
  /// In en, this message translates to:
  /// **'Valid from'**
  String get fieldValidFrom;

  /// No description provided for @fieldValidUntil.
  ///
  /// In en, this message translates to:
  /// **'Valid until'**
  String get fieldValidUntil;

  /// No description provided for @createVisitorPassEnterName.
  ///
  /// In en, this message translates to:
  /// **'Enter a name'**
  String get createVisitorPassEnterName;

  /// No description provided for @createVisitorPassEnterPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter a phone number'**
  String get createVisitorPassEnterPhone;

  /// No description provided for @createVisitorPassEnterReason.
  ///
  /// In en, this message translates to:
  /// **'Enter a reason'**
  String get createVisitorPassEnterReason;

  /// No description provided for @createVisitorPassSubmit.
  ///
  /// In en, this message translates to:
  /// **'Create pass'**
  String get createVisitorPassSubmit;

  /// No description provided for @createVisitorPassValidUntilError.
  ///
  /// In en, this message translates to:
  /// **'Valid until must be after valid from.'**
  String get createVisitorPassValidUntilError;

  /// No description provided for @createVisitorPassCreatedTitle.
  ///
  /// In en, this message translates to:
  /// **'Visitor pass created'**
  String get createVisitorPassCreatedTitle;

  /// No description provided for @createVisitorPassCreatedBody.
  ///
  /// In en, this message translates to:
  /// **'Share this access code with your visitor now — it will only be shown this once.'**
  String get createVisitorPassCreatedBody;

  /// No description provided for @createVisitorPassCodeCopied.
  ///
  /// In en, this message translates to:
  /// **'Access code copied'**
  String get createVisitorPassCodeCopied;

  /// No description provided for @complaintsTitle.
  ///
  /// In en, this message translates to:
  /// **'Complaints'**
  String get complaintsTitle;

  /// No description provided for @complaintsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No complaints yet.'**
  String get complaintsEmpty;

  /// No description provided for @complaintDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Complaint'**
  String get complaintDetailTitle;

  /// No description provided for @complaintManagementResponse.
  ///
  /// In en, this message translates to:
  /// **'Management response'**
  String get complaintManagementResponse;

  /// No description provided for @createComplaintTitle.
  ///
  /// In en, this message translates to:
  /// **'New complaint'**
  String get createComplaintTitle;

  /// No description provided for @fieldPropertyOptional.
  ///
  /// In en, this message translates to:
  /// **'Property (optional)'**
  String get fieldPropertyOptional;

  /// No description provided for @fieldPropertyGeneral.
  ///
  /// In en, this message translates to:
  /// **'General / not unit-specific'**
  String get fieldPropertyGeneral;

  /// No description provided for @createComplaintDescribe.
  ///
  /// In en, this message translates to:
  /// **'Describe your complaint'**
  String get createComplaintDescribe;

  /// No description provided for @createComplaintSubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit complaint'**
  String get createComplaintSubmit;

  /// No description provided for @announcementsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No announcements yet.'**
  String get announcementsEmpty;

  /// No description provided for @announcementDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Announcement'**
  String get announcementDetailTitle;

  /// No description provided for @announcementExpires.
  ///
  /// In en, this message translates to:
  /// **'Expires {date}'**
  String announcementExpires(String date);

  /// No description provided for @pollsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No open polls right now.'**
  String get pollsEmpty;

  /// No description provided for @pollDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Poll'**
  String get pollDetailTitle;

  /// No description provided for @pollCloses.
  ///
  /// In en, this message translates to:
  /// **'Closes {date}'**
  String pollCloses(String date);

  /// No description provided for @pollVoted.
  ///
  /// In en, this message translates to:
  /// **'Voted'**
  String get pollVoted;

  /// No description provided for @pollOpenRange.
  ///
  /// In en, this message translates to:
  /// **'Open {from} → {to}'**
  String pollOpenRange(String from, String to);

  /// No description provided for @pollMultipleChoicesAllowed.
  ///
  /// In en, this message translates to:
  /// **'Multiple choices allowed'**
  String get pollMultipleChoicesAllowed;

  /// No description provided for @pollAlreadyVoted.
  ///
  /// In en, this message translates to:
  /// **'You already voted in this poll.'**
  String get pollAlreadyVoted;

  /// No description provided for @pollSubmitVote.
  ///
  /// In en, this message translates to:
  /// **'Submit vote'**
  String get pollSubmitVote;

  /// No description provided for @financialDisputesTitle.
  ///
  /// In en, this message translates to:
  /// **'Financial disputes'**
  String get financialDisputesTitle;

  /// No description provided for @financialDisputesEmpty.
  ///
  /// In en, this message translates to:
  /// **'No financial disputes yet.'**
  String get financialDisputesEmpty;

  /// No description provided for @financialDisputeDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Financial dispute'**
  String get financialDisputeDetailTitle;

  /// No description provided for @financialDisputeTypeAndReference.
  ///
  /// In en, this message translates to:
  /// **'{type} · {reference}'**
  String financialDisputeTypeAndReference(String type, String reference);

  /// No description provided for @financialDisputeSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Submitted {date}'**
  String financialDisputeSubmitted(String date);

  /// No description provided for @financialDisputeManagementNotes.
  ///
  /// In en, this message translates to:
  /// **'Management notes'**
  String get financialDisputeManagementNotes;

  /// No description provided for @financialDisputeResolution.
  ///
  /// In en, this message translates to:
  /// **'Resolution'**
  String get financialDisputeResolution;

  /// No description provided for @createFinancialDisputeTitle.
  ///
  /// In en, this message translates to:
  /// **'New financial dispute'**
  String get createFinancialDisputeTitle;

  /// No description provided for @fieldWhatDisputing.
  ///
  /// In en, this message translates to:
  /// **'What are you disputing?'**
  String get fieldWhatDisputing;

  /// No description provided for @fieldReason.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get fieldReason;

  /// No description provided for @fieldMessage.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get fieldMessage;

  /// No description provided for @createFinancialDisputeSelectTarget.
  ///
  /// In en, this message translates to:
  /// **'Select what you want to dispute.'**
  String get createFinancialDisputeSelectTarget;

  /// No description provided for @createFinancialDisputeEnterReason.
  ///
  /// In en, this message translates to:
  /// **'Enter a reason'**
  String get createFinancialDisputeEnterReason;

  /// No description provided for @createFinancialDisputeDescribe.
  ///
  /// In en, this message translates to:
  /// **'Describe the dispute'**
  String get createFinancialDisputeDescribe;

  /// No description provided for @createFinancialDisputeSubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit dispute'**
  String get createFinancialDisputeSubmit;

  /// No description provided for @createFinancialDisputeSelectItem.
  ///
  /// In en, this message translates to:
  /// **'Select item'**
  String get createFinancialDisputeSelectItem;

  /// No description provided for @createFinancialDisputeNothingAvailable.
  ///
  /// In en, this message translates to:
  /// **'Nothing available to dispute.'**
  String get createFinancialDisputeNothingAvailable;

  /// No description provided for @createFinancialDisputeCouldNotLoad.
  ///
  /// In en, this message translates to:
  /// **'Could not load options.'**
  String get createFinancialDisputeCouldNotLoad;

  /// No description provided for @violationAppealsTitle.
  ///
  /// In en, this message translates to:
  /// **'Violation appeals'**
  String get violationAppealsTitle;

  /// No description provided for @violationAppealsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No violation appeals yet.'**
  String get violationAppealsEmpty;

  /// No description provided for @violationAppealDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Violation appeal'**
  String get violationAppealDetailTitle;

  /// No description provided for @violationAppealFineAmount.
  ///
  /// In en, this message translates to:
  /// **'Fine amount {amount}'**
  String violationAppealFineAmount(String amount);

  /// No description provided for @violationAppealReducedTo.
  ///
  /// In en, this message translates to:
  /// **'Reduced to {amount}'**
  String violationAppealReducedTo(String amount);

  /// No description provided for @createViolationAppealTitle.
  ///
  /// In en, this message translates to:
  /// **'New violation appeal'**
  String get createViolationAppealTitle;

  /// No description provided for @createViolationAppealAppealing.
  ///
  /// In en, this message translates to:
  /// **'Appealing'**
  String get createViolationAppealAppealing;

  /// No description provided for @createViolationAppealEnterReason.
  ///
  /// In en, this message translates to:
  /// **'Enter a reason'**
  String get createViolationAppealEnterReason;

  /// No description provided for @createViolationAppealExplain.
  ///
  /// In en, this message translates to:
  /// **'Explain your appeal'**
  String get createViolationAppealExplain;

  /// No description provided for @createViolationAppealSubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit appeal'**
  String get createViolationAppealSubmit;

  /// No description provided for @familyMembersTitle.
  ///
  /// In en, this message translates to:
  /// **'Family members'**
  String get familyMembersTitle;

  /// No description provided for @familyMembersEmpty.
  ///
  /// In en, this message translates to:
  /// **'No family members added yet.'**
  String get familyMembersEmpty;

  /// No description provided for @familyMemberRemoveTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove family member?'**
  String get familyMemberRemoveTitle;

  /// No description provided for @familyMemberRemoveConfirm.
  ///
  /// In en, this message translates to:
  /// **'Remove {name} from your family members?'**
  String familyMemberRemoveConfirm(String name);

  /// No description provided for @familyMemberBorn.
  ///
  /// In en, this message translates to:
  /// **'Born {date}'**
  String familyMemberBorn(String date);

  /// No description provided for @familyMemberEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit family member'**
  String get familyMemberEditTitle;

  /// No description provided for @familyMemberAddTitle.
  ///
  /// In en, this message translates to:
  /// **'Add family member'**
  String get familyMemberAddTitle;

  /// No description provided for @familyMemberSave.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get familyMemberSave;

  /// No description provided for @familyMemberAdd.
  ///
  /// In en, this message translates to:
  /// **'Add family member'**
  String get familyMemberAdd;

  /// No description provided for @fieldFullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fieldFullName;

  /// No description provided for @fieldRelationship.
  ///
  /// In en, this message translates to:
  /// **'Relationship'**
  String get fieldRelationship;

  /// No description provided for @fieldPhoneNumberOptional.
  ///
  /// In en, this message translates to:
  /// **'Phone number (optional)'**
  String get fieldPhoneNumberOptional;

  /// No description provided for @fieldDateOfBirthOptional.
  ///
  /// In en, this message translates to:
  /// **'Date of birth (optional)'**
  String get fieldDateOfBirthOptional;

  /// No description provided for @familyMemberEnterName.
  ///
  /// In en, this message translates to:
  /// **'Enter a name'**
  String get familyMemberEnterName;

  /// No description provided for @familyMemberEnterRelationship.
  ///
  /// In en, this message translates to:
  /// **'Enter a relationship'**
  String get familyMemberEnterRelationship;

  /// No description provided for @emergencyContactsTitle.
  ///
  /// In en, this message translates to:
  /// **'Emergency contacts'**
  String get emergencyContactsTitle;

  /// No description provided for @emergencyContactsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No emergency contacts added yet.'**
  String get emergencyContactsEmpty;

  /// No description provided for @emergencyContactRemoveTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove emergency contact?'**
  String get emergencyContactRemoveTitle;

  /// No description provided for @emergencyContactRemoveConfirm.
  ///
  /// In en, this message translates to:
  /// **'Remove {name} from your emergency contacts?'**
  String emergencyContactRemoveConfirm(String name);

  /// No description provided for @emergencyContactEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit emergency contact'**
  String get emergencyContactEditTitle;

  /// No description provided for @emergencyContactAddTitle.
  ///
  /// In en, this message translates to:
  /// **'Add emergency contact'**
  String get emergencyContactAddTitle;

  /// No description provided for @emergencyContactAdd.
  ///
  /// In en, this message translates to:
  /// **'Add contact'**
  String get emergencyContactAdd;

  /// No description provided for @emergencyContactEnterPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter a phone number'**
  String get emergencyContactEnterPhone;

  /// No description provided for @documentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get documentsTitle;

  /// No description provided for @documentsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No documents yet.'**
  String get documentsEmpty;

  /// No description provided for @documentMeta.
  ///
  /// In en, this message translates to:
  /// **'{category} · {size} · {date}'**
  String documentMeta(String category, String size, String date);

  /// No description provided for @documentCouldNotOpen.
  ///
  /// In en, this message translates to:
  /// **'Could not open file: {message}'**
  String documentCouldNotOpen(String message);

  /// No description provided for @accountTitle.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get accountTitle;

  /// No description provided for @accountFamilyMembers.
  ///
  /// In en, this message translates to:
  /// **'Family members'**
  String get accountFamilyMembers;

  /// No description provided for @accountEmergencyContacts.
  ///
  /// In en, this message translates to:
  /// **'Emergency contacts'**
  String get accountEmergencyContacts;

  /// No description provided for @accountDocuments.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get accountDocuments;

  /// No description provided for @accountUtilityBills.
  ///
  /// In en, this message translates to:
  /// **'Utility bills'**
  String get accountUtilityBills;

  /// No description provided for @accountRentInvoices.
  ///
  /// In en, this message translates to:
  /// **'Rent invoices'**
  String get accountRentInvoices;

  /// No description provided for @accountInstallments.
  ///
  /// In en, this message translates to:
  /// **'Installments'**
  String get accountInstallments;

  /// No description provided for @accountPaymentHistory.
  ///
  /// In en, this message translates to:
  /// **'Payment history'**
  String get accountPaymentHistory;

  /// No description provided for @accountFinancialDisputes.
  ///
  /// In en, this message translates to:
  /// **'Financial disputes'**
  String get accountFinancialDisputes;

  /// No description provided for @accountViolationFines.
  ///
  /// In en, this message translates to:
  /// **'Violation fines'**
  String get accountViolationFines;

  /// No description provided for @accountViolationAppeals.
  ///
  /// In en, this message translates to:
  /// **'Violation appeals'**
  String get accountViolationAppeals;

  /// No description provided for @accountSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get accountSettings;

  /// No description provided for @accountSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get accountSignOut;

  /// No description provided for @requestsTitle.
  ///
  /// In en, this message translates to:
  /// **'Requests'**
  String get requestsTitle;

  /// No description provided for @requestsMaintenanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Maintenance requests'**
  String get requestsMaintenanceTitle;

  /// No description provided for @requestsMaintenanceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Report an issue in your unit'**
  String get requestsMaintenanceSubtitle;

  /// No description provided for @requestsVisitorPassesTitle.
  ///
  /// In en, this message translates to:
  /// **'Visitor passes'**
  String get requestsVisitorPassesTitle;

  /// No description provided for @requestsVisitorPassesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Give a visitor gate access'**
  String get requestsVisitorPassesSubtitle;

  /// No description provided for @requestsComplaintsTitle.
  ///
  /// In en, this message translates to:
  /// **'Complaints'**
  String get requestsComplaintsTitle;

  /// No description provided for @requestsComplaintsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Raise an issue with management'**
  String get requestsComplaintsSubtitle;

  /// No description provided for @communityTitle.
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get communityTitle;

  /// No description provided for @communityAnnouncementsTab.
  ///
  /// In en, this message translates to:
  /// **'Announcements'**
  String get communityAnnouncementsTab;

  /// No description provided for @communityPollsTab.
  ///
  /// In en, this message translates to:
  /// **'Polls'**
  String get communityPollsTab;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsAppearance;

  /// No description provided for @settingsThemeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get settingsThemeSystem;

  /// No description provided for @settingsThemeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsThemeLight;

  /// No description provided for @settingsThemeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingsThemeDark;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settingsLanguageEnglish;

  /// No description provided for @settingsLanguageArabic.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get settingsLanguageArabic;

  /// No description provided for @statusUnpaid.
  ///
  /// In en, this message translates to:
  /// **'Unpaid'**
  String get statusUnpaid;

  /// No description provided for @statusPartiallyPaid.
  ///
  /// In en, this message translates to:
  /// **'Partially paid'**
  String get statusPartiallyPaid;

  /// No description provided for @statusPaid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get statusPaid;

  /// No description provided for @statusOverdue.
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get statusOverdue;

  /// No description provided for @statusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get statusCancelled;

  /// No description provided for @paymentTargetTypeUtilityBill.
  ///
  /// In en, this message translates to:
  /// **'Utility bill'**
  String get paymentTargetTypeUtilityBill;

  /// No description provided for @paymentTargetTypePropertyInstallment.
  ///
  /// In en, this message translates to:
  /// **'Property installment'**
  String get paymentTargetTypePropertyInstallment;

  /// No description provided for @paymentTargetTypeRentInvoice.
  ///
  /// In en, this message translates to:
  /// **'Rent invoice'**
  String get paymentTargetTypeRentInvoice;

  /// No description provided for @paymentTargetTypeViolationFine.
  ///
  /// In en, this message translates to:
  /// **'Violation fine'**
  String get paymentTargetTypeViolationFine;

  /// No description provided for @paymentTargetTypePaymentPlanInstallment.
  ///
  /// In en, this message translates to:
  /// **'Payment plan installment'**
  String get paymentTargetTypePaymentPlanInstallment;

  /// No description provided for @paymentTargetTypePropertySaleContract.
  ///
  /// In en, this message translates to:
  /// **'Property sale contract'**
  String get paymentTargetTypePropertySaleContract;

  /// No description provided for @announcementCategoryGeneral.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get announcementCategoryGeneral;

  /// No description provided for @announcementCategoryMaintenance.
  ///
  /// In en, this message translates to:
  /// **'Maintenance'**
  String get announcementCategoryMaintenance;

  /// No description provided for @announcementCategoryUtility.
  ///
  /// In en, this message translates to:
  /// **'Utility'**
  String get announcementCategoryUtility;

  /// No description provided for @announcementCategoryPayment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get announcementCategoryPayment;

  /// No description provided for @announcementCategorySecurity.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get announcementCategorySecurity;

  /// No description provided for @announcementCategoryEvent.
  ///
  /// In en, this message translates to:
  /// **'Event'**
  String get announcementCategoryEvent;

  /// No description provided for @announcementCategoryEmergency.
  ///
  /// In en, this message translates to:
  /// **'Emergency'**
  String get announcementCategoryEmergency;

  /// No description provided for @announcementCategoryRule.
  ///
  /// In en, this message translates to:
  /// **'Rule'**
  String get announcementCategoryRule;

  /// No description provided for @announcementCategoryOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get announcementCategoryOther;

  /// No description provided for @announcementPriorityLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get announcementPriorityLow;

  /// No description provided for @announcementPriorityNormal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get announcementPriorityNormal;

  /// No description provided for @announcementPriorityHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get announcementPriorityHigh;

  /// No description provided for @announcementPriorityCritical.
  ///
  /// In en, this message translates to:
  /// **'Critical'**
  String get announcementPriorityCritical;

  /// No description provided for @complaintStatusOpen.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get complaintStatusOpen;

  /// No description provided for @complaintStatusUnderReview.
  ///
  /// In en, this message translates to:
  /// **'Under review'**
  String get complaintStatusUnderReview;

  /// No description provided for @complaintStatusResolved.
  ///
  /// In en, this message translates to:
  /// **'Resolved'**
  String get complaintStatusResolved;

  /// No description provided for @complaintStatusRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get complaintStatusRejected;

  /// No description provided for @complaintStatusConvertedToViolation.
  ///
  /// In en, this message translates to:
  /// **'Converted to violation'**
  String get complaintStatusConvertedToViolation;

  /// No description provided for @documentApprovalStatusNotRequired.
  ///
  /// In en, this message translates to:
  /// **'Not required'**
  String get documentApprovalStatusNotRequired;

  /// No description provided for @documentApprovalStatusPendingReview.
  ///
  /// In en, this message translates to:
  /// **'Pending review'**
  String get documentApprovalStatusPendingReview;

  /// No description provided for @documentApprovalStatusApproved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get documentApprovalStatusApproved;

  /// No description provided for @documentApprovalStatusRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get documentApprovalStatusRejected;

  /// No description provided for @documentCategoryResidentIdentity.
  ///
  /// In en, this message translates to:
  /// **'Resident identity'**
  String get documentCategoryResidentIdentity;

  /// No description provided for @documentCategoryOwnershipContract.
  ///
  /// In en, this message translates to:
  /// **'Ownership contract'**
  String get documentCategoryOwnershipContract;

  /// No description provided for @documentCategoryLeaseContract.
  ///
  /// In en, this message translates to:
  /// **'Lease contract'**
  String get documentCategoryLeaseContract;

  /// No description provided for @documentCategoryPaymentReceipt.
  ///
  /// In en, this message translates to:
  /// **'Payment receipt'**
  String get documentCategoryPaymentReceipt;

  /// No description provided for @documentCategoryMaintenanceAttachment.
  ///
  /// In en, this message translates to:
  /// **'Maintenance attachment'**
  String get documentCategoryMaintenanceAttachment;

  /// No description provided for @documentCategoryComplaintAttachment.
  ///
  /// In en, this message translates to:
  /// **'Complaint attachment'**
  String get documentCategoryComplaintAttachment;

  /// No description provided for @documentCategoryViolationAttachment.
  ///
  /// In en, this message translates to:
  /// **'Violation attachment'**
  String get documentCategoryViolationAttachment;

  /// No description provided for @documentCategoryAdministrative.
  ///
  /// In en, this message translates to:
  /// **'Administrative'**
  String get documentCategoryAdministrative;

  /// No description provided for @documentCategoryOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get documentCategoryOther;

  /// No description provided for @financialDisputeStatusOpen.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get financialDisputeStatusOpen;

  /// No description provided for @financialDisputeStatusUnderReview.
  ///
  /// In en, this message translates to:
  /// **'Under review'**
  String get financialDisputeStatusUnderReview;

  /// No description provided for @financialDisputeStatusNeedResidentResponse.
  ///
  /// In en, this message translates to:
  /// **'Response needed'**
  String get financialDisputeStatusNeedResidentResponse;

  /// No description provided for @financialDisputeStatusAccepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get financialDisputeStatusAccepted;

  /// No description provided for @financialDisputeStatusRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get financialDisputeStatusRejected;

  /// No description provided for @financialDisputeStatusResolved.
  ///
  /// In en, this message translates to:
  /// **'Resolved'**
  String get financialDisputeStatusResolved;

  /// No description provided for @financialDisputeStatusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get financialDisputeStatusCancelled;

  /// No description provided for @financialDisputeTargetTypeUtilityBill.
  ///
  /// In en, this message translates to:
  /// **'Utility bill'**
  String get financialDisputeTargetTypeUtilityBill;

  /// No description provided for @financialDisputeTargetTypePayment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get financialDisputeTargetTypePayment;

  /// No description provided for @financialDisputeTargetTypeViolationFine.
  ///
  /// In en, this message translates to:
  /// **'Violation fine'**
  String get financialDisputeTargetTypeViolationFine;

  /// No description provided for @financialDisputeTargetTypeRentInvoice.
  ///
  /// In en, this message translates to:
  /// **'Rent invoice'**
  String get financialDisputeTargetTypeRentInvoice;

  /// No description provided for @financialDisputeTargetTypePropertyInstallment.
  ///
  /// In en, this message translates to:
  /// **'Installment'**
  String get financialDisputeTargetTypePropertyInstallment;

  /// No description provided for @financialDisputeTargetTypeFinancialAdjustment.
  ///
  /// In en, this message translates to:
  /// **'Financial adjustment'**
  String get financialDisputeTargetTypeFinancialAdjustment;

  /// No description provided for @maintenancePriorityLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get maintenancePriorityLow;

  /// No description provided for @maintenancePriorityMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get maintenancePriorityMedium;

  /// No description provided for @maintenancePriorityHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get maintenancePriorityHigh;

  /// No description provided for @maintenancePriorityEmergency.
  ///
  /// In en, this message translates to:
  /// **'Emergency'**
  String get maintenancePriorityEmergency;

  /// No description provided for @maintenanceStatusOpen.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get maintenanceStatusOpen;

  /// No description provided for @maintenanceStatusAssigned.
  ///
  /// In en, this message translates to:
  /// **'Assigned'**
  String get maintenanceStatusAssigned;

  /// No description provided for @maintenanceStatusInProgress.
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get maintenanceStatusInProgress;

  /// No description provided for @maintenanceStatusResolved.
  ///
  /// In en, this message translates to:
  /// **'Resolved'**
  String get maintenanceStatusResolved;

  /// No description provided for @maintenanceStatusClosed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get maintenanceStatusClosed;

  /// No description provided for @maintenanceStatusRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get maintenanceStatusRejected;

  /// No description provided for @maintenanceStatusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get maintenanceStatusCancelled;

  /// No description provided for @paymentMethodZainCash.
  ///
  /// In en, this message translates to:
  /// **'ZainCash'**
  String get paymentMethodZainCash;

  /// No description provided for @paymentMethodMasterCard.
  ///
  /// In en, this message translates to:
  /// **'MasterCard'**
  String get paymentMethodMasterCard;

  /// No description provided for @paymentMethodCash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get paymentMethodCash;

  /// No description provided for @paymentMethodBankTransfer.
  ///
  /// In en, this message translates to:
  /// **'Bank transfer'**
  String get paymentMethodBankTransfer;

  /// No description provided for @paymentMethodManualAdminPayment.
  ///
  /// In en, this message translates to:
  /// **'Admin-recorded payment'**
  String get paymentMethodManualAdminPayment;

  /// No description provided for @paymentStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get paymentStatusPending;

  /// No description provided for @paymentStatusSucceeded.
  ///
  /// In en, this message translates to:
  /// **'Succeeded'**
  String get paymentStatusSucceeded;

  /// No description provided for @paymentStatusFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get paymentStatusFailed;

  /// No description provided for @paymentStatusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get paymentStatusCancelled;

  /// No description provided for @paymentStatusRefunded.
  ///
  /// In en, this message translates to:
  /// **'Refunded'**
  String get paymentStatusRefunded;

  /// No description provided for @pollStatusDraft.
  ///
  /// In en, this message translates to:
  /// **'Draft'**
  String get pollStatusDraft;

  /// No description provided for @pollStatusOpen.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get pollStatusOpen;

  /// No description provided for @pollStatusClosed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get pollStatusClosed;

  /// No description provided for @pollStatusArchived.
  ///
  /// In en, this message translates to:
  /// **'Archived'**
  String get pollStatusArchived;

  /// No description provided for @violationAppealStatusSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Submitted'**
  String get violationAppealStatusSubmitted;

  /// No description provided for @violationAppealStatusUnderReview.
  ///
  /// In en, this message translates to:
  /// **'Under review'**
  String get violationAppealStatusUnderReview;

  /// No description provided for @violationAppealStatusNeedResidentResponse.
  ///
  /// In en, this message translates to:
  /// **'Response needed'**
  String get violationAppealStatusNeedResidentResponse;

  /// No description provided for @violationAppealStatusAccepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get violationAppealStatusAccepted;

  /// No description provided for @violationAppealStatusRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get violationAppealStatusRejected;

  /// No description provided for @violationAppealStatusFineReduced.
  ///
  /// In en, this message translates to:
  /// **'Fine reduced'**
  String get violationAppealStatusFineReduced;

  /// No description provided for @violationAppealStatusFineCancelled.
  ///
  /// In en, this message translates to:
  /// **'Fine cancelled'**
  String get violationAppealStatusFineCancelled;

  /// No description provided for @violationAppealStatusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get violationAppealStatusCancelled;

  /// No description provided for @visitorPassStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get visitorPassStatusPending;

  /// No description provided for @visitorPassStatusApproved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get visitorPassStatusApproved;

  /// No description provided for @visitorPassStatusCheckedIn.
  ///
  /// In en, this message translates to:
  /// **'Checked in'**
  String get visitorPassStatusCheckedIn;

  /// No description provided for @visitorPassStatusCheckedOut.
  ///
  /// In en, this message translates to:
  /// **'Checked out'**
  String get visitorPassStatusCheckedOut;

  /// No description provided for @visitorPassStatusExpired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get visitorPassStatusExpired;

  /// No description provided for @visitorPassStatusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get visitorPassStatusCancelled;

  /// No description provided for @visitorPassStatusDenied.
  ///
  /// In en, this message translates to:
  /// **'Denied'**
  String get visitorPassStatusDenied;

  /// No description provided for @visitorAccessActionCheckIn.
  ///
  /// In en, this message translates to:
  /// **'Checked in'**
  String get visitorAccessActionCheckIn;

  /// No description provided for @visitorAccessActionCheckOut.
  ///
  /// In en, this message translates to:
  /// **'Checked out'**
  String get visitorAccessActionCheckOut;

  /// No description provided for @visitorAccessActionDenied.
  ///
  /// In en, this message translates to:
  /// **'Denied'**
  String get visitorAccessActionDenied;

  /// No description provided for @visitorAccessActionVerified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get visitorAccessActionVerified;

  /// No description provided for @visitorAccessActionCredentialFailed.
  ///
  /// In en, this message translates to:
  /// **'Access code failed'**
  String get visitorAccessActionCredentialFailed;

  /// No description provided for @guardVisitorsTitle.
  ///
  /// In en, this message translates to:
  /// **'Today\'s visitors'**
  String get guardVisitorsTitle;

  /// No description provided for @guardVisitorsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No visitors expected today.'**
  String get guardVisitorsEmpty;

  /// No description provided for @guardVerifyCodeTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify access code'**
  String get guardVerifyCodeTitle;

  /// No description provided for @guardVerifyCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Access code'**
  String get guardVerifyCodeLabel;

  /// No description provided for @guardVerifyCodeSubmit.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get guardVerifyCodeSubmit;

  /// No description provided for @guardVisitorDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Visitor pass'**
  String get guardVisitorDetailTitle;

  /// No description provided for @guardCheckIn.
  ///
  /// In en, this message translates to:
  /// **'Check in'**
  String get guardCheckIn;

  /// No description provided for @guardCheckOut.
  ///
  /// In en, this message translates to:
  /// **'Check out'**
  String get guardCheckOut;

  /// No description provided for @guardNotesOptional.
  ///
  /// In en, this message translates to:
  /// **'Notes (optional)'**
  String get guardNotesOptional;

  /// No description provided for @guardEnterAccessCode.
  ///
  /// In en, this message translates to:
  /// **'Enter the access code'**
  String get guardEnterAccessCode;

  /// No description provided for @guardDeny.
  ///
  /// In en, this message translates to:
  /// **'Deny'**
  String get guardDeny;

  /// No description provided for @guardDenyTitle.
  ///
  /// In en, this message translates to:
  /// **'Deny entry'**
  String get guardDenyTitle;

  /// No description provided for @guardDenyReasonLabel.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get guardDenyReasonLabel;

  /// No description provided for @guardEnterDenyReason.
  ///
  /// In en, this message translates to:
  /// **'Enter a reason'**
  String get guardEnterDenyReason;

  /// No description provided for @guardAccessLogTitle.
  ///
  /// In en, this message translates to:
  /// **'Access log'**
  String get guardAccessLogTitle;

  /// No description provided for @guardAccessLogEmpty.
  ///
  /// In en, this message translates to:
  /// **'No access log entries yet.'**
  String get guardAccessLogEmpty;

  /// No description provided for @contractorStatusPendingApproval.
  ///
  /// In en, this message translates to:
  /// **'Pending approval'**
  String get contractorStatusPendingApproval;

  /// No description provided for @contractorStatusApproved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get contractorStatusApproved;

  /// No description provided for @contractorStatusDenied.
  ///
  /// In en, this message translates to:
  /// **'Denied'**
  String get contractorStatusDenied;

  /// No description provided for @contractorStatusCheckedIn.
  ///
  /// In en, this message translates to:
  /// **'Checked in'**
  String get contractorStatusCheckedIn;

  /// No description provided for @contractorStatusCheckedOut.
  ///
  /// In en, this message translates to:
  /// **'Checked out'**
  String get contractorStatusCheckedOut;

  /// No description provided for @contractorStatusClosed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get contractorStatusClosed;

  /// No description provided for @contractorStatusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get contractorStatusCancelled;

  /// No description provided for @contractorStatusExpired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get contractorStatusExpired;

  /// No description provided for @contractorRiskLevelLow.
  ///
  /// In en, this message translates to:
  /// **'Low risk'**
  String get contractorRiskLevelLow;

  /// No description provided for @contractorRiskLevelMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium risk'**
  String get contractorRiskLevelMedium;

  /// No description provided for @contractorRiskLevelHigh.
  ///
  /// In en, this message translates to:
  /// **'High risk'**
  String get contractorRiskLevelHigh;

  /// No description provided for @contractorRiskLevelCritical.
  ///
  /// In en, this message translates to:
  /// **'Critical risk'**
  String get contractorRiskLevelCritical;

  /// No description provided for @guardContractorsTitle.
  ///
  /// In en, this message translates to:
  /// **'Today\'s contractors'**
  String get guardContractorsTitle;

  /// No description provided for @guardContractorsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No contractors expected today.'**
  String get guardContractorsEmpty;

  /// No description provided for @guardContractorDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Contractor permit'**
  String get guardContractorDetailTitle;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
