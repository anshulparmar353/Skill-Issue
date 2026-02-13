import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_issue/core/routes/app_go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.child});

  final Widget child;

  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int _index = 0;

  final routes = [
    AppRoutes.dashboardScreen,
    AppRoutes.skillScreen,
    AppRoutes.roadmapScreen,
    AppRoutes.profileScreen,
  ];

  void _onTap(int index) {
    
    setState(() => _index = index);

    context.go(routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: _onTap,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: "Skills",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: "Roadmap",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
