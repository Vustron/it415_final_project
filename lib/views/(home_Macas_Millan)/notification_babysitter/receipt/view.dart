import 'package:babysitterapp/core/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentConfirmationScreen extends StatelessWidget {
  final int children = 5;
  final DateTime date = DateTime.parse('2024-11-11');
  final String time = '12:15 AM - 4:20 AM';
  final bool stayIn = true;
  final String address = 'Home';
  final String details = 'Bring Your ID';
  final String amount = '₱11k';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 252, 252),
      appBar: AppBar(
        title: const Text('Payment Confirmation'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.only(bottom: 50),
        child: Center(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 20,),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const CircleAvatar(
                    backgroundColor:GlobalStyles.primaryButtonColor,
                    radius: 30,
                    child: Icon(Icons.check, color: Colors.white, size: 40),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Receive',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.blue[800],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        radius: 25,
                        child: Icon(Icons.person, color: Colors.blue[800]),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Recipient',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          const Text(
                            'Babysitter',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Reference number\n#B3423424234',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Amount sent',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          Text(
                            amount,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Transfer fee',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          const Text(
                            '₱0.00',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Divider(color: Colors.grey[300]),
                  const SizedBox(height: 10),
                  Text(
                    'Job Details',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildDetailRow('Children', '$children'),
                  _buildDetailRow('Date', DateFormat('yyyy-MM-dd').format(date)),
                  _buildDetailRow('Time', time),
                  _buildDetailRow('Stay In', stayIn ? 'Yes' : 'No'),
                  _buildDetailRow('Address', address),
                  _buildDetailRow('Details', details),
                  const SizedBox(height: 20),
             
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(color: Colors.grey[600]),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
