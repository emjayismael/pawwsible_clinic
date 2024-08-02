import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        backgroundColor: Color(0xFF6A1B9A),
      ),
      body: ListView(
        children: [
          DashboardItem(
            title: 'Appointment Calendar',
            icon: Icons.calendar_today,
            onTap: () {
              Navigator.pushNamed(context, '/appointmentCalendar');
            },
          ),
          DashboardItem(
            title: 'Pending Requests',
            icon: Icons.pending,
            onTap: () {
              Navigator.pushNamed(context, '/pendingRequests');
            },
          ),
          DashboardItem(
            title: 'Confirm Requests',
            icon: Icons.check_circle,
            onTap: () {
              Navigator.pushNamed(context, '/confirmRequests');
            },
          ),
          DashboardItem(
            title: 'Queueing',
            icon: Icons.queue,
            onTap: () {
              Navigator.pushNamed(context, '/queueing');
            },
          ),
          DashboardItem(
            title: 'Patient Record List',
            icon: Icons.list,
            onTap: () {
              Navigator.pushNamed(context, '/patientRecordList');
            },
          ),
        ],
      ),
    );
  }     
}

class DashboardItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;

  const DashboardItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: InkWell(
        onTap: () => onTap(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 40, color: Color(0xFF6A1B9A)),
              SizedBox(width: 20),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
