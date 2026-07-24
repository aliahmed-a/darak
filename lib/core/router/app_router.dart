import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/account/presentation/screens/bill_detail_screen.dart';
import '../../features/account/presentation/screens/bills_list_screen.dart';
import '../../features/account/presentation/screens/installments_list_screen.dart';
import '../../features/account/presentation/screens/rent_list_screen.dart';
import '../../features/account/presentation/screens/violation_fine_detail_screen.dart';
import '../../features/account/presentation/screens/violation_fines_list_screen.dart';
import '../../features/announcements/presentation/screens/announcement_detail_screen.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/complaints/presentation/screens/complaint_detail_screen.dart';
import '../../features/documents/presentation/screens/documents_list_screen.dart';
import '../../features/complaints/presentation/screens/complaints_list_screen.dart';
import '../../features/complaints/presentation/screens/create_complaint_screen.dart';
import '../../features/family_contacts/data/models/emergency_contact.dart';
import '../../features/family_contacts/data/models/family_member.dart';
import '../../features/family_contacts/presentation/screens/emergency_contact_form_screen.dart';
import '../../features/family_contacts/presentation/screens/emergency_contacts_screen.dart';
import '../../features/family_contacts/presentation/screens/family_member_form_screen.dart';
import '../../features/family_contacts/presentation/screens/family_members_screen.dart';
import '../../features/financial_disputes/presentation/screens/create_financial_dispute_screen.dart';
import '../../features/financial_disputes/presentation/screens/financial_dispute_detail_screen.dart';
import '../../features/financial_disputes/presentation/screens/financial_disputes_list_screen.dart';
import '../../features/maintenance/presentation/screens/create_maintenance_request_screen.dart';
import '../../features/maintenance/presentation/screens/maintenance_detail_screen.dart';
import '../../features/maintenance/presentation/screens/maintenance_list_screen.dart';
import '../../features/notifications/presentation/screens/notifications_list_screen.dart';
import '../../features/payments/presentation/screens/payment_detail_screen.dart';
import '../../features/payments/presentation/screens/payments_list_screen.dart';
import '../../features/payments/presentation/screens/start_payment_screen.dart';
import '../../features/polls/presentation/screens/poll_detail_screen.dart';
import '../../features/guard/data/models/guard_contractor_permit.dart';
import '../../features/guard/presentation/screens/guard_contractor_detail_screen.dart';
import '../../features/guard/presentation/screens/guard_visitor_detail_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/shell/presentation/screens/guard_shell.dart';
import '../../features/shell/presentation/screens/resident_shell.dart';
import '../../features/visitor_passes/presentation/screens/create_visitor_pass_screen.dart';
import '../../features/visitor_passes/presentation/screens/visitor_pass_detail_screen.dart';
import '../../features/violation_appeals/data/models/violation_appeal_target.dart';
import '../../features/violation_appeals/presentation/screens/create_violation_appeal_screen.dart';
import '../../features/violation_appeals/presentation/screens/violation_appeal_detail_screen.dart';
import '../../features/violation_appeals/presentation/screens/violation_appeals_list_screen.dart';
import '../../features/visitor_passes/presentation/screens/visitor_passes_list_screen.dart';
import '../models/payment_target.dart';
import '../widgets/splash_screen.dart';
import 'routes.dart';

/// Bridges auth-state changes into a [Listenable] so go_router re-evaluates
/// its redirect logic whenever the signed-in resident changes.
class _RouterRefreshNotifier extends ChangeNotifier {
  _RouterRefreshNotifier(Ref ref) {
    ref.listen(authControllerProvider, (_, __) => notifyListeners());
  }
}

final _routerRefreshProvider = Provider<_RouterRefreshNotifier>((ref) {
  final notifier = _RouterRefreshNotifier(ref);
  ref.onDispose(notifier.dispose);
  return notifier;
});

