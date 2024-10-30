// utils
import 'package:flutter/material.dart';

// widgets
import 'package:babysitterapp/views/home/widgets/transaction_card.dart';

class Transhistory extends StatelessWidget {
  const Transhistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction History'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
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
    );
  }
}
