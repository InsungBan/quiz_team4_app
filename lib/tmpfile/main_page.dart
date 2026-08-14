import 'package:flutter/material.dart';
import 'package:asdasd_asdasd_app/home.dart';
import 'package:asdasd_asdasd_app/my_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 1;

  final List<Widget> pages = [
    const Center(
      child: Text(
        '1페이지\n홈',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),

    const Home(),

    MyPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        selectedItemColor: Colors.cyan,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_one),
            label: '1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_two),
            label: '2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_3),
            label: '3',
          ),
        ],
      ),
    );
  }
}