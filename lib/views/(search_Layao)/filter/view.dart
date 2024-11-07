import 'package:flutter/material.dart';

import 'package:babysitterapp/core/constants/styles.dart';

import 'widgets/distance_slider.dart';
import 'widgets/sorting_options.dart';
import 'widgets/price_filter.dart';
import 'widgets/filter_theme.dart';
import 'widgets/find_button.dart';

class FilterView extends StatefulWidget {
  const FilterView({super.key});

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView>
    with SingleTickerProviderStateMixin, GlobalStyles {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: filterTheme(GlobalStyles.filterColorScheme),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: GlobalStyles.filterColorScheme.onSurface),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Filter by',
            style: TextStyle(
                color: GlobalStyles.filterColorScheme.onSurface,
                fontWeight: FontWeight.bold),
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
              opacity: _animation,
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
