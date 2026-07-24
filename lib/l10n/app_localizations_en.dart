// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'DARAK';

  @override
  String get splashTagline => 'Your compound, in your pocket';

  @override
  String get commonTryAgain => 'Try again';

  @override
  String get commonSomethingWentWrong => 'Something went wrong.';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonLoadMore => 'Load more';

  @override
  String get commonBack => 'Back';

  @override
  String get commonRemove => 'Remove';

  @override
  String get commonConfirm => 'Confirm';

  @override
  String get commonOk => 'OK';

  @override
  String get commonDone => 'Done';

  @override
  String get commonCopy => 'Copy';

  @override
  String get commonNotSet => 'Not set';

  @override
  String get commonActive => 'Active';

  @override
  String get commonInactive => 'Inactive';

  @override
  String get commonNothingHereYet => 'Nothing here yet.';

  @override
  String unitAndCompound(String unit, String compound) {
    return 'Unit $unit · $compound';
  }

  @override
  String unitOnly(String unit) {
    return 'Unit $unit';
  }

  @override
  String dueDate(String date) {
    return 'Due $date';
  }

  @override
  String validDateRange(String from, String until) {
    return 'Valid $from → $until';
  }

  @override
  String payAmount(String amount) {
    return 'Pay $amount';
  }

  @override
  String amountOverdue(String amount) {
    return '$amount overdue';
  }

  @override
  String get navHome => 'Home';

  @override
  String get navRequests => 'Requests';

  @override
  String get navCommunity => 'Community';

  @override
  String get navAccount => 'Account';

  @override
  String get navGuardVisitors => 'Visitors';

  @override
  String get navGuardContractors => 'Contractors';

  @override
  String get loginTitle => 'Sign in to your account';

  @override
  String get loginEmail => 'Email';

  @override
  String get loginPassword => 'Password';

  @override
  String get loginEnterEmail => 'Enter your email';

  @override
  String get loginEnterPassword => 'Enter your password';

  @override
  String get loginSignIn => 'Sign in';

  @override
  String get loginNoAccount => 'Don\'t have an account? Register';

  @override
  String get loginFailed => 'Login failed. Please try again.';

  @override
  String get registerTitle => 'Create account';

  @override
  String get registerFullName => 'Full name';

  @override
  String get registerEnterFullName => 'Enter your full name';

  @override
  String get registerEnterValidEmail => 'Enter a valid email';

  @override
  String get registerAtLeast8Chars => 'At least 8 characters';

  @override
  String get registerConfirmPassword => 'Confirm password';

  @override
  String get registerPasswordsDoNotMatch => 'Passwords do not match';

  @override
  String get registerSubmit => 'Register';

  @override
  String get registerReceivedTitle => 'Registration received';

  @override
  String get dashboardTitle => 'Home';

  @override
  String dashboardWelcome(String name) {
    return 'Welcome, $name';
  }

  @override
  String get dashboardTotalOutstanding => 'Total outstanding';

  @override
  String get dashboardUnpaidBills => 'Unpaid bills';

  @override
  String get dashboardRentDue => 'Rent due';

  @override
  String get dashboardInstallments => 'Installments';

  @override
  String get dashboardPayments => 'Payments';

  @override
  String get dashboardUpcomingDue => 'Upcoming due';

  @override
  String get dashboardRecentPayments => 'Recent payments';

  @override
  String get dashboardYourProperties => 'Your properties';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get notificationsMarkAllRead => 'Mark all read';

  @override
  String get notificationsEmpty => 'No notifications yet.';

  @override
  String get billsTitle => 'Utility bills';

  @override
  String get billsEmpty => 'No utility bills yet.';

  @override
  String get billDetailTitle => 'Bill detail';

  @override
  String billingCycle(String month, String year) {
    return 'Billing cycle $month/$year';
  }

  @override
  String issuedAndDue(String issued, String due) {
    return 'Issued $issued · Due $due';
  }

  @override
  String get amountSubtotal => 'Subtotal';

  @override
  String get amountPreviousBalance => 'Previous balance';

  @override
  String get amountLateFee => 'Late fee';

  @override
  String get amountDiscount => 'Discount';

  @override
  String get amountTotal => 'Total';

  @override
  String get amountPaid => 'Paid';

  @override
  String get amountRemaining => 'Remaining';

  @override
  String get amountAmount => 'Amount';

  @override
  String get lineItems => 'Line items';

  @override
  String get notes => 'Notes';

  @override
  String lineItemDetail(String description, String quantity, String price) {
    return '$description · $quantity x $price';
  }

  @override
  String get rentTitle => 'Rent invoices';

  @override
  String get rentEmpty => 'No rent invoices yet.';

  @override
  String rentPeriodUnit(String month, String year, String unit) {
    return '$month/$year · Unit $unit';
  }

  @override
  String get amountRent => 'Rent amount';

  @override
  String get installmentsTitle => 'Installments';

  @override
  String get installmentsEmpty => 'No installments yet.';

  @override
  String installmentNumber(String number) {
    return 'Installment #$number';
  }

  @override
  String get fieldDueDate => 'Due date';

  @override
  String get violationFinesTitle => 'Violation fines';

  @override
  String get violationFinesEmpty => 'No violation fines.';

  @override
  String get violationFineDetailTitle => 'Violation fine';

  @override
  String get violationFineAppeal => 'Appeal';

  @override
  String get violationFineCancellationReason => 'Cancellation reason';

  @override
  String get paymentsTitle => 'Payments';

  @override
  String get paymentsEmpty => 'No payments yet.';

  @override
  String get paymentDetailTitle => 'Payment detail';

  @override
  String paymentTypeAndMethod(String type, String method) {
    return '$type · $method';
  }

  @override
  String paymentCreated(String date) {
    return 'Created $date';
  }

  @override
  String paymentCompleted(String date) {
    return 'Completed $date';
  }

  @override
  String paymentIssued(String date) {
    return 'Issued $date';
  }

  @override
  String get paymentAttempts => 'Attempts';

  @override
  String get startPaymentTitle => 'Pay now';

  @override
  String get startPaymentMethod => 'Payment method';

  @override
  String get startPaymentSimulateSuccess => 'Simulate success';

  @override
  String get startPaymentSimulateFailure => 'Simulate failure';

  @override
  String startPaymentDemoGateway(String method) {
    return '$method demo gateway';
  }

  @override
  String get startPaymentMockNotice =>
      'This is a mock provider used for the demo backend. Simulate the outcome below.';

  @override
  String get maintenanceTitle => 'Maintenance requests';

  @override
  String get maintenanceEmpty => 'No maintenance requests yet.';

  @override
  String get maintenanceDetailTitle => 'Maintenance request';

  @override
  String get maintenanceCancelRequest => 'Cancel request';

  @override
  String get maintenanceCloseRequest => 'Close request';

  @override
  String get maintenanceNotesOptional => 'Notes (optional)';

  @override
  String get maintenanceResolutionNotes => 'Resolution notes';

  @override
  String get maintenanceCostEstimate => 'Cost estimate';

  @override
  String get maintenanceActualCost => 'Actual cost';

  @override
  String get maintenanceTimeline => 'Timeline';

  @override
  String maintenanceAssignedTo(String name) {
    return 'Assigned to $name';
  }

  @override
  String get maintenanceTimelineCreated => 'Created';

  @override
  String get maintenanceTimelineAssigned => 'Assigned';

  @override
  String get maintenanceTimelineStarted => 'Started';

  @override
  String get maintenanceTimelineResolved => 'Resolved';

  @override
  String get maintenanceTimelineClosed => 'Closed';

  @override
  String get maintenanceTimelineCancelled => 'Cancelled';

  @override
  String get createMaintenanceTitle => 'New maintenance request';

  @override
  String get fieldProperty => 'Property';

  @override
  String get fieldTitle => 'Title';

  @override
  String get fieldDescription => 'Description';

  @override
  String get fieldPriority => 'Priority';

  @override
  String get createMaintenanceEnterTitle => 'Enter a title';

  @override
  String get createMaintenanceDescribeIssue => 'Describe the issue';

  @override
  String get createMaintenanceSubmit => 'Submit request';

  @override
  String get visitorPassesTitle => 'Visitor passes';

  @override
  String get visitorPassesEmpty => 'No visitor passes yet.';

  @override
  String get visitorPassDetailTitle => 'Visitor pass';

  @override
  String get visitorPassCancelConfirmTitle => 'Cancel visitor pass?';

  @override
  String get visitorPassCancelConfirmBody =>
      'The access code will no longer be valid at the gate.';

  @override
  String get visitorPassCancelPass => 'Cancel pass';

  @override
  String get visitorPassAccessCode => 'Access code';

  @override
  String get visitorPassAccessCodeNotice =>
      'For security, the code is only shown once, right after you create the pass.';

  @override
  String visitorPassCheckedIn(String date) {
    return 'Checked in $date';
  }

  @override
  String visitorPassCheckedOut(String date) {
    return 'Checked out $date';
  }

  @override
  String get createVisitorPassTitle => 'New visitor pass';

  @override
  String get fieldVisitorName => 'Visitor\'s name';

  @override
  String get fieldPhoneNumber => 'Phone number';

  @override
  String get fieldReasonForVisit => 'Reason for visit';

  @override
  String get fieldValidFrom => 'Valid from';

  @override
  String get fieldValidUntil => 'Valid until';

  @override
  String get createVisitorPassEnterName => 'Enter a name';

  @override
  String get createVisitorPassEnterPhone => 'Enter a phone number';

  @override
  String get createVisitorPassEnterReason => 'Enter a reason';

  @override
  String get createVisitorPassSubmit => 'Create pass';

  @override
  String get createVisitorPassValidUntilError =>
      'Valid until must be after valid from.';

  @override
  String get createVisitorPassCreatedTitle => 'Visitor pass created';

  @override
  String get createVisitorPassCreatedBody =>
      'Share this access code with your visitor now — it will only be shown this once.';

  @override
  String get createVisitorPassCodeCopied => 'Access code copied';

  @override
  String get complaintsTitle => 'Complaints';

  @override
  String get complaintsEmpty => 'No complaints yet.';

  @override
  String get complaintDetailTitle => 'Complaint';

  @override
  String get complaintManagementResponse => 'Management response';

  @override
  String get createComplaintTitle => 'New complaint';

  @override
  String get fieldPropertyOptional => 'Property (optional)';

  @override
  String get fieldPropertyGeneral => 'General / not unit-specific';

  @override
  String get createComplaintDescribe => 'Describe your complaint';

  @override
  String get createComplaintSubmit => 'Submit complaint';

  @override
  String get announcementsEmpty => 'No announcements yet.';

  @override
  String get announcementDetailTitle => 'Announcement';

  @override
  String announcementExpires(String date) {
    return 'Expires $date';
  }

  @override
  String get pollsEmpty => 'No open polls right now.';

  @override
  String get pollDetailTitle => 'Poll';

  @override
  String pollCloses(String date) {
    return 'Closes $date';
  }

  @override
  String get pollVoted => 'Voted';

  @override
  String pollOpenRange(String from, String to) {
    return 'Open $from → $to';
  }

  @override
  String get pollMultipleChoicesAllowed => 'Multiple choices allowed';

  @override
  String get pollAlreadyVoted => 'You already voted in this poll.';

  @override
  String get pollSubmitVote => 'Submit vote';

  @override
  String get financialDisputesTitle => 'Financial disputes';

  @override
  String get financialDisputesEmpty => 'No financial disputes yet.';

  @override
  String get financialDisputeDetailTitle => 'Financial dispute';

  @override
  String financialDisputeTypeAndReference(String type, String reference) {
    return '$type · $reference';
  }

  @override
  String financialDisputeSubmitted(String date) {
    return 'Submitted $date';
  }

  @override
  String get financialDisputeManagementNotes => 'Management notes';

  @override
  String get financialDisputeResolution => 'Resolution';

  @override
  String get createFinancialDisputeTitle => 'New financial dispute';

  @override
  String get fieldWhatDisputing => 'What are you disputing?';

  @override
  String get fieldReason => 'Reason';

  @override
  String get fieldMessage => 'Message';

  @override
  String get createFinancialDisputeSelectTarget =>
      'Select what you want to dispute.';

  @override
  String get createFinancialDisputeEnterReason => 'Enter a reason';

  @override
  String get createFinancialDisputeDescribe => 'Describe the dispute';

  @override
  String get createFinancialDisputeSubmit => 'Submit dispute';

  @override
  String get createFinancialDisputeSelectItem => 'Select item';

  @override
  String get createFinancialDisputeNothingAvailable =>
      'Nothing available to dispute.';

  @override
  String get createFinancialDisputeCouldNotLoad => 'Could not load options.';

  @override
  String get violationAppealsTitle => 'Violation appeals';

  @override
  String get violationAppealsEmpty => 'No violation appeals yet.';

  @override
  String get violationAppealDetailTitle => 'Violation appeal';

  @override
  String violationAppealFineAmount(String amount) {
    return 'Fine amount $amount';
  }

  @override
  String violationAppealReducedTo(String amount) {
    return 'Reduced to $amount';
  }

  @override
  String get createViolationAppealTitle => 'New violation appeal';

  @override
  String get createViolationAppealAppealing => 'Appealing';

  @override
  String get createViolationAppealEnterReason => 'Enter a reason';

  @override
  String get createViolationAppealExplain => 'Explain your appeal';

  @override
  String get createViolationAppealSubmit => 'Submit appeal';

  @override
  String get familyMembersTitle => 'Family members';

  @override
  String get familyMembersEmpty => 'No family members added yet.';

  @override
  String get familyMemberRemoveTitle => 'Remove family member?';

  @override
  String familyMemberRemoveConfirm(String name) {
    return 'Remove $name from your family members?';
  }

  @override
  String familyMemberBorn(String date) {
    return 'Born $date';
  }

  @override
  String get familyMemberEditTitle => 'Edit family member';

  @override
  String get familyMemberAddTitle => 'Add family member';

  @override
  String get familyMemberSave => 'Save changes';

  @override
  String get familyMemberAdd => 'Add family member';

  @override
  String get fieldFullName => 'Full name';

  @override
  String get fieldRelationship => 'Relationship';

  @override
  String get fieldPhoneNumberOptional => 'Phone number (optional)';

  @override
  String get fieldDateOfBirthOptional => 'Date of birth (optional)';

  @override
  String get familyMemberEnterName => 'Enter a name';

  @override
  String get familyMemberEnterRelationship => 'Enter a relationship';

  @override
  String get emergencyContactsTitle => 'Emergency contacts';

  @override
  String get emergencyContactsEmpty => 'No emergency contacts added yet.';

  @override
  String get emergencyContactRemoveTitle => 'Remove emergency contact?';

  @override
  String emergencyContactRemoveConfirm(String name) {
    return 'Remove $name from your emergency contacts?';
  }

  @override
  String get emergencyContactEditTitle => 'Edit emergency contact';

  @override
  String get emergencyContactAddTitle => 'Add emergency contact';

  @override
  String get emergencyContactAdd => 'Add contact';

  @override
  String get emergencyContactEnterPhone => 'Enter a phone number';

  @override
  String get documentsTitle => 'Documents';

  @override
  String get documentsEmpty => 'No documents yet.';

  @override
  String documentMeta(String category, String size, String date) {
    return '$category · $size · $date';
  }

  @override
  String documentCouldNotOpen(String message) {
    return 'Could not open file: $message';
  }

  @override
  String get accountTitle => 'Account';

  @override
  String get accountFamilyMembers => 'Family members';

  @override
  String get accountEmergencyContacts => 'Emergency contacts';

  @override
  String get accountDocuments => 'Documents';

  @override
  String get accountUtilityBills => 'Utility bills';

  @override
  String get accountRentInvoices => 'Rent invoices';

  @override
  String get accountInstallments => 'Installments';

  @override
  String get accountPaymentHistory => 'Payment history';

  @override
  String get accountFinancialDisputes => 'Financial disputes';

  @override
  String get accountViolationFines => 'Violation fines';

  @override
  String get accountViolationAppeals => 'Violation appeals';

  @override
  String get accountSettings => 'Settings';

  @override
  String get accountSignOut => 'Sign out';

  @override
  String get requestsTitle => 'Requests';

  @override
  String get requestsMaintenanceTitle => 'Maintenance requests';

  @override
  String get requestsMaintenanceSubtitle => 'Report an issue in your unit';

  @override
  String get requestsVisitorPassesTitle => 'Visitor passes';

  @override
  String get requestsVisitorPassesSubtitle => 'Give a visitor gate access';

  @override
  String get requestsComplaintsTitle => 'Complaints';

  @override
  String get requestsComplaintsSubtitle => 'Raise an issue with management';

  @override
  String get communityTitle => 'Community';

  @override
  String get communityAnnouncementsTab => 'Announcements';

  @override
  String get communityPollsTab => 'Polls';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsThemeSystem => 'System';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeDark => 'Dark';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get settingsLanguageArabic => 'العربية';

  @override
  String get statusUnpaid => 'Unpaid';

  @override
  String get statusPartiallyPaid => 'Partially paid';

  @override
  String get statusPaid => 'Paid';

  @override
  String get statusOverdue => 'Overdue';

  @override
  String get statusCancelled => 'Cancelled';

  @override
  String get paymentTargetTypeUtilityBill => 'Utility bill';

  @override
  String get paymentTargetTypePropertyInstallment => 'Property installment';

  @override
  String get paymentTargetTypeRentInvoice => 'Rent invoice';

  @override
  String get paymentTargetTypeViolationFine => 'Violation fine';

  @override
  String get paymentTargetTypePaymentPlanInstallment =>
      'Payment plan installment';

  @override
  String get paymentTargetTypePropertySaleContract => 'Property sale contract';

  @override
  String get announcementCategoryGeneral => 'General';

  @override
  String get announcementCategoryMaintenance => 'Maintenance';

  @override
  String get announcementCategoryUtility => 'Utility';

  @override
  String get announcementCategoryPayment => 'Payment';

  @override
  String get announcementCategorySecurity => 'Security';

  @override
  String get announcementCategoryEvent => 'Event';

  @override
  String get announcementCategoryEmergency => 'Emergency';

  @override
  String get announcementCategoryRule => 'Rule';

  @override
  String get announcementCategoryOther => 'Other';

  @override
  String get announcementPriorityLow => 'Low';

  @override
  String get announcementPriorityNormal => 'Normal';

  @override
  String get announcementPriorityHigh => 'High';

  @override
  String get announcementPriorityCritical => 'Critical';

  @override
  String get complaintStatusOpen => 'Open';

  @override
  String get complaintStatusUnderReview => 'Under review';

  @override
  String get complaintStatusResolved => 'Resolved';

  @override
  String get complaintStatusRejected => 'Rejected';

  @override
  String get complaintStatusConvertedToViolation => 'Converted to violation';

  @override
  String get documentApprovalStatusNotRequired => 'Not required';

  @override
  String get documentApprovalStatusPendingReview => 'Pending review';

  @override
  String get documentApprovalStatusApproved => 'Approved';

  @override
  String get documentApprovalStatusRejected => 'Rejected';

  @override
  String get documentCategoryResidentIdentity => 'Resident identity';

  @override
  String get documentCategoryOwnershipContract => 'Ownership contract';

  @override
  String get documentCategoryLeaseContract => 'Lease contract';

  @override
  String get documentCategoryPaymentReceipt => 'Payment receipt';

  @override
  String get documentCategoryMaintenanceAttachment => 'Maintenance attachment';

  @override
  String get documentCategoryComplaintAttachment => 'Complaint attachment';

  @override
  String get documentCategoryViolationAttachment => 'Violation attachment';

  @override
  String get documentCategoryAdministrative => 'Administrative';

  @override
  String get documentCategoryOther => 'Other';

  @override
  String get financialDisputeStatusOpen => 'Open';

  @override
  String get financialDisputeStatusUnderReview => 'Under review';

  @override
  String get financialDisputeStatusNeedResidentResponse => 'Response needed';

  @override
  String get financialDisputeStatusAccepted => 'Accepted';

  @override
  String get financialDisputeStatusRejected => 'Rejected';

  @override
  String get financialDisputeStatusResolved => 'Resolved';

  @override
  String get financialDisputeStatusCancelled => 'Cancelled';

  @override
  String get financialDisputeTargetTypeUtilityBill => 'Utility bill';

  @override
  String get financialDisputeTargetTypePayment => 'Payment';

  @override
  String get financialDisputeTargetTypeViolationFine => 'Violation fine';

  @override
  String get financialDisputeTargetTypeRentInvoice => 'Rent invoice';

  @override
  String get financialDisputeTargetTypePropertyInstallment => 'Installment';

  @override
  String get financialDisputeTargetTypeFinancialAdjustment =>
      'Financial adjustment';

  @override
  String get maintenancePriorityLow => 'Low';

  @override
  String get maintenancePriorityMedium => 'Medium';

  @override
  String get maintenancePriorityHigh => 'High';

  @override
  String get maintenancePriorityEmergency => 'Emergency';

  @override
  String get maintenanceStatusOpen => 'Open';

  @override
  String get maintenanceStatusAssigned => 'Assigned';

  @override
  String get maintenanceStatusInProgress => 'In progress';

  @override
  String get maintenanceStatusResolved => 'Resolved';

  @override
  String get maintenanceStatusClosed => 'Closed';

  @override
  String get maintenanceStatusRejected => 'Rejected';

  @override
  String get maintenanceStatusCancelled => 'Cancelled';

  @override
  String get paymentMethodZainCash => 'ZainCash';

  @override
  String get paymentMethodMasterCard => 'MasterCard';

  @override
  String get paymentMethodCash => 'Cash';

  @override
  String get paymentMethodBankTransfer => 'Bank transfer';

  @override
  String get paymentMethodManualAdminPayment => 'Admin-recorded payment';

  @override
  String get paymentStatusPending => 'Pending';

  @override
  String get paymentStatusSucceeded => 'Succeeded';

  @override
  String get paymentStatusFailed => 'Failed';

  @override
  String get paymentStatusCancelled => 'Cancelled';

  @override
  String get paymentStatusRefunded => 'Refunded';

  @override
  String get pollStatusDraft => 'Draft';

  @override
  String get pollStatusOpen => 'Open';

  @override
  String get pollStatusClosed => 'Closed';

  @override
  String get pollStatusArchived => 'Archived';

  @override
  String get violationAppealStatusSubmitted => 'Submitted';

  @override
  String get violationAppealStatusUnderReview => 'Under review';

  @override
  String get violationAppealStatusNeedResidentResponse => 'Response needed';

  @override
  String get violationAppealStatusAccepted => 'Accepted';

  @override
  String get violationAppealStatusRejected => 'Rejected';

  @override
  String get violationAppealStatusFineReduced => 'Fine reduced';

  @override
  String get violationAppealStatusFineCancelled => 'Fine cancelled';

  @override
  String get violationAppealStatusCancelled => 'Cancelled';

  @override
  String get visitorPassStatusPending => 'Pending';

  @override
  String get visitorPassStatusApproved => 'Approved';

  @override
  String get visitorPassStatusCheckedIn => 'Checked in';

  @override
  String get visitorPassStatusCheckedOut => 'Checked out';

  @override
  String get visitorPassStatusExpired => 'Expired';

  @override
  String get visitorPassStatusCancelled => 'Cancelled';

  @override
  String get visitorPassStatusDenied => 'Denied';

  @override
  String get visitorAccessActionCheckIn => 'Checked in';

  @override
  String get visitorAccessActionCheckOut => 'Checked out';

  @override
  String get visitorAccessActionDenied => 'Denied';

  @override
  String get visitorAccessActionVerified => 'Verified';

  @override
  String get visitorAccessActionCredentialFailed => 'Access code failed';

  @override
  String get guardVisitorsTitle => 'Today\'s visitors';

  @override
  String get guardVisitorsEmpty => 'No visitors expected today.';

  @override
  String get guardVerifyCodeTitle => 'Verify access code';

  @override
  String get guardVerifyCodeLabel => 'Access code';

  @override
  String get guardVerifyCodeSubmit => 'Verify';

  @override
  String get guardVisitorDetailTitle => 'Visitor pass';

  @override
  String get guardCheckIn => 'Check in';

  @override
  String get guardCheckOut => 'Check out';

  @override
  String get guardNotesOptional => 'Notes (optional)';

  @override
  String get guardEnterAccessCode => 'Enter the access code';

  @override
  String get guardDeny => 'Deny';

  @override
  String get guardDenyTitle => 'Deny entry';

  @override
  String get guardDenyReasonLabel => 'Reason';

  @override
  String get guardEnterDenyReason => 'Enter a reason';

  @override
  String get guardAccessLogTitle => 'Access log';

  @override
  String get guardAccessLogEmpty => 'No access log entries yet.';

  @override
  String get contractorStatusPendingApproval => 'Pending approval';

  @override
  String get contractorStatusApproved => 'Approved';

  @override
  String get contractorStatusDenied => 'Denied';

  @override
  String get contractorStatusCheckedIn => 'Checked in';

  @override
  String get contractorStatusCheckedOut => 'Checked out';

  @override
  String get contractorStatusClosed => 'Closed';

  @override
  String get contractorStatusCancelled => 'Cancelled';

  @override
  String get contractorStatusExpired => 'Expired';

  @override
  String get contractorRiskLevelLow => 'Low risk';

  @override
  String get contractorRiskLevelMedium => 'Medium risk';

  @override
  String get contractorRiskLevelHigh => 'High risk';

  @override
  String get contractorRiskLevelCritical => 'Critical risk';

  @override
  String get guardContractorsTitle => 'Today\'s contractors';

  @override
  String get guardContractorsEmpty => 'No contractors expected today.';

  @override
  String get guardContractorDetailTitle => 'Contractor permit';
}
