import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../announcements/presentation/screens/announcements_list_screen.dart';
import '../../../polls/presentation/screens/polls_list_screen.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.communityTitle),
          bottom: TabBar(
            tabs: [
              Tab(text: l10n.communityAnnouncementsTab),
              Tab(text: l10n.communityPollsTab),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AnnouncementsListScreen(),
            PollsListScreen(),
          ],
        ),
      ),
    );
  }
}
