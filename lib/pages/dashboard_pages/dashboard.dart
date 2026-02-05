import 'package:flutter/material.dart';
import 'package:measurements/pages/dashboard_pages/home_page.dart';
import 'package:measurements/pages/dashboard_pages/settings_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [HomePage(), SettingsPage()];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_currentIndex == 0 ? "Home" : "Profile"), centerTitle: true),

      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("Shreyansh Bariya"),
              accountEmail: Text("shreyanshchichi@gmail.com"),
              currentAccountPicture: CircleAvatar(child: Icon(Icons.person, size: 40)),
            ),

            ListTile(leading: const Icon(Icons.home), title: const Text("Home"), selected: _currentIndex == 0, onTap: () => _onItemTapped(0)),

            ListTile(leading: const Icon(Icons.person), title: const Text("Profile"), selected: _currentIndex == 1, onTap: () => _onItemTapped(1)),

            const Spacer(),

            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout"),
              onTap: () {},
            ),
          ],
        ),
      ),

      body: AnimatedSwitcher(duration: const Duration(milliseconds: 300), child: _pages[_currentIndex]),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
