import 'package:flutter/material.dart';

void main() => runApp(const GymApp());

class GymApp extends StatelessWidget {
  const GymApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.orangeAccent,
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    GymLobby(),
    WorkoutTracker(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Workout',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orangeAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}

class GymLobby extends StatelessWidget {
  const GymLobby({super.key});

  @override
  Widget build(BuildContext context) {
    final types = {
      "Strength": Icons.fitness_center,
      "Cardio": Icons.directions_run,
      "Yoga": Icons.self_improvement,
      "Weight Loss": Icons.monitor_weight,
    };

    return Scaffold(
      appBar: AppBar(title: const Text("SmartFit"), centerTitle: true),
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.orangeAccent),
              child: Center(child: Text("Menu")),
            ),
            ...["Home", "Workout", "About"].map(
              (t) => ListTile(title: Text(t), leading: const Icon(Icons.bolt)),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const CircleAvatar(
            radius: 40,
            backgroundColor: Colors.orangeAccent,
            child: Icon(Icons.bolt, color: Colors.black),
          ),
          const Text(
            "SmartFit",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: types.entries
                  .map(
                    (e) => Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(e.value, color: Colors.orangeAccent),
                          Text(e.key),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: const Center(child: Text("Profile Screen")),
    );
  }
}

class WorkoutTracker extends StatefulWidget {
  const WorkoutTracker({super.key});
  @override
  State<WorkoutTracker> createState() => _WorkoutTrackerState();
}

class _WorkoutTrackerState extends State<WorkoutTracker> {
  int _sets = 0, _weight = 100;

  void _logSet() {
    setState(() => _sets++);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Set Recorded!"),
        duration: Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bench Press")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: _sets / 5,
              color: Colors.orangeAccent,
            ),
            Text("$_sets / 5 sets", style: const TextStyle(fontSize: 20)),
            const Spacer(),
            Text(
              '$_sets',
              style: const TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.bold,
                color: Colors.orangeAccent,
              ),
            ),
            const Text("SETS COMPLETED"),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => setState(() => _weight -= 5),
                  icon: const Icon(Icons.remove_circle),
                ),
                Text("$_weight lbs", style: const TextStyle(fontSize: 24)),
                IconButton(
                  onPressed: () => setState(() => _weight += 5),
                  icon: const Icon(Icons.add_circle),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _logSet, child: const Text("LOG SET")),
          ],
        ),
      ),
    );
  }
}
