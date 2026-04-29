import 'package:flutter/material.dart';
import '../constants.dart';
import 'login.dart';

class GymLobby extends StatelessWidget {
  final Function(int) onNavigate;
  const GymLobby({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Upcoming Schedule",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 16),
                  _buildScheduleItem("Monday", "Strength Training", "10:00 AM", Icons.fitness_center_rounded, GymAppColors.primaryBlue),
                  const SizedBox(height: 12),
                  _buildScheduleItem("Wednesday", "Cardio Blast", "6:00 PM", Icons.directions_run_rounded, GymAppColors.accentCyan),
                  const SizedBox(height: 12),
                  _buildScheduleItem("Friday", "Full Body", "7:00 AM", Icons.self_improvement_rounded, GymAppColors.accentGreen),
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
                          "Resume",
                          "Bench Press",
                          Icons.play_circle_fill,
                          GymAppColors.primaryBlue,
                          () {},
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildQuickActionCard(
                          "Quick",
                          "15 min",
                          Icons.flash_on,
                          GymAppColors.accentOrange,
                          () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: _buildQuickActionCard(
                      "Today's Plan",
                      "View full schedule",
                      Icons.calendar_today,
                      GymAppColors.accentGreen,
                      () {},
                    ),
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
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withOpacity(0.3),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
              Icon(Icons.arrow_forward_ios, color: color, size: 16),
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
