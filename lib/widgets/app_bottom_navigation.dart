// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:old_change_app/constants/colors.dart';
import 'package:old_change_app/data/fake.dart';
import 'package:old_change_app/screens/cart/cart_screen.dart';
import 'package:old_change_app/screens/sign_in/sign_in_screen.dart';

class AppBottomNavigation extends StatefulWidget {
  const AppBottomNavigation({Key key}) : super(key: key);

  @override
  State<AppBottomNavigation> createState() => _AppBottomNavigationState();
}

class _AppBottomNavigationState extends State<AppBottomNavigation> {
  int _selectedIndex = Fake.selectedIndex;
  List<dynamic> menuItems = [
    {
      'icon': 'assets/icons/home.svg',
      'label': 'Home',
    },
    {
      'icon': 'assets/icons/box.svg',
      'label': 'Delivery',
    },
    {
      'icon': 'assets/icons/chat.svg',
      'label': 'Messages',
    },
    {
      'icon': 'assets/icons/wallet.svg',
      'label': 'Wallet',
    },
    {
      'icon': 'assets/icons/profile.svg',
      'label': 'Profile',
    },
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 4 && Fake.selectedIndex != 4) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignInScreen()));
    }
    Fake.selectedIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      showUnselectedLabels: true,
      unselectedItemColor: Colors.black87,
      elevation: 32,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: TextStyle(height: 1.5, fontSize: 12),
      unselectedLabelStyle: TextStyle(height: 1.5, fontSize: 12),
      items: menuItems.map((i) {
        return BottomNavigationBarItem(
          icon: SvgPicture.asset(i['icon']),
          activeIcon: SvgPicture.asset(
            i['icon'],
            color: primaryColor,
          ),
          label: i['label'],
        );
      }).toList(),
      currentIndex: _selectedIndex,
      selectedItemColor: primaryColor,
      onTap: _onItemTapped,
    );
  }
}
