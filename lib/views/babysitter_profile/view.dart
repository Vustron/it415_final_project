import 'package:babysitterapp/core/constants/styles.dart';
import 'package:babysitterapp/views/babysitter_profile/widgets/Availability.dart';
import 'package:babysitterapp/views/babysitter_profile/widgets/Experience.dart';
import 'package:babysitterapp/views/babysitter_profile/widgets/Reviews.dart';
import 'package:babysitterapp/views/babysitter_profile/widgets/descriptions.dart';
import 'package:babysitterapp/views/babysitter_profile/widgets/input.dart';
import 'package:babysitterapp/views/babysitter_profile/widgets/profile_header.dart';
import 'package:flutter/material.dart';

class BabysitterProfile extends StatefulWidget {
  const BabysitterProfile({super.key});

  @override
  State<BabysitterProfile> createState() => _BabysitterProfileState();
}

ScrollController _scrollController = ScrollController();

class _BabysitterProfileState extends State<BabysitterProfile>
    with GlobalStyles {
  @override
  Widget build(BuildContext context) {
    final Size width = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 280,
        leadingWidth: width.width,
        elevation: 3,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        shadowColor: const Color.fromARGB(176, 0, 0, 0),
        leading: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 40,
              ),
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
                height: 10,
              ),
              profileHeader(GlobalStyles.primaryButtonColor),
              const SizedBox(
                height: 15,
              ),
              messageButton(GlobalStyles.kPrimaryColor),
            ],
          ),
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15))),
      ),
      body: ListView(
        controller: _scrollController,
        children: <Widget>[
          Container(
            padding: GlobalStyles.defaultContentPadding,
            child: Column(
              children: <Widget>[
                DescriptionsPage(),
                const SizedBox(
                  height: GlobalStyles.defaultPadding,
                ),
                ExperiencePage(),
                const SizedBox(
                  height: GlobalStyles.defaultPadding,
                ),
                AvailabilityPage(),
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
