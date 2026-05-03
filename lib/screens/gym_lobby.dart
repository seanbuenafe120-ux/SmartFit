import 'package:flutter/material.dart';
import 'dart:async';
import '../constants.dart';
import 'login.dart';

class GymLobby extends StatefulWidget {
  final Function(int) onNavigate;
  const GymLobby({super.key, required this.onNavigate});

 @override
  State<GymLobby> createState() => _GymLobbyState();
}

class _GymLobbyState extends State<GymLobby> {
  final Map<String, Map<String, dynamic>> weeklyPlan = {
    'Monday': {'split': 'Chest & Triceps', 'time': '10:00 AM'},
    'Tuesday': {'split': 'Back & Biceps', 'time': '6:00 PM'},
    'Wednesday': {'split': 'Legs', 'time': '7:00 AM'},
    'Thursday': {'split': 'Shoulders', 'time': '5:30 PM'},
    'Friday': {'split': 'Arms & Cardio', 'time': '6:00 PM'},
    'Saturday': {'split': 'Full Body', 'time': '9:00 AM'},
    'Sunday': {'split': 'Rest Day', 'time': 'N/A'},
  };

  int _restDuration = 60;
  int _restRemaining = 60;
  bool _isTimerRunning = false;
  Timer? _restTimer;

  @override
  void dispose() {
    _restTimer?.cancel();
    super.dispose();
  }

  String _getTodayWorkout() {
    final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    final today = DateTime.now().weekday - 1;
    final day = days[today];
    return day;
  }

