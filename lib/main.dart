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
          colorScheme: const ColorScheme.dark(
            primary: Colors.orangeAccent,
          secondary: Colors.orangeAccent,
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _handleLogin() {
    // Basic logic: Check if fields aren't empty
    if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter email and password")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.bolt, size: 80, color: Colors.orangeAccent),
            const Text(
              "SmartFit",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  foregroundColor: Colors.black,
                ),
                onPressed: _handleLogin,
                child: const Text("LOGIN", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
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
              title: const Text("Profile"),
              leading: const Icon(Icons.person),
              onTap: () {
                Navigator.pop(context);
                onNavigate(2);
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
            const Spacer(),
            ListTile(
              title: const Text("Logout", style: TextStyle(color: Colors.redAccent)),
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
            const SizedBox(height: 20),        
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
  final List<Map<String, dynamic>> _workouts = [];


  void _showWorkoutDialog({
    required String title,
    String? initialName,
    String? initialSets,
    String? initialReps,
    String? initialWeight,
    bool showNameField = true,
    required void Function(String name, int sets, int reps, double? weight) onConfirm,
  }) {
    final nameController = TextEditingController(text: initialName);
    final setsController = TextEditingController(text: initialSets);
    final repsController = TextEditingController(text: initialReps);
    final weightController = TextEditingController(text: initialWeight);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showNameField)
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Exercise Name (e.g. Yoga)"),
                autofocus: true,
              ),
            TextField(controller: setsController, decoration: const InputDecoration(labelText: "Sets"), keyboardType: TextInputType.number),
            TextField(controller: repsController, decoration: const InputDecoration(labelText: "Reps"), keyboardType: TextInputType.number),
            TextField(controller: weightController, decoration: const InputDecoration(labelText: "Weight (Optional)"), keyboardType: TextInputType.number),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              if (setsController.text.isNotEmpty && repsController.text.isNotEmpty) {
                final weight = double.tryParse(weightController.text);
                onConfirm(
                  nameController.text,
                  int.tryParse(setsController.text) ?? 0,
                  int.tryParse(repsController.text) ?? 0,
                  weight,
                );
                Navigator.pop(context);
              }
            },
            child: const Text("Confirm"),
          ),
        ],
      ),
    );
  }

  void _showAddWorkoutDialog() {
    _showWorkoutDialog(
      title: "Add Exercise",
      showNameField: true,
      onConfirm: (name, sets, reps, weight) {
        setState(() {
          _workouts.add({
            "name": name,
            "sets": sets,
            "reps": reps,
            "weight": weight,
          });
        });
      },
    );
  }

  void _showEditWorkoutDialog(int index) {
    final workout = _workouts[index];
    _showWorkoutDialog(
      title: "Edit ${workout['name']}",
      initialName: workout['name'],
      initialSets: workout['sets'].toString(),
      initialReps: workout['reps'].toString(),
      initialWeight: workout['weight']?.toString(),
      showNameField: false,
      onConfirm: (name, sets, reps, weight) {
        setState(() {
          _workouts[index] = {
            "name": workout['name'],
            "sets": sets,
            "reps": reps,
            "weight": weight,
          };
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Workouts")),
      body: _workouts.isEmpty
          ? const Center(child: Text("No workouts added yet!"))
          : ListView.builder(
              itemCount: _workouts.length,
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, index) {
                final item = _workouts[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 15),
                  child: ListTile(
                    onTap: () => _showEditWorkoutDialog(index),
                    leading: const CircleAvatar(
                      backgroundColor: Colors.orangeAccent,
                      child: Icon(Icons.fitness_center, color: Colors.black),
                    ),
                    title: Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    subtitle: Text(
                      "Sets: ${item['sets']} • Reps: ${item['reps']}${item['weight'] != null ? ' • Weight: ${item['weight']} lbs' : ''}",
                      style: const TextStyle(fontSize: 14),
                    ),
                   trailing: Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    IconButton(
      icon: const Icon(Icons.add_circle, color: Colors.green),
      onPressed: () {
        setState(() {
          _workouts[index]['sets']++;
        });
      },
    ),
    IconButton(
      icon: const Icon(Icons.remove_circle, color: Colors.orangeAccent),
      onPressed: () {
        setState(() {
          if (_workouts[index]['sets'] > 1) {
            _workouts[index]['sets']--;
          } else {
            _workouts.removeAt(index);
          }
        });
      },
    ),
    IconButton(
      icon: const Icon(Icons.delete, color: Colors.redAccent),
      onPressed: () => setState(() => _workouts.removeAt(index)),
    ),
  ],
),
),
);
},
),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddWorkoutDialog,
        backgroundColor: Colors.orangeAccent,
        child: const Icon(Icons.add, color: Colors.black),
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
            const Divider(height: 40),
            Text("App Version: 1.0.0", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
