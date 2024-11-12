import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/core/constants.dart';

import 'package:babysitterapp/views/search.dart';

class FilterView extends HookConsumerWidget with GlobalStyles {
  FilterView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AnimationController controller = useAnimationController(
      duration: const Duration(milliseconds: 500),
    );
    final Animation<double> animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    );

    useEffect(() {
      controller.forward();
      return controller.dispose;
    }, <Object?>[controller]);

    return Theme(
      data: filterTheme(GlobalStyles.filterColorScheme),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: GlobalStyles.filterColorScheme.onSurface,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Filter by',
            style: TextStyle(
              color: GlobalStyles.filterColorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.refresh,
                color: GlobalStyles.primaryButtonColor,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FadeTransition(
              opacity: animation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 10),
                  const PriceFilter(),
                  const SizedBox(height: 10),
                  const DistanceSlider(),
                  const SizedBox(height: 10),
                  sortingOptions(),
                  const SizedBox(height: 20),
                  findButton(),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
