import 'package:flutter/material.dart';

class MainOptionScreen extends StatelessWidget {
  const MainOptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Choose an Option')),
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 5.0,
      ),
      drawer: _mainDrawer(context),
      body: Stack(
        children: [
          // Add a background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple, Colors.blueAccent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildOptionButton(
                    context,
                    icon: Icons.search,
                    label: 'Fact Check',
                    route: '/facts',
                    color: Colors.orangeAccent,
                  ),
                  const SizedBox(height: 20),
                  _buildOptionButton(
                    context,
                    icon: Icons.report,
                    label: 'Report Corruption',
                    route: '/report',
                    color: Colors.redAccent,
                  ),
                  const SizedBox(height: 20),
                  _buildOptionButton(
                    context,
                    icon: Icons.newspaper,
                    label: 'View Reports',
                    route: '/viewreport',
                    color: Colors.greenAccent,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Create a reusable button with an icon and background color
  Widget _buildOptionButton(BuildContext context,
      {required IconData icon,
      required String label,
      required String route,
      required Color color}) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 8.0,
      ),
      icon: Icon(icon, size: 28),
      label: Text(
        label,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
    );
  }

  Widget _mainDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text('Visitor'),
            accountEmail: Text('visitor@mail.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/logo.png'),
              backgroundColor: Colors.white,
            ),
            decoration: BoxDecoration(color: Colors.deepPurpleAccent),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.search,
            label: 'Fact Check',
            route: '/facts',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.report,
            label: 'Report',
            route: '/report',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.newspaper,
            label: 'Hot Now',
            route: '/viewreport',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.info,
            label: 'Youth Empowerment',
            route: '/youths',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.book,
            label: 'Resources',
            route: '/resources',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.policy,
            label: 'Policies',
            route: '/policies',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.question_answer,
            label: 'Awareness and Solutions',
            route: '/awareness',
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context,
      {required IconData icon, required String label, required String route}) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepPurpleAccent),
      title: Text(
        label,
        style: const TextStyle(fontSize: 16),
      ),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }
}
