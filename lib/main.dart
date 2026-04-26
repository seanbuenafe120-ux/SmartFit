import 'package:flutter/material.dart';

void main() => runApp(const GymApp());

class GymApp extends StatelessWidget {
  const GymApp({super.key});
  static const Color primaryBlue = Color(0xFF007BFF); 
  static const Color bgBlack = Color(0xFF0A0A0A);  
  static const Color surfaceGray = Color(0xFF1E1E1E); 
  static const Color accentGreen = Color(0xFF10B981); 
  static const Color accentRed = Color(0xFFEF4444);   
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bgBlack,
        primaryColor: primaryBlue,
          colorScheme: const ColorScheme.dark(
       primary: primaryBlue,
          secondary: primaryBlue,
          surface: surfaceGray,
          onSurface: Colors.white,
        ),
          
        cardTheme: CardThemeData(
          color: surfaceGray,
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
          
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: surfaceGray,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: primaryBlue, width: 2),
          ),
          labelStyle: const TextStyle(color: Colors.blueGrey),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        // Button Theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryBlue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 8,
            shadowColor: primaryBlue.withOpacity(0.5),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          ),   
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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  void _handleLogin() {
   if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in all fields"),
          backgroundColor: GymApp.accentRed,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    
    // Simulate login delay
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() => _isLoading = false);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      }
    });
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              GymApp.bgBlack,
              GymApp.bgBlack.withAlpha(242),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Glowing Logo Accent
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: GymApp.primaryBlue.withAlpha(102),
                        blurRadius: 40,
                        spreadRadius: 8,
                      )
                    ],
                  ),
                  child: const Icon(
                    Icons.bolt,
                    size: 80,
                    color: GymApp.primaryBlue,
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  "SMARTFIT",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Level Up Your Performance",
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 16,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 60),
                
                // Email Field
                TextField(
                  controller: _emailController,
                  enabled: !_isLoading,
                  decoration: InputDecoration(
                    hintText: "Email Address",
                    prefixIcon: const Icon(Icons.email_outlined, color: GymApp.primaryBlue),
                    hintStyle: const TextStyle(color: Colors.blueGrey),
                  ),
                ),
                const SizedBox(height: 20),
                
                // Password Field
                TextField(
                  controller: _passwordController,
                  enabled: !_isLoading,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: const Icon(Icons.lock_outline, color: GymApp.primaryBlue),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        color: Colors.blueGrey,
                      ),
                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),
                    hintStyle: const TextStyle(color: Colors.blueGrey),
                  ),
                ),
                const SizedBox(height: 50),
                
                // Login Button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleLogin,
                    child: _isLoading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            "LOGIN",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                  ),
                ),
                const SizedBox(height: 20),
                
                // Demo Login
                OutlinedButton(
                  onPressed: _isLoading ? null : () {
                    _emailController.text = "demo@smartfit.com";
                    _passwordController.text = "demo123";
                    _handleLogin();
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: GymApp.primaryBlue, width: 2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  ),
                  child: const Text(
                    "Try Demo Account",
                    style: TextStyle(color: GymApp.primaryBlue, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
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

 void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
      final List<Widget> widgetOptions = [
      GymLobby(onNavigate: _onItemTapped), 
      const WorkoutTracker(),
      const ProfileScreen(),
      const AboutScreen(), 
    ];
    
    return Scaffold(
      body: widgetOptions[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.white10, width: 0.5)),
        ),
        child: BottomNavigationBar(
          backgroundColor: GymApp.bgBlack,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: GymApp.primaryBlue,
          unselectedItemColor: Colors.white38,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: 'Lobby'),
            BottomNavigationBarItem(icon: Icon(Icons.fitness_center_rounded), label: 'Workout'),
            BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
            BottomNavigationBarItem(icon: Icon(Icons.info_outline_rounded), label: 'About'),
          ],
        ),
      ),
    );
  }
}

