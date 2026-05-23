import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky3/features/tasks/completed_tasks.dart';
import 'package:tasky3/features/home/home_screen.dart';
import 'package:tasky3/features/profile/profile.dart';
import 'package:tasky3/features/tasks/tasks.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _screen = [
    const HomeScreen(),
    Tasks(),
    CompletedTasks(),
    Profile(),
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screen[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int? index) {
          setState(() {
            _currentIndex = index ?? 0;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: customSvg('assets/images/home.svg', 0),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: customSvg('assets/images/To Do.svg', 1),
            label: 'To Do',
          ),
          BottomNavigationBarItem(
            icon: customSvg('assets/images/Completed .svg', 2),
            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: customSvg('assets/images/profile.svg', 3),
            label: 'profile',
          ),
        ],
      ),
    );
  }

  Widget customSvg(String url, int index) {
    return SvgPicture.asset(
      url,
      colorFilter: ColorFilter.mode(
        _currentIndex == index ? Color(0xFF15B86C) : Color(0xFFC6C6C6),
        BlendMode.srcIn,
      ),
    );
  }
}
