import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/network/api_exception.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/paged_list_view.dart';
import '../../../../core/widgets/status_chip.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/guard_visitor_pass.dart';
import '../providers/guard_visitor_access_provider.dart';

class GuardVisitorsTodayScreen extends ConsumerWidget {
  const GuardVisitorsTodayScreen({super.key});

  Future<void> _verifyCode(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final controller = TextEditingController();
    String? error;
    var isSubmitting = false;

    final pass = await showDialog<GuardVisitorPass>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text(l10n.guardVerifyCodeTitle),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controller,
                  autofocus: true,
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                    labelText: l10n.guardVerifyCodeLabel,
                    errorText: error,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(l10n.commonCancel)),
              FilledButton(
                onPressed: isSubmitting
                    ? null
                    : () async {
                        setState(() {
                          isSubmitting = true;
                          error = null;
                        });
                        try {
                          final result =
                              await ref.read(guardVisitorAccessApiProvider).verifyCode(controller.text.trim());
                          if (context.mounted) Navigator.of(context).pop(result);
                        } on ApiException catch (e) {
                          setState(() {
                            isSubmitting = false;
                            error = e.message;
                          });
                        }
                      },
                child: Text(l10n.guardVerifyCodeSubmit),
              ),
            ],
          );
        },
      ),
    );

    if (pass != null && context.mounted) {
      context.push(Routes.guardVisitorDetail(pass.id));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(guardVisitorsTodayControllerProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.guardVisitorsTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_2_outlined),
            tooltip: l10n.guardVerifyCodeTitle,
            onPressed: () => _verifyCode(context, ref),
          ),
        ],
      ),
      body: AsyncValueView(
        value: state,
        onRetry: () => ref.invalidate(guardVisitorsTodayControllerProvider),
        data: (context, data) => PagedListView(
          state: data,
          emptyMessage: l10n.guardVisitorsEmpty,
          onLoadMore: () => ref.read(guardVisitorsTodayControllerProvider.notifier).loadMore(),
          onRefresh: () => ref.read(guardVisitorsTodayControllerProvider.notifier).refresh(),
          itemBuilder: (context, pass) => _VisitorCard(pass: pass),
        ),
      ),
    );
  }
}

class _VisitorCard extends StatelessWidget {
  const _VisitorCard({required this.pass});

  final GuardVisitorPass pass;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => context.push(Routes.guardVisitorDetail(pass.id)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(pass.visitorName, style: const TextStyle(fontWeight: FontWeight.w600))),
                  StatusChip(label: pass.status.label(context), color: pass.status.color(scheme)),
                ],
              ),
              const SizedBox(height: 4),
              Text(l10n.unitAndCompound(pass.unitNumber, pass.compoundName)),
              const SizedBox(height: 8),
              Text(l10n.validDateRange(Formatters.dateTime(pass.validFrom), Formatters.dateTime(pass.validUntil))),
            ],
          ),
        ),
      ),
    );
  }
}
