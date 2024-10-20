// core
import 'package:babysitterapp/core/widgets/filter/additions_section.dart';
import 'package:babysitterapp/core/widgets/filter/distance_slider.dart';
import 'package:babysitterapp/core/widgets/filter/sorting_options.dart';
import 'package:babysitterapp/core/widgets/filter/price_filter.dart';
import 'package:babysitterapp/core/widgets/filter/filter_theme.dart';
import 'package:babysitterapp/core/widgets/filter/find_button.dart';
import 'package:babysitterapp/core/widgets/filter/online.dart';
import 'package:babysitterapp/core/constants/styles.dart';

// flutter
import 'package:flutter/material.dart';

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
                color: GlobalStyles.buttonColor,
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
                  const PriceFilter(),
                  const SizedBox(height: 5),
                  const DistanceSlider(),
                  const SizedBox(height: 5),
                  const OnlineNowSwitch(),
                  const SizedBox(height: 5),
                  sortingOptions(),
                  const SizedBox(height: 5),
                  additionsSection(),
                  const SizedBox(height: 5),
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
