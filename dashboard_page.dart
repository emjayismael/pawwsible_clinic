import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final String? ownerName = ModalRoute.of(context)!.settings.arguments as String?;

    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.pets,
              size: 40.0,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Text(
              'Dashboard',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF6A1B9A),
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'my_account') {
                _navigateToAccount(context);
              } else if (value == 'logout') {
                _logout(context);
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'my_account',
                  child: Row(
                    children: [
                      Icon(Icons.account_circle, color: Colors.black),
                      SizedBox(width: 10),
                      Text('My Account'),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'logout',
                  child: Row(
                    children: [
                      Icon(Icons.logout, color: Colors.black),
                      SizedBox(width: 10),
                      Text('Logout'),
                    ],
                  ),
                ),
              ];
            },
            icon: Icon(Icons.menu, color: Colors.white),
          ),
        ],
      ),
      body: _buildBody(context, ownerName),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _onTabTapped(index, context, ownerName);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services),
            label: 'Patient Records',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.queue),
            label: 'Queue Status',
          ),
        ],
        selectedItemColor: Color(0xFF6A1B9A),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 10,
      ),
    );
  }

  Widget _buildBody(BuildContext context, String? ownerName) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8.0,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Welcome, $ownerName!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildDashboardCard(
                  icon: Icons.pets,
                  title: 'Make Appointments',
                  subtitle: 'Schedule a visit for your pet',
                  onTap: () {
                    Navigator.pushNamed(context, '/appointments');
                  },
                ),
                _buildDashboardCard(
                  icon: Icons.medical_services,
                  title: 'View Patient Records',
                  subtitle: 'Access medical records of your pets',
                  onTap: () {
                    Navigator.pushNamed(context, '/patient_records');
                  },
                ),
                _buildDashboardCard(
                  icon: Icons.queue,
                  title: 'Queue Status',
                  subtitle: 'Check the current queue status',
                  onTap: () {
                    _navigateToQueueStatus(context, ownerName);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onTabTapped(int index, BuildContext context, String? ownerName) {
    switch (index) {
      case 0:
        break; // Current page
      case 1:
        Navigator.pushNamed(context, '/appointments');
        break;
      case 2:
        Navigator.pushNamed(context, '/patient_records');
        break;
      case 3:
        _navigateToQueueStatus(context, ownerName);
        break;
    }
  }

  void _navigateToAccount(BuildContext context) {
    Navigator.pushNamed(context, '/my_account');
  }

  Widget _buildDashboardCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8.0,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                icon,
                size: 40,
                color: Color(0xFF6A1B9A),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF666666),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Color(0xFF666666),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToQueueStatus(BuildContext context, String? ownerName) {
    Navigator.pushNamed(
      context,
      '/queueStatus',
      arguments: ownerName,
    );
  }

  void _logout(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }
}
