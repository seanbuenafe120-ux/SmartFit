import 'package:flutter/material.dart';
import '../constants.dart';

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
                            setState(() {
                              final data = {
                                "name": nameController.text,
                                "sets": int.tryParse(setsController.text) ?? 3,
                                "reps": int.tryParse(repsController.text) ?? 10,
                                "weight": weightController.text.isNotEmpty ? double.tryParse(weightController.text) : null,
                              };
                              if (isEditing) {
                                _workouts[index] = data;
                              } else {
                                _workouts.add(data);
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("MY ROUTINE"),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: _workouts.isEmpty
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
              itemCount: _workouts.length,
              itemBuilder: (context, index) {
                final item = _workouts[index];
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
                              () => setState(() => item['sets']++),
                            ),
                            const SizedBox(width: 8),
                            _buildActionButton(
                              Icons.remove_circle_outline,
                              GymAppColors.primaryBlue,
                              () => setState(() {
                                if (item['sets'] > 0) item['sets']--;
                              }),
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
                              () => setState(() => _workouts.removeAt(index)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
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
