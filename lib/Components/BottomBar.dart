import 'package:eatplek_admin/Screens/DashboardScreen.dart';
import 'package:eatplek_admin/Screens/ExpensesScreen.dart';
import 'package:eatplek_admin/Screens/InventoryScreen.dart';
import 'package:eatplek_admin/Screens/SettingsSCreen.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  final int index;
  BottomBar({required this.index});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;
  final pages = [
    DashboardScreen.id,
    InventoryScreen.id,
    ExpensesScreen.id,
    SettingsSCreen.id,
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.pushReplacementNamed(context, pages[index]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed,
      currentIndex: widget.index,
      selectedLabelStyle: const TextStyle(
        color: Color(0x33042e60),
        fontSize: 9.45121955871582,
        fontFamily: 'SFUIText',
      ),
      unselectedLabelStyle: const TextStyle(
        color: Color(0xff042e60),
        fontSize: 9.45121955871582,
        fontFamily: 'SFUIText',
      ),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Image.asset(
              'images/bottomnavigationbar/dashboard.png',
              height: 23,
            ),
            label: ' Dashboard',
            activeIcon: Image.asset(
              'images/bottomnavigationbar/dashboard1.png',
              height: 23,
            )),
        BottomNavigationBarItem(
          icon: Image.asset(
            'images/bottomnavigationbar/inventory.png',
            height: 23,
          ),
          label: ' Inventory',
          activeIcon: Image.asset(
            'images/bottomnavigationbar/inventory1.png',
            height: 23,
          ),
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'images/bottomnavigationbar/expenses.png',
            height: 23,
          ),
          label: ' Revenue',
          activeIcon: Image.asset(
            'images/bottomnavigationbar/expenses1.png',
            height: 23,
          ),
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'images/bottomnavigationbar/settings.png',
            height: 23,
          ),
          label: 'Settings',
          activeIcon: Image.asset(
            'images/bottomnavigationbar/settings1.png',
            height: 23,
          ),
        ),
      ],
      elevation: 30,
      showSelectedLabels: true,
      showUnselectedLabels: true,
    );
  }
}
