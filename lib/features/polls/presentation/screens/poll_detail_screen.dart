import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_exception.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/app_snackbar.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/status_chip.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/community_poll.dart';
import '../../data/models/poll_status.dart';
import '../providers/polls_provider.dart';

class PollDetailScreen extends ConsumerStatefulWidget {
  const PollDetailScreen({super.key, required this.pollId});

  final String pollId;

  @override
  ConsumerState<PollDetailScreen> createState() => _PollDetailScreenState();
}

class _PollDetailScreenState extends ConsumerState<PollDetailScreen> {
  final Set<String> _selected = {};
  bool _isSubmitting = false;

  Future<void> _submitVote() async {
    if (_selected.isEmpty) return;

    setState(() => _isSubmitting = true);
    try {
      await ref.read(pollsApiProvider).vote(widget.pollId, _selected.toList());
      ref.invalidate(pollDetailProvider(widget.pollId));
      ref.invalidate(pollsControllerProvider);
    } on ApiException catch (e) {
      if (!mounted) return;
      showErrorSnack(context, e.message);
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final poll = ref.watch(pollDetailProvider(widget.pollId));
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.pollDetailTitle)),
      body: AsyncValueView(
        value: poll,
        onRetry: () => ref.invalidate(pollDetailProvider(widget.pollId)),
        data: (context, data) => _buildContent(context, data),
      ),
      bottomNavigationBar: poll.valueOrNull != null && !poll.value!.hasVoted && poll.value!.status == PollStatus.open
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: _isSubmitting || _selected.isEmpty ? null : _submitVote,
                  child: _isSubmitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : Text(l10n.pollSubmitVote),
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildContent(BuildContext context, CommunityPoll poll) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;
    final canVote = !poll.hasVoted && poll.status == PollStatus.open;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text(poll.question, style: Theme.of(context).textTheme.titleMedium)),
                    StatusChip(label: poll.status.label(context), color: poll.status.color(scheme)),
                  ],
                ),
                if (poll.description != null && poll.description!.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(poll.description!),
                ],
                const SizedBox(height: 12),
                Text(
                  l10n.pollOpenRange(Formatters.date(poll.startsAt), Formatters.date(poll.endsAt)),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                if (poll.allowsMultipleChoices)
                  Text(l10n.pollMultipleChoicesAllowed, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Column(
            children: poll.options.map((option) {
              final isMine = poll.selectedOptionIds.contains(option.id);
              final isChecked = poll.hasVoted ? isMine : _selected.contains(option.id);

              return poll.allowsMultipleChoices
                  ? CheckboxListTile(
                      title: Text(option.text),
                      value: isChecked,
                      onChanged: !canVote
                          ? null
                          : (checked) => setState(() {
                                if (checked ?? false) {
                                  _selected.add(option.id);
                                } else {
                                  _selected.remove(option.id);
                                }
                              }),
                      secondary: poll.hasVoted && isMine ? Icon(Icons.check_circle, color: scheme.primary) : null,
                    )
                  : RadioListTile<String>(
                      title: Text(option.text),
                      value: option.id,
                      groupValue: poll.hasVoted
                          ? (poll.selectedOptionIds.isEmpty ? null : poll.selectedOptionIds.first)
                          : (_selected.isEmpty ? null : _selected.first),
                      onChanged: !canVote
                          ? null
                          : (value) => setState(() {
                                _selected
                                  ..clear()
                                  ..add(value!);
                              }),
                    );
            }).toList(),
          ),
        ),
        if (poll.hasVoted) ...[
          const SizedBox(height: 12),
          Text(
            l10n.pollAlreadyVoted,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ],
    );
  }
}