  void _startRestTimer() {
    if (_isTimerRunning) return;
    
    setState(() {
      _isTimerRunning = true;
      _restRemaining = _restDuration;
    });

    _restTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_restRemaining > 0) {
          _restRemaining--;
        } else {
          _isTimerRunning = false;
          timer.cancel();
          _showTimerCompleteDialog();
        }
      });
    });
  }

  void _pauseRestTimer() {
    _restTimer?.cancel();
    setState(() => _isTimerRunning = false);
  }

  void _resetRestTimer() {
    _restTimer?.cancel();
    setState(() {
      _isTimerRunning = false;
      _restRemaining = _restDuration;
    });
  }

  void _showTimerCompleteDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: GymAppColors.cardBg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [GymAppColors.accentGreen, Color(0xFF059669)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: GymAppColors.accentGreen.withOpacity(0.4),
                      blurRadius: 30,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: const Icon(Icons.check_circle, color: Colors.white, size: 60),
              ),
              const SizedBox(height: 24),
              const Text(
                "Rest Complete!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: GymAppColors.accentGreen,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Time to get back to work!",
                style: TextStyle(color: GymAppColors.textSecondary, fontSize: 14),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Got It!"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showRestTimerDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: GymAppColors.cardBg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Rest Timer",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: GymAppColors.primaryBlue,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 28),

                Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        GymAppColors.accentOrange.withOpacity(0.2),
                        GymAppColors.accentRed.withOpacity(0.1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(
                      color: _isTimerRunning ? GymAppColors.accentOrange : GymAppColors.primaryBlue,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "${_restRemaining ~/ 60}:${(_restRemaining % 60).toString().padLeft(2, '0')}",
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w800,
                        color: GymAppColors.primaryBlue,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildDurationButton("30s", 30),
                    _buildDurationButton("1m", 60),
                    _buildDurationButton("2m", 120),
                    _buildDurationButton("3m", 180),
                  ],
                ),
                const SizedBox(height: 20),

                TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: "Custom (seconds)",
                    prefixIcon: Icon(Icons.timer),
                  ),
                  onChanged: (value) {
                    final duration = int.tryParse(value);
                    if (duration != null && duration > 0) {
                      setState(() {
                        _restDuration = duration;
                        _restRemaining = duration;
                      });
                    }
                  },
                ),
                const SizedBox(height: 28),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _isTimerRunning ? _pauseRestTimer : _startRestTimer,
                        icon: Icon(_isTimerRunning ? Icons.pause : Icons.play_arrow),
                        label: Text(_isTimerRunning ? "Pause" : "Start"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _resetRestTimer,
                        icon: const Icon(Icons.refresh),
                        label: const Text("Reset"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Close"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showWeeklyPlanEditor() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: GymAppColors.cardBg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Edit Weekly Plan",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: GymAppColors.primaryBlue,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 24),
                ...weeklyPlan.entries.map((entry) {
                  final day = entry.key;
                  final data = entry.value;
                  final splitController = TextEditingController(text: data['split']);
                  final timeController = TextEditingController(text: data['time']);

                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: GymAppColors.darkBg.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white.withOpacity(0.1)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              day,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: GymAppColors.primaryBlue,
                              ),
                            ),
                            const SizedBox(height: 12),
                            TextField(
                              controller: splitController,
                              decoration: const InputDecoration(hintText: "Workout Split"),
                              style: const TextStyle(fontWeight: FontWeight.w500),
                              onChanged: (value) {
                                setState(() => weeklyPlan[day]!['split'] = value);
                              },
                            ),
                            const SizedBox(height: 12),
                            TextField(
                              controller: timeController,
                              decoration: const InputDecoration(hintText: "Time (e.g., 10:00 AM)"),
                              style: const TextStyle(fontWeight: FontWeight.w500),
                              onChanged: (value) {
                                setState(() => weeklyPlan[day]!['time'] = value);
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  );
                }).toList(),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Save Changes"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getUpcomingWorkouts() {
    final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    final today = DateTime.now().weekday - 1;
    final upcoming = <Map<String, dynamic>>[];

    for (int i = 0; i < 3; i++) {
      final dayIndex = (today + i) % 7;
      final day = days[dayIndex];
      final data = weeklyPlan[day]!;
      upcoming.add({
        'day': day,
        'split': data['split'],
        'time': data['time'],
      });
    }

    return upcoming;
  }
  
  @override
  Widget build(BuildContext context) {
    final upcomingWorkouts = _getUpcomingWorkouts();
    final todayWorkout = _getTodayWorkout();
    final todayData = weeklyPlan[todayWorkout]!;
    return Scaffold(
      appBar: AppBar(
        title: const Text("SMARTFIT"),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      drawer: _buildDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [GymAppColors.primaryBlue, Color(0xFF0056CC)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: GymAppColors.primaryBlue.withOpacity(0.4),
                          blurRadius: 30,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: const Icon(Icons.bolt, color: Colors.white, size: 40),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome back,",
                        style: TextStyle(color: GymAppColors.textSecondary, fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Athlete",
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, letterSpacing: 0.5),
                      ),
                    ],
                  )
                ],
              ),
            ),
Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Card(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: LinearGradient(
                      colors: [GymAppColors.primaryBlue.withOpacity(0.15), GymAppColors.accentCyan.withOpacity(0.1)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: GymAppColors.primaryBlue.withOpacity(0.2),
                            ),
                            child: const Icon(Icons.calendar_today, color: GymAppColors.primaryBlue, size: 24),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Today's Workout",
                                  style: TextStyle(color: GymAppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 0.3),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  todayData['split'],
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Scheduled Time: ${todayData['time']}",
                        style: TextStyle(color: GymAppColors.textSecondary, fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 44,
                        child: ElevatedButton(
                          onPressed: () => widget.onNavigate(1),
                          child: const Text("Set Up Your Workout Routine", style: TextStyle(fontWeight: FontWeight.w700)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Upcoming Schedule",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 16),
                   ...upcomingWorkouts.map((workout) => Column(
                    children: [
                      _buildScheduleItem(workout['day'], workout['split'], workout['time'], Icons.fitness_center_rounded, GymAppColors.primaryBlue),
                      const SizedBox(height: 12),
                    ],
                  )).toList(),      
                ],
              ),
            ),
            const SizedBox(height: 32),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Quick Actions",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildQuickActionCard(
                         "Rest Timer",
                          "${_restRemaining ~/ 60}:${(_restRemaining % 60).toString().padLeft(2, '0')}",
                          Icons.timer,
                          GymAppColors.accentOrange,
                          _showRestTimerDialog, 
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildQuickActionCard(
                          "Weekly Plan",
                          "Edit schedule",
                          Icons.calendar_month,
                          GymAppColors.primaryBlue,
                          _showWeeklyPlanEditor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
Widget _buildDurationButton(String label, int seconds) {
    final isSelected = _restDuration == seconds;
    return InkWell(
      onTap: () => setState(() {
        _restDuration = seconds;
        _restRemaining = seconds;
      }),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? GymAppColors.primaryBlue : GymAppColors.cardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? GymAppColors.primaryBlue : Colors.white.withOpacity(0.1),
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : GymAppColors.textSecondary,
            fontSize: 11,
          ),
        ),
      ),
    );
  }
  
  Widget _buildScheduleItem(String day, String workout, String time, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withOpacity(0.2),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    day,
                    style: TextStyle(color: GymAppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 0.3),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    workout,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            Text(
              time,
              style: TextStyle(color: GymAppColors.textSecondary, fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionCard(String title, String subtitle, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              colors: [color.withOpacity(0.2), color.withOpacity(0.1)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withOpacity(0.3),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(color: GymAppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: GymAppColors.darkBg,
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [GymAppColors.darkBg, GymAppColors.primaryBlue.withOpacity(0.1)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.05))),
            ),
            child: Center(
              child: ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [GymAppColors.primaryBlue, GymAppColors.accentCyan],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                child: const Text(
                  "COMMAND CENTER",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ),
          _drawerTile(Icons.home_rounded, "Lobby", () => Navigator.pop(context)),
          _drawerTile(Icons.fitness_center_rounded, "Workout", () {
            Navigator.pop(context);
            widget.onNavigate(1);
          }),
          _drawerTile(Icons.person_rounded, "Profile", () {
            Navigator.pop(context);
            widget.onNavigate(2);
          }),
          _drawerTile(Icons.info_outline_rounded, "About", () {
            Navigator.pop(context);
            widget.onNavigate(3);
          }),
          const Spacer(),
          _drawerTile(Icons.logout_rounded, "Logout", () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
          }, color: GymAppColors.accentRed),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _drawerTile(IconData icon, String title, VoidCallback onTap, {Color? color}) {
    return ListTile(
      leading: Icon(icon, color: color ?? GymAppColors.primaryBlue, size: 24),
      title: Text(
        title,
        style: TextStyle(
          color: color ?? GymAppColors.textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
    );
  }
}