class GymLobby extends StatelessWidget {
  final Function(int) onNavigate; 
  const GymLobby({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
      final categories = {
      "Strength": Icons.fitness_center_rounded,
      "Cardio": Icons.directions_run_rounded,
      "Yoga": Icons.self_improvement_rounded,
      "Weight Loss": Icons.monitor_weight_rounded,
    };

    return Scaffold(
     appBar: AppBar(
        title: const Text("SMARTFIT", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: _buildModernDrawer(context),
      
      body: Column(
        children: [
          const SizedBox(height: 20),
         Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [GymApp.primaryBlue, Color(0xFF0056CC)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: GymApp.primaryBlue.withAlpha(77),
                        blurRadius: 20,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  child: const Icon(Icons.bolt, color: Colors.white, size: 32),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome back,", style: TextStyle(color: Colors.blueGrey[300], fontSize: 14)),
                    const Text("Athlete", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: GridView.count(
            crossAxisCount: 2, 
            padding: const EdgeInsets.all(20), 
            crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              children: categories.entries.map((e) {
                final colors = {
                  "Strength": [const Color(0xFF007BFF), const Color(0xFF0056CC)],
                  "Cardio": [const Color(0xFF00D4FF), const Color(0xFF007BFF)],
                  "Yoga": [const Color(0xFF10B981), const Color(0xFF059669)],
                  "Weight Loss": [const Color(0xFFFF6B35), const Color(0xFFEF4444)],
                };
                final gradientColors = colors[e.key] ?? [GymApp.primaryBlue, GymApp.primaryBlue];
                
                return Card(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => onNavigate(1),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: gradientColors,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(e.value, color: Colors.white, size: 48),
                          const SizedBox(height: 12),
                          Text(
                            e.key,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                   ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildModernDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: GymApp.bgBlack,
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [GymApp.bgBlack, GymApp.primaryBlue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
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
child: const Center(
              child: Text(
                "COMMAND CENTER",
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          _drawerTile(Icons.home_rounded, "Lobby", () => Navigator.pop(context)),
          _drawerTile(Icons.fitness_center, "Workout", () {
            Navigator.pop(context);
            onNavigate(1);
          }),
          _drawerTile(Icons.person_rounded, "Profile", () {
            Navigator.pop(context);
            onNavigate(2);
          }),
          _drawerTile(Icons.info_outline_rounded, "About", () {
            Navigator.pop(context);
            onNavigate(3);
          }),
          const Spacer(),
          _drawerTile(Icons.logout, "Logout", () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
          }, color: GymApp.accentRed),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

   Widget _drawerTile(IconData icon, String title, VoidCallback onTap, {Color? color}) {
    return ListTile(
      leading: Icon(icon, color: color ?? GymApp.primaryBlue),
      title: Text(title, style: TextStyle(color: color ?? Colors.white)),
      onTap: onTap,
    );
  }
}
class WorkoutTracker extends StatefulWidget {
  const WorkoutTracker({super.key});

  @override
  State<WorkoutTracker> createState() => _WorkoutTrackerState();
}

class _WorkoutTrackerState extends State<WorkoutTracker> {
  final List<Map<String, dynamic>> _workouts = [];

void _showWorkoutDialog({int? index}) {
    final isEditing = index != null;
    final workout = isEditing ? _workouts[index] : null;

    final nameController = TextEditingController(text: workout?['name'] ?? "");
    final setsController = TextEditingController(text: workout?['sets']?.toString() ?? "3");
    final repsController = TextEditingController(text: workout?['reps']?.toString() ?? "10");
    final weightController = TextEditingController(text: workout?['weight']?.toString() ?? "");
 
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: GymApp.surfaceGray,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          isEditing ? "Edit Exercise" : "Add Exercise",
          style: const TextStyle(color: GymApp.primaryBlue, fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
              decoration: const InputDecoration(hintText: "Exercise Name (e.g. Bench Press)"),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: setsController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(hintText: "Sets"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: repsController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(hintText: "Reps"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: "Weight (lbs) - Optional"),
              ),
            ],
          ),
        ),  
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), 
          ElevatedButton(
            onPressed: () {
              child: const Text("Cancel", style: TextStyle(color: Colors.white38)),
              ),
            ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                setState(() {
                  final data = {
                    "name": nameController.text,
                    "sets": int.tryParse(setsController.text) ?? 3,
                    "reps": int.tryParse(repsController.text) ?? 10,
                    "weight": weightController.text.isNotEmpty ? double.tryParse(weightController.text) : null,
                  };
                  if (isEditing) {
                    _workouts[index!] = data;
                  } else {
                    _workouts.add(data);
                  }
                });
              
                Navigator.pop(context);
              }
            },
            child: Text(isEditing ? "Update" : "Add"),
          ),
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MY ROUTINE"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _workouts.isEmpty
         ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.fitness_center_rounded, size: 64, color: Colors.blueGrey[700]),
                  const SizedBox(height: 16),
                  const Text(
                    "No workouts added yet!",
                    style: TextStyle(color: Colors.blueGrey, fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => _showWorkoutDialog(),
                    icon: const Icon(Icons.add),
                    label: const Text("Add Your First Exercise"),
                  ),
                ],
              ),
            )
          : ListView.builder(
             padding: const EdgeInsets.all(15),
              itemCount: _workouts.length,
             
              itemBuilder: (context, index) {
                final item = _workouts[index];
                return Card(
                   margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    onTap: () => _showWorkoutDialog(index: index),
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [GymApp.primaryBlue, Color(0xFF0056CC)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: const Icon(Icons.fitness_center_rounded, color: Colors.white),
                    ),
                    title: Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    subtitle: Text(
                     "Sets: ${item['sets']} • Reps: ${item['reps']}${item['weight'] != null ? ' • ${item['weight']} lbs' : ''}",
                      style: const TextStyle(color: Colors.white70),
                    ),
                   trailing: Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    IconButton(
     icon: const Icon(Icons.add_circle_outline, color: GymApp.accentGreen),
    onPressed: () => setState(() => item['sets']++),
    ),
    IconButton(
       icon: const Icon(Icons.remove_circle_outline, color: GymApp.primaryBlue),
      onPressed: () {
        setState(() {
        if (item['sets'] > 0) item['sets']--;
        });
      },
    ),
    IconButton(
       icon: const Icon(Icons.delete_outline, color: GymApp.accentRed),
        onPressed: () => setState(() => _workouts.removeAt(index)),
    ),
  ],
),
),
);
},
),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showWorkoutDialog(),
        backgroundColor: GymApp.primaryBlue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

// --- PROFILE SCREEN ---
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditing = false;
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _weightController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: "John Athlete");
    _ageController = TextEditingController(text: "28");
    _weightController = TextEditingController(text: "180");
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ATHLETE PROFILE"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.check : Icons.edit),
            onPressed: () => setState(() => _isEditing = !_isEditing),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            // Profile Avatar
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [GymApp.primaryBlue, Color(0xFF0056CC)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: GymApp.primaryBlue.withAlpha(77),
                          blurRadius: 20,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    child: const Icon(Icons.person, size: 60, color: Colors.white),
                  ),
                  if (_isEditing)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: GymApp.primaryBlue,
                          boxShadow: [
                            BoxShadow(
                              color: GymApp.primaryBlue.withAlpha(77),
                              blurRadius: 10,
                              spreadRadius: 1,
                            )
                          ],
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(Icons.camera_alt, size: 20, color: Colors.white),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            
            // Full Name
            TextField(
              controller: _nameController,
              enabled: _isEditing,
              decoration: InputDecoration(
                hintText: "Full Name",
                prefixIcon: const Icon(Icons.badge, color: GymApp.primaryBlue),
                enabled: _isEditing,
              ),
            ),
            const SizedBox(height: 20),
            
            // Age and Weight
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ageController,
                    enabled: _isEditing,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Age",
                      prefixIcon: const Icon(Icons.cake, color: GymApp.primaryBlue),
                      enabled: _isEditing,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    controller: _weightController,
                    enabled: _isEditing,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Weight (kg)",
                      prefixIcon: const Icon(Icons.monitor_weight, color: GymApp.primaryBlue),
                      enabled: _isEditing,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            
            // Stats
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const Text("Member Since", style: TextStyle(color: Colors.blueGrey, fontSize: 12)),
                          const SizedBox(height: 8),
                          const Text("Jan 2026", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: GymApp.primaryBlue)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const Text("Workouts", style: TextStyle(color: Colors.blueGrey, fontSize: 12)),
                          const SizedBox(height: 8),
                          const Text("24", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: GymApp.primaryBlue)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
        appBar: AppBar(
        title: const Text("SYSTEM INFO"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [GymApp.primaryBlue, Color(0xFF0056CC)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Icon(Icons.verified_user_rounded, color: Colors.white, size: 50),
                ),
                const SizedBox(height: 20),
                const Text(
                  "SMARTFIT v2.0.0",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Divider(height: 40, color: Colors.white12),
                const Text(
                  "A next-generation fitness tracking environment designed for high-performance athletes.\n\nImproved UI with enhanced design, better organization, and smooth interactions.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueGrey, fontSize: 14, height: 1.6),
                ),
                const SizedBox(height: 30),
                Text(
                  "Build 2026.04 - Improved Edition",
                  style: TextStyle(color: Colors.white.withAlpha(77), fontSize: 12),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: GymApp.primaryBlue.withAlpha(26),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: GymApp.primaryBlue.withAlpha(77)),
                  ),
                  child: const Column(
                    children: [
                      Text("✨ Features", style: TextStyle(fontWeight: FontWeight.bold, color: GymApp.primaryBlue)),
                      SizedBox(height: 8),
                      Text(
                        "• Real-time workout tracking\n• Personalized fitness plans\n• Progress analytics\n• Multiple workout categories\n• Athlete profile management",
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
