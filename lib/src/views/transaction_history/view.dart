import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/views.dart';

class TransactionHistoryView extends HookConsumerWidget {
  const TransactionHistoryView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction History'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          const SizedBox(height: 20),
          const SizedBox(width: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                child: const Text('GCash'),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                child: const Text('Cash on Service'),
              ),
              Column(
                children: <Widget>[
                  PopupMenuButton<String>(
                    tooltip: '',
                    onSelected: (String result) {
                      if (result == 'Payment') {
                        // Do something for Payment
                      } else if (result == 'Service Profile') {
                        // Do something for Service Profile
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'Any time',
                        child: Text('Any time'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Older than a week',
                        child: Text('Older than a week'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Older than a month',
                        child: Text('Older than a month'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Older than 6 months',
                        child: Text('Older than 6 months'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Older than a year',
                        child: Text('Older than a year'),
                      ),
                    ],
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Filter',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(width: 2),
                        Icon(Icons.filter_alt_rounded, size: 30.0),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              PopupMenuButton<String>(
                tooltip: '',
                onSelected: (String result) {
                  if (result == 'Payment') {
                    // Do something for Payment
                  } else if (result == 'Service Profile') {
                    // Do something for Service Profile
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'All',
                    child: Text('All'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Recent',
                    child: Text('Recent'),
                  ),
                ],
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(width: 15),
                    Text(
                      'Recent',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.arrow_drop_down, size: 40.0),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(4.0),
              children: const <Widget>[
                TransactionCard(
                  date: 'Sep 22, 2024',
                  sitterName: 'Sarah Johnson',
                  service: 'Babysitting',
                  amount: r'$50.00',
                ),
                TransactionCard(
                  date: 'Sep 18, 2024',
                  sitterName: 'Emily Brown',
                  service: 'Overnight Babysitting',
                  amount: r'$120.00',
                ),
                TransactionCard(
                  date: 'Sep 14, 2024',
                  sitterName: 'Alex Wilson',
                  service: 'Evening Babysitting',
                  amount: r'$75.00',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
