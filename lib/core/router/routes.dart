class Routes {
  Routes._();

  static const splash = '/';
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';

  static const notifications = '/notifications';

  static const announcements = '/announcements';
  static const announcementDetailPattern = '/announcements/:id';
  static String announcementDetail(String id) => '/announcements/$id';

  static const bills = '/bills';
  static const billDetailPattern = '/bills/:id';
  static String billDetail(String id) => '/bills/$id';

  // Rent invoices and installments have no detail endpoint on the backend —
  // the list response already carries every field, so taps open a bottom
  // sheet instead of a separate route.
  static const rent = '/rent';
  static const installments = '/installments';

  static const payments = '/payments';
  static const paymentDetailPattern = '/payments/:id';
  static String paymentDetail(String id) => '/payments/$id';
  static const startPayment = '/payments/start';

  static const maintenance = '/maintenance';
  static const maintenanceDetailPattern = '/maintenance/:id';
  static String maintenanceDetail(String id) => '/maintenance/$id';
  static const createMaintenance = '/maintenance/new';

  static const visitorPasses = '/visitor-passes';
  static const visitorPassDetailPattern = '/visitor-passes/:id';
  static String visitorPassDetail(String id) => '/visitor-passes/$id';
  static const createVisitorPass = '/visitor-passes/new';

  static const complaints = '/complaints';
  static const createComplaint = '/complaints/new';
  static const complaintDetailPattern = '/complaints/:id';
  static String complaintDetail(String id) => '/complaints/$id';

  static const pollDetailPattern = '/polls/:id';
  static String pollDetail(String id) => '/polls/$id';

  static const financialDisputes = '/financial-disputes';
  static const createFinancialDispute = '/financial-disputes/new';
  static const financialDisputeDetailPattern = '/financial-disputes/:id';
  static String financialDisputeDetail(String id) => '/financial-disputes/$id';

  static const violationFines = '/violation-fines';
  static const violationFineDetailPattern = '/violation-fines/:id';
  static String violationFineDetail(String id) => '/violation-fines/$id';

  static const violationAppeals = '/violation-appeals';
  static const createViolationAppeal = '/violation-appeals/new';
  static const violationAppealDetailPattern = '/violation-appeals/:id';
  static String violationAppealDetail(String id) => '/violation-appeals/$id';

  static const familyMembers = '/family-members';
  static const familyMemberForm = '/family-members/form';

  static const emergencyContacts = '/emergency-contacts';
  static const emergencyContactForm = '/emergency-contacts/form';

  static const documents = '/documents';

  static const settings = '/settings';

  static const guardHome = '/guard';
  static const guardVisitorDetailPattern = '/guard/visitors/:id';
  static String guardVisitorDetail(String id) => '/guard/visitors/$id';
  static const guardContractorDetailPattern = '/guard/contractors/:id';
  static String guardContractorDetail(String id) => '/guard/contractors/$id';
}
