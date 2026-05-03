import 'package:flutter/material.dart';
import '../constants.dart';
import 'workout_state.dart';

class WorkoutTracker extends StatefulWidget {
  const WorkoutTracker({super.key});

  @override
  State<WorkoutTracker> createState() => _WorkoutTrackerState();
}

class _WorkoutTrackerState extends State<WorkoutTracker> {
final WorkoutState _workoutState = WorkoutState();

  final Map<String, List<String>> _suggestions = {
    'Bench Press': ['Incline Dumbbell Press', 'Chest Flyes', 'Push-ups'],
    'Squats': ['Leg Press', 'Leg Curls', 'Calf Raises'],
    'Deadlifts': ['Barbell Rows', 'Pull-ups', 'Lat Pulldowns'],
    'Barbell Rows': ['Deadlifts', 'Face Pulls', 'Shrugs'],
    'Bicep Curls': ['Hammer Curls', 'Preacher Curls', 'Cable Curls'],
    'Tricep Dips': ['Tricep Rope Pushdowns', 'Overhead Press', 'Close Grip Bench'],
    'Shoulder Press': ['Lateral Raises', 'Front Raises', 'Shrugs'],
    'Leg Press': ['Squats', 'Leg Curls', 'Leg Extensions'],
    'Lat Pulldowns': ['Pull-ups', 'Assisted Pull-ups', 'Barbell Rows'],
    'Treadmill': ['Elliptical', 'Rowing Machine', 'Stair Climber'],
  };

  String? _getSuggestion() {
    final workouts = _workoutState.getWorkouts();
    if (workouts.isEmpty) return null;
    
    final lastExercise = workouts.last['name'] as String;
    
    if (_suggestions.containsKey(lastExercise)) {
      final suggestions = _suggestions[lastExercise];
      if (suggestions != null && suggestions.isNotEmpty) {
        return suggestions.first;
      }
    }
    
    for (final key in _suggestions.keys) {
      if (key.toLowerCase() == lastExercise.toLowerCase()) {
        final suggestions = _suggestions[key];
        if (suggestions != null && suggestions.isNotEmpty) {
          return suggestions.first;
        }
      }
    }
    
    for (final key in _suggestions.keys) {
      if (lastExercise.toLowerCase().contains(key.toLowerCase()) || 
          key.toLowerCase().contains(lastExercise.toLowerCase())) {
        final suggestions = _suggestions[key];
        if (suggestions != null && suggestions.isNotEmpty) {
          return suggestions.first;
        }
      }
    }
    
    if (lastExercise.toLowerCase().contains('bench') || lastExercise.toLowerCase().contains('press')) {
      return 'Incline Dumbbell Press';
    } else if (lastExercise.toLowerCase().contains('squat') || lastExercise.toLowerCase().contains('leg')) {
      return 'Leg Press';
    } else if (lastExercise.toLowerCase().contains('row') || lastExercise.toLowerCase().contains('pull')) {
      return 'Lat Pulldowns';
    } else if (lastExercise.toLowerCase().contains('curl')) {
      return 'Hammer Curls';
    } else if (lastExercise.toLowerCase().contains('dip')) {
      return 'Tricep Rope Pushdowns';
    } else if (lastExercise.toLowerCase().contains('shoulder') || lastExercise.toLowerCase().contains('raise')) {
      return 'Lateral Raises';
    } else if (lastExercise.toLowerCase().contains('cardio') || lastExercise.toLowerCase().contains('treadmill')) {
      return 'Elliptical';
    }
    
    return null;
  }

