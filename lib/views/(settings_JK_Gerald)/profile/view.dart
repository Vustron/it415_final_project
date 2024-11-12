import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/core/constants.dart';

import 'package:babysitterapp/views/settings.dart';

class Profile extends HookConsumerWidget with GlobalStyles {
  Profile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size width = MediaQuery.of(context).size;
    final ScrollController scrollController = useScrollController();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 300,
        leadingWidth: width.width,
        elevation: 3,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        shadowColor: const Color.fromARGB(176, 0, 0, 0),
        leading: Container(
          padding: GlobalStyles.defaultContentPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              profileHeader(GlobalStyles.primaryButtonColor),
              const SizedBox(
                height: 15,
              ),
              messageButton(GlobalStyles.primaryButtonColor),
              const SizedBox(height: 10)
            ],
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
      ),
      body: ListView(
        controller: scrollController,
        children: <Widget>[
          Container(
            padding: GlobalStyles.defaultContentPadding,
            child: Column(
              children: <Widget>[
                DescriptionsPage(),
                const SizedBox(
                  height: GlobalStyles.defaultPadding,
                ),
                ExperienceDetails(),
                const SizedBox(
                  height: GlobalStyles.defaultPadding,
                ),
                AvailabilityView(),
                const SizedBox(
                  height: GlobalStyles.defaultPadding,
                ),
                ReviewsPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