final appRouterProvider = Provider<GoRouter>((ref) {
  final refreshNotifier = ref.watch(_routerRefreshProvider);

  return GoRouter(
    initialLocation: Routes.splash,
    refreshListenable: refreshNotifier,
    redirect: (context, state) {
      final authState = ref.read(authControllerProvider);
      final isRestoringSession = authState.isLoading && !authState.hasValue;
      final isLoggedIn = authState.valueOrNull != null;

      final goingToSplash = state.matchedLocation == Routes.splash;
      final goingToLogin = state.matchedLocation == Routes.login;
      final goingToRegister = state.matchedLocation == Routes.register;

      if (isRestoringSession) {
        return goingToSplash ? null : Routes.splash;
      }
      if (!isLoggedIn) {
        return (goingToLogin || goingToRegister) ? null : Routes.login;
      }
      if (goingToLogin || goingToSplash || goingToRegister) {
        final user = authState.valueOrNull!;
        return user.isGuard ? Routes.guardHome : Routes.home;
      }
      return null;
    },
    routes: [
      GoRoute(path: Routes.splash, builder: (context, state) => const SplashScreen()),
      GoRoute(path: Routes.login, builder: (context, state) => const LoginScreen()),
      GoRoute(path: Routes.register, builder: (context, state) => const RegisterScreen()),
      GoRoute(path: Routes.home, builder: (context, state) => const ResidentShell()),
      GoRoute(path: Routes.guardHome, builder: (context, state) => const GuardShell()),
      GoRoute(
        path: Routes.guardVisitorDetailPattern,
        builder: (context, state) => GuardVisitorDetailScreen(passId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: Routes.guardContractorDetailPattern,
        builder: (context, state) => GuardContractorDetailScreen(permit: state.extra as GuardContractorPermit),
      ),
      GoRoute(path: Routes.notifications, builder: (context, state) => const NotificationsListScreen()),
      GoRoute(
        path: Routes.announcementDetailPattern,
        builder: (context, state) => AnnouncementDetailScreen(announcementId: state.pathParameters['id']!),
      ),
      GoRoute(path: Routes.bills, builder: (context, state) => const BillsListScreen()),
      GoRoute(
        path: Routes.billDetailPattern,
        builder: (context, state) => BillDetailScreen(billId: state.pathParameters['id']!),
      ),
      GoRoute(path: Routes.rent, builder: (context, state) => const RentListScreen()),
      GoRoute(path: Routes.installments, builder: (context, state) => const InstallmentsListScreen()),
      GoRoute(path: Routes.payments, builder: (context, state) => const PaymentsListScreen()),
      GoRoute(
        path: Routes.startPayment,
        builder: (context, state) => StartPaymentScreen(target: state.extra as PaymentTarget),
      ),
      GoRoute(
        path: Routes.paymentDetailPattern,
        builder: (context, state) => PaymentDetailScreen(paymentId: state.pathParameters['id']!),
      ),
      GoRoute(path: Routes.maintenance, builder: (context, state) => const MaintenanceListScreen()),
      GoRoute(path: Routes.createMaintenance, builder: (context, state) => const CreateMaintenanceRequestScreen()),
      GoRoute(
        path: Routes.maintenanceDetailPattern,
        builder: (context, state) => MaintenanceDetailScreen(requestId: state.pathParameters['id']!),
      ),
      GoRoute(path: Routes.visitorPasses, builder: (context, state) => const VisitorPassesListScreen()),
      GoRoute(path: Routes.createVisitorPass, builder: (context, state) => const CreateVisitorPassScreen()),
      GoRoute(
        path: Routes.visitorPassDetailPattern,
        builder: (context, state) => VisitorPassDetailScreen(passId: state.pathParameters['id']!),
      ),
      GoRoute(path: Routes.complaints, builder: (context, state) => const ComplaintsListScreen()),
      GoRoute(path: Routes.createComplaint, builder: (context, state) => const CreateComplaintScreen()),
      GoRoute(
        path: Routes.complaintDetailPattern,
        builder: (context, state) => ComplaintDetailScreen(complaintId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: Routes.pollDetailPattern,
        builder: (context, state) => PollDetailScreen(pollId: state.pathParameters['id']!),
      ),
      GoRoute(path: Routes.financialDisputes, builder: (context, state) => const FinancialDisputesListScreen()),
      GoRoute(
        path: Routes.createFinancialDispute,
        builder: (context, state) => const CreateFinancialDisputeScreen(),
      ),
      GoRoute(
        path: Routes.financialDisputeDetailPattern,
        builder: (context, state) => FinancialDisputeDetailScreen(disputeId: state.pathParameters['id']!),
      ),
      GoRoute(path: Routes.violationFines, builder: (context, state) => const ViolationFinesListScreen()),
      GoRoute(
        path: Routes.violationFineDetailPattern,
        builder: (context, state) => ViolationFineDetailScreen(fineId: state.pathParameters['id']!),
      ),
      GoRoute(path: Routes.violationAppeals, builder: (context, state) => const ViolationAppealsListScreen()),
      GoRoute(
        path: Routes.createViolationAppeal,
        builder: (context, state) => CreateViolationAppealScreen(target: state.extra as ViolationAppealTarget),
      ),
      GoRoute(
        path: Routes.violationAppealDetailPattern,
        builder: (context, state) => ViolationAppealDetailScreen(appealId: state.pathParameters['id']!),
      ),
      GoRoute(path: Routes.familyMembers, builder: (context, state) => const FamilyMembersScreen()),
      GoRoute(
        path: Routes.familyMemberForm,
        builder: (context, state) => FamilyMemberFormScreen(existing: state.extra as FamilyMember?),
      ),
      GoRoute(path: Routes.emergencyContacts, builder: (context, state) => const EmergencyContactsScreen()),
      GoRoute(
        path: Routes.emergencyContactForm,
        builder: (context, state) => EmergencyContactFormScreen(existing: state.extra as EmergencyContact?),
      ),
      GoRoute(path: Routes.documents, builder: (context, state) => const DocumentsListScreen()),
      GoRoute(path: Routes.settings, builder: (context, state) => const SettingsScreen()),
    ],
  );
});
