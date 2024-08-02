import 'package:flutter/material.dart';

class QueueStatusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Retrieve arguments
    final String? ownerName = ModalRoute.of(context)!.settings.arguments as String?;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Queue Status', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFF6A1B9A),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Owner Name',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[800],
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  ownerName ?? 'No Owner Information',
                  style: TextStyle(fontSize: 20, color: Colors.blueGrey[700]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
