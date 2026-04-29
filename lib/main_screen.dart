import 'package:flutter/material.dart';
import 'constants.dart';
import 'screens/gym_lobby.dart';
import 'screens/workout.dart';
import 'screens/profile.dart';
import 'screens/about.dart';

// --- MAIN WRAPPER WITH BOTTOM NAVIGATION ---
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      GymLobby(onNavigate: _onItemTapped),
      const WorkoutTracker(),
      const ProfileScreen(),
      const AboutScreen(),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: GymAppColors.darkBg,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: GymAppColors.darkBg,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: GymAppColors.primaryBlue,
          unselectedItemColor: GymAppColors.textSecondary,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded, size: 24),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center_rounded, size: 24),
              label: 'Workout',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded, size: 24),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info_rounded, size: 24),
              label: 'About',
            ),
          ],
        ),
      ),
    );
  }
}
