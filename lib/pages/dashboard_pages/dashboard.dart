import 'package:flutter/material.dart';
import 'package:measurements/pages/dashboard_pages/home_page.dart';
import 'package:measurements/pages/dashboard_pages/settings_page.dart';
import 'package:measurements/utils/app_colors.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;

  final List<Widget> _pages = const [HomePage(), SettingsPage()];

  void _onItemTapped(int index, {bool fromDrawer = false}) {
    setState(() {
      _currentIndex = index;
    });

    if (fromDrawer) {
      Navigator.pop(context); // close drawer safely
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text(_currentIndex == 0 ? "Home" : "Settings"), centerTitle: true),

      drawer: Drawer(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: AppColors().c8F5555),
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: CircleAvatar(
                      backgroundColor: AppColors().cEADCDC,
                      child: Icon(Icons.person, size: 40, color: AppColors().c8F5555),
                    ),
                  ),
                ],
              ),
            ),

            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              selected: _currentIndex == 0,
              onTap: () => _onItemTapped(0, fromDrawer: true),
            ),

            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Profile"),
              selected: _currentIndex == 1,
              onTap: () => _onItemTapped(1, fromDrawer: true),
            ),

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
        onTap: (index) => _onItemTapped(index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Profile"),
        ],
      ),
    );
  }
}
