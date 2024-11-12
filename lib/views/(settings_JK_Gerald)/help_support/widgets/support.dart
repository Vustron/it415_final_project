import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class SupportTile extends StatefulWidget {
  const SupportTile({
    super.key,
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  State<SupportTile> createState() => _SupportTileState();
}

class _SupportTileState extends State<SupportTile> {
  Future<void> _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'bsit4cit415@gmail.com',
    );

    try {
      final bool launched = await launchUrl(
        emailUri,
        mode: LaunchMode.externalApplication,
      );

      if (!mounted) {
        return; // Check if widget is still mounted
      }

      if (!launched) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Could not open email client. Please check your settings.'),
          ),
        );
      }
    } catch (e) {
      if (!mounted) {
        return; // Check if widget is still mounted
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('An error occurred while trying to open the email client.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(widget.icon),
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 15),
        ),
        onTap: () {
          if (widget.title.contains('bsit4cit415@gmail.com')) {
            _launchEmail();
          }
        },
      ),
    );
  }
}
