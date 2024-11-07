import 'package:flutter/material.dart';

class Stats extends StatefulWidget {
  const Stats({super.key});

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  final List<Map<String, String>> stats = <Map<String, String>>[
    <String, String>{'title': 'Total Services', 'value': '15'},
    <String, String>{'title': 'Ratings', 'value': '4.5'},
    <String, String>{'title': 'Rate', 'value': '15'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(9.0),
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4))
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: stats.map((Map<String, String> stat) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (stat['title'] == 'Ratings')
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      stat['value'] ?? '',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 18,
                    ),
                  ],
                )
              else if (stat['title'] == 'Rate')
                Text(
                  '₱ ${stat['value']!} / hr',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )
              else
                Text(
                  stat['value'] ?? '',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              Text(
                stat['title'] ?? '',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
