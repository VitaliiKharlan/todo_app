import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _selectedPageIndex = 0;
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        title: Center(
          child: const Text(
            'TODO',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          setState(() {
            _selectedPageIndex = value;
          });
        },
        children: [
          Scaffold(),
          Scaffold(),
          Scaffold(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: theme.primaryColor,
        unselectedItemColor: theme.hintColor,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
        currentIndex: _selectedPageIndex,
        onTap: _openPage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.update),
            label: 'Save new task',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add new task',
          ),
        ],
      ),
    );
  }

  void _openPage(int index) {
    setState(() {
      _selectedPageIndex = index;
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 500),
        curve: Curves.bounceInOut,
      );
    });
  }
}
