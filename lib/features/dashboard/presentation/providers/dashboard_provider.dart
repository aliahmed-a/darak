import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/core_providers.dart';
import '../../data/dashboard_api.dart';
import '../../data/models/resident_dashboard.dart';

final dashboardApiProvider = Provider<DashboardApi>((ref) {
  return DashboardApi(ref.watch(apiClientProvider));
});

final dashboardProvider = FutureProvider.autoDispose<ResidentDashboard>((ref) {
  return ref.watch(dashboardApiProvider).getDashboard();
});
