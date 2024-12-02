import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/providers.dart';
import 'package:babysitterapp/src/helpers.dart';
import 'package:babysitterapp/src/models.dart';
import 'package:babysitterapp/src/views.dart';

class HelpSupportView extends HookConsumerWidget {
  const HelpSupportView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TabController tabController = useTabController(initialLength: 2);
    final ValueNotifier<double> rating = useState(0.0);
    const double starSize = 30.0;
    final UserAccount? currentUser = ref.watch(authControllerService).user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Help, Support & Feedback',
            style: TextStyle(fontSize: 20)),
        bottom: TabBar(
          indicatorColor: Colors.blue,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          controller: tabController,
          tabs: const <Widget>[
            Tab(text: 'Help & Support'),
            Tab(text: 'Feedback'),
          ],
        ),
      ),
      body: VerificationGuard(
        user: currentUser,
        child: TabBarView(
          controller: tabController,
          children: <Widget>[
            helpSupportTab(),
            feedbackTab(rating, starSize),
          ],
        ),
      ),
    );
  }
}
