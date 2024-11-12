import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/views/settings.dart';

class HelpSupportPage extends HookConsumerWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TabController tabController = useTabController(initialLength: 2);
    final ValueNotifier<double> rating = useState(0.0);
    const double starSize = 30.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Help, Support & Feedback',
            style: TextStyle(fontSize: 20)),
        bottom: TabBar(
          controller: tabController,
          tabs: const <Widget>[
            Tab(text: 'Help & Support'),
            Tab(text: 'Feedback'),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          helpSupportTab(),
          feedbackTab(rating, starSize),
        ],
      ),
    );
  }
}
