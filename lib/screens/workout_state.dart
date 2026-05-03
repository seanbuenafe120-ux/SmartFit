class WorkoutState {
  static final WorkoutState _instance = WorkoutState._internal();
  
  final List<Map<String, dynamic>> workouts = [];
  
  factory WorkoutState() {
    return _instance;
  }
  
  WorkoutState._internal();
  
  void addWorkout(Map<String, dynamic> workout) {
    workouts.add(workout);
  }
  
  void updateWorkout(int index, Map<String, dynamic> workout) {
    if (index >= 0 && index < workouts.length) {
      workouts[index] = workout;
    }
  }
  
  void removeWorkout(int index) {
    if (index >= 0 && index < workouts.length) {
      workouts.removeAt(index);
    }
  }
  
  void incrementSets(int index) {
    if (index >= 0 && index < workouts.length) {
      workouts[index]['sets']++;
    }
  }
  
  void decrementSets(int index) {
    if (index >= 0 && index < workouts.length && workouts[index]['sets'] > 0) {
      workouts[index]['sets']--;
    }
  }
  
  void clearWorkouts() {
    workouts.clear();
  }
  
  List<Map<String, dynamic>> getWorkouts() {
    return workouts;
  }
}
