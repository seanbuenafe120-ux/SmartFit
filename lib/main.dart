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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      GymLobby(onNavigate: _onItemTapped), 
      const WorkoutTracker(),
      const ProfileScreen(),
      const AboutScreen(), 
    ];
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'Workout'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'About'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orangeAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}

class GymLobby extends StatelessWidget {
  final Function(int) onNavigate; 
  const GymLobby({super.key, required this.onNavigate});

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
            child: Center(child: Text("Menu", style: TextStyle(color: Colors.black, fontSize: 24)))
          ),
          ListTile(
            title: const Text("Home"), 
            leading: const Icon(Icons.home), 
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            title: const Text("Workout"), 
            leading: const Icon(Icons.fitness_center), 
            onTap: () {
              Navigator.pop(context); 
              onNavigate(1);          
            },
          ),
          ListTile(
            title: const Text("About"), 
            leading: const Icon(Icons.info), 
            onTap: () {
              Navigator.pop(context); 
              onNavigate(3);          
            },
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

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  void _saveProfile() {
    String name = _nameController.text;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Profile updated for $name!"),
        backgroundColor: Colors.orangeAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.orangeAccent,
              child: Icon(Icons.person, size: 50, color: Colors.black),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Full Name",
                prefixIcon: Icon(Icons.badge, color: Colors.orangeAccent),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ageController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Age",
                      prefixIcon: Icon(Icons.cake, color: Colors.orangeAccent),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Weight (kg)",
                      prefixIcon: Icon(Icons.monitor_weight, color: Colors.orangeAccent),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  foregroundColor: Colors.black,
                ),
                onPressed: _saveProfile,
                child: const Text("SAVE PROFILE",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    super.dispose();
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
      const SnackBar(content: Text("Set Recorded!"), duration: Duration(milliseconds: 500))
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
           LinearProgressIndicator(value: (_sets / 5).clamp(0.0, 1.0), color: Colors.orangeAccent),
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

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About SmartFit")),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Welcome to SmartFit!", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("This app helps you track your bench press sets and manage your gym routine easily."),
          ],
        ),
      ),
    );
  }
}
