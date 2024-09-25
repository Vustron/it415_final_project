import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  double _distance = 15;
  bool _onlineNow = false;
  String _sortBy = 'Rating';
  String _minPrice = '₱500.00';
  String _maxPrice = '₱2500.00';
  final List<String> _additions = <String>[
    'Multitasking and stress resistant',
    'Super ability to swaddle in the air'
  ];

  final ColorScheme _colorScheme = const ColorScheme.light(
    primary: Colors.blue,
    secondary: Colors.lightBlueAccent,
  );

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
      data: ThemeData(
        colorScheme: _colorScheme,
        appBarTheme: AppBarTheme(
          backgroundColor: _colorScheme.surface,
          foregroundColor: _colorScheme.onSurface,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: _colorScheme.primary,
            foregroundColor: _colorScheme.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: _colorScheme.onSurface),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Filter by',
            style: TextStyle(
                color: _colorScheme.onSurface, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: _colorScheme.primary,
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
                  _buildPriceFilter(),
                  const SizedBox(height: 5),
                  _buildDistanceSlider(),
                  const SizedBox(height: 5),
                  _buildOnlineNowSwitch(),
                  const SizedBox(height: 5),
                  _buildSortingOptions(),
                  const SizedBox(height: 5),
                  _buildAdditionsSection(),
                  const SizedBox(height: 5),
                  _buildFindButton(),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPriceFilter() {
    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildSectionTitle('Price', Icons.attach_money),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              Expanded(
                child: _buildPriceDropdown(
                  value: _minPrice,
                  items: <String>[
                    '₱500.00',
                    '₱1000.00',
                    '₱1500.00',
                    '₱2000.00'
                  ],
                  onChanged: (String? newValue) {
                    setState(() => _minPrice = newValue!);
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildPriceDropdown(
                  value: _maxPrice,
                  items: <String>[
                    '₱2500.00',
                    '₱3000.00',
                    '₱3500.00',
                    '₱4000.00'
                  ],
                  onChanged: (String? newValue) {
                    setState(() => _maxPrice = newValue!);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDistanceSlider() {
    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildSectionTitle('Distance', Icons.place),
          const SizedBox(height: 8),
          Slider(
            value: _distance,
            max: 30,
            divisions: 30,
            label: _distance.round().toString(),
            onChanged: (double value) {
              setState(() => _distance = value);
            },
          ),
          Text('${_distance.round()} km',
              style: TextStyle(color: _colorScheme.onBackground)),
        ],
      ),
    );
  }

  Widget _buildOnlineNowSwitch() {
    return _buildCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildSectionTitle('Online now', Icons.wifi),
          Switch(
            value: _onlineNow,
            onChanged: (bool value) {
              setState(() => _onlineNow = value);
            },
            activeColor: _colorScheme.secondary,
          ),
        ],
      ),
    );
  }

  Widget _buildSortingOptions() {
    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildSectionTitle('Sorting by', Icons.sort),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: <Widget>[
              _buildChoiceChip('Rating', Icons.star),
              _buildChoiceChip('Experience', Icons.work),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionsSection() {
    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildSectionTitle('Additions', Icons.add_circle_outline),
              TextButton(
                child: Text('See all',
                    style: TextStyle(color: _colorScheme.primary)),
                onPressed: () {},
              ),
            ],
          ),
          ..._buildAdditionCheckboxes(),
        ],
      ),
    );
  }

  Widget _buildFindButton() {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.search),
        label: const Text('Find a nanny!'),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: <Widget>[
        Icon(icon, color: _colorScheme.primary, size: 24),
        const SizedBox(width: 8),
        Text(title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: _colorScheme.onBackground)),
      ],
    );
  }

  Widget _buildPriceDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: _colorScheme.outline),
        ),
        filled: true,
        fillColor: _colorScheme.surface,
      ),
      icon: Icon(Icons.arrow_drop_down, color: _colorScheme.primary),
    );
  }

  Widget _buildChoiceChip(String label, IconData icon) {
    return ChoiceChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon,
              size: 18,
              color: _sortBy == label
                  ? _colorScheme.onSecondary
                  : _colorScheme.onSurface),
          const SizedBox(width: 4),
          Text(label),
        ],
      ),
      selected: _sortBy == label,
      onSelected: (bool selected) {
        setState(() => _sortBy = selected ? label : _sortBy);
      },
      selectedColor: _colorScheme.secondary,
      backgroundColor: _colorScheme.surface,
    );
  }

  List<Widget> _buildAdditionCheckboxes() {
    final List<String> additions = <String>[
      'Without bad habits',
      'Knows how to give first aid',
      'Multitasking and stress resistant',
      'Has own baby monitor',
      'Super ability to swaddle in the air',
      'Can take out the trash',
    ];

    return additions.map((String addition) {
      return CheckboxListTile(
        title:
            Text(addition, style: TextStyle(color: _colorScheme.onBackground)),
        value: _additions.contains(addition),
        onChanged: (bool? value) {
          setState(() {
            if (value!) {
              _additions.add(addition);
            } else {
              _additions.remove(addition);
            }
          });
        },
        activeColor: _colorScheme.primary,
      );
    }).toList();
  }
}
