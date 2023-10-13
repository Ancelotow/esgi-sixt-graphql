import 'package:app/domain/models/session.dart';
import 'package:app/presentation/screen/admin/admin_screen.dart';
import 'package:app/presentation/screen/home/vehicle_screen.dart';
import 'package:flutter/material.dart';

import '../../signIn_signUp/home_screen.dart';

class NavigatorScreen extends StatefulWidget {
  static const String routeName = '/NavigatorScreen';

  static void navigateTo(BuildContext context) {
    Navigator.of(context).pushNamed(routeName);
  }

  const NavigatorScreen({super.key});

  @override
  State<NavigatorScreen> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    VehicleScreen(),
    AdminScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          if (Session.instance().user?.isAdmin ?? false)
            const BottomNavigationBarItem(
              icon: Icon(Icons.group_work_sharp),
              label: 'Admin',
            ),
        ],
      ),
    );
  }
}