  void _showWorkoutDialog({int? index}) {
    final isEditing = index != null;
    final workouts = _workoutState.getWorkouts();
    final workout = isEditing ? workouts[index] : null;

    final nameController = TextEditingController(text: workout?['name'] ?? "");
    final setsController = TextEditingController(text: workout?['sets']?.toString() ?? "3");
    final repsController = TextEditingController(text: workout?['reps']?.toString() ?? "10");
    final weightController = TextEditingController(text: workout?['weight']?.toString() ?? "");

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
                Text(
                  isEditing ? "Edit Exercise" : "Add Exercise",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: GymAppColors.primaryBlue,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 28),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(hintText: "Exercise Name"),
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: setsController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(hintText: "Sets"),
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: repsController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(hintText: "Reps"),
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: weightController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: "Weight (lbs)"),
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 28),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (nameController.text.isNotEmpty) {
                            final data = {
                              "name": nameController.text,
                              "sets": int.tryParse(setsController.text) ?? 3,
                              "reps": int.tryParse(repsController.text) ?? 10,
                              "weight": weightController.text.isNotEmpty ? double.tryParse(weightController.text) : null,
                            };
                            setState(() {
                              if (isEditing) {
                                _workoutState.updateWorkout(index!, data); 
                              } else {
                                _workoutState.addWorkout(data);
                              }
                            });
                            Navigator.pop(context);
                          }
                        },
                        child: Text(isEditing ? "Update" : "Add"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final workouts = _workoutState.getWorkouts();
    final suggestion = _getSuggestion();
    final showSuggestion = workouts.isNotEmpty && suggestion != null;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("MY ROUTINE"),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
body: Column(
        children: [
          // Suggestive Bar - Only shown if workouts added
          if (showSuggestion)
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [
                    GymAppColors.accentCyan.withOpacity(0.2),
                    GymAppColors.primaryBlue.withOpacity(0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(
                  color: GymAppColors.accentCyan.withOpacity(0.3),
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: GymAppColors.accentCyan.withOpacity(0.3),
                    ),
                    child: const Icon(
                      Icons.lightbulb_outline,
                      color: GymAppColors.accentCyan,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Suggested Next Exercise",
                          style: TextStyle(
                            color: GymAppColors.textSecondary,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.3,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          suggestion!,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: GymAppColors.accentCyan,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      final nameController = TextEditingController(text: suggestion);
                      final setsController = TextEditingController(text: "3");
                      final repsController = TextEditingController(text: "10");
                      final weightController = TextEditingController();

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
                                    "Add Exercise",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w800,
                                      color: GymAppColors.primaryBlue,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  const SizedBox(height: 28),
                                  TextField(
                                    controller: nameController,
                                    decoration: const InputDecoration(hintText: "Exercise Name"),
                                    style: const TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          controller: setsController,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(hintText: "Sets"),
                                          style: const TextStyle(fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: TextField(
                                          controller: repsController,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(hintText: "Reps"),
                                          style: const TextStyle(fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  TextField(
                                    controller: weightController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(hintText: "Weight (lbs)"),
                                    style: const TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 28),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: OutlinedButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: const Text("Cancel"),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            if (nameController.text.isNotEmpty) {
                                              setState(() {
                                                _workoutState.addWorkout({
                                                  "name": nameController.text,
                                                  "sets": int.tryParse(setsController.text) ?? 3,
                                                  "reps": int.tryParse(repsController.text) ?? 10,
                                                  "weight": weightController.text.isNotEmpty ? double.tryParse(weightController.text) : null,
                                                });
                                              });
                                              Navigator.pop(context);
                                            }
                                          },
                                          child: const Text("Add"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        Icons.add_circle_outline,
                        color: GymAppColors.accentGreen,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          // Workout List
          Expanded(
            child: workouts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.fitness_center_rounded, size: 80, color: GymAppColors.textSecondary.withOpacity(0.3)),
                        const SizedBox(height: 24),
                        Text(
                          "No workouts added yet!",
                          style: TextStyle(color: GymAppColors.textSecondary, fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Start building your routine",
                          style: TextStyle(color: GymAppColors.textSecondary.withOpacity(0.6), fontSize: 14),
                        ),
                        const SizedBox(height: 40),
                        ElevatedButton.icon(
                          onPressed: () => _showWorkoutDialog(),
                          icon: const Icon(Icons.add),
                          label: const Text("Add Exercise"),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: workouts.length,
                    itemBuilder: (context, index) {
                      final item = workouts[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 56,
                                    height: 56,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: const LinearGradient(
                                        colors: [GymAppColors.primaryBlue, Color(0xFF0056CC)],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: GymAppColors.primaryBlue.withOpacity(0.3),
                                          blurRadius: 15,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                    ),
                                    child: const Icon(Icons.fitness_center_rounded, color: Colors.white, size: 28),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['name'],
                                          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "Sets: ${item['sets']} • Reps: ${item['reps']}${item['weight'] != null ? ' • ${item['weight']} lbs' : ''}",
                                          style: TextStyle(color: GymAppColors.textSecondary, fontSize: 13, fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  _buildActionButton(
                                    Icons.add_circle_outline,
                                    GymAppColors.accentGreen,
                                    () => setState(() => _workoutState.incrementSets(index)),
                                  ),
                                  const SizedBox(width: 8),
                                  _buildActionButton(
                                    Icons.remove_circle_outline,
                                    GymAppColors.primaryBlue,
                                    () => setState(() => _workoutState.decrementSets(index)),
                                  ),
                                  const SizedBox(width: 8),
                                  _buildActionButton(
                                    Icons.edit_outlined,
                                    GymAppColors.accentCyan,
                                    () => _showWorkoutDialog(index: index),
                                  ),
                                  const SizedBox(width: 8),
                                  _buildActionButton(
                                    Icons.delete_outline,
                                    GymAppColors.accentRed,
                                    () => setState(() => _workoutState.removeWorkout(index)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showWorkoutDialog(),
        backgroundColor: GymAppColors.primaryBlue,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(icon, color: color, size: 24),
      ),
    );
  }
}
