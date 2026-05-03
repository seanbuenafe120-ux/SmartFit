import 'package:flutter/material.dart';
import '../constants.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ABOUT SMARTFIT"),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
          
            Container(
              padding: const EdgeInsets.all(24),
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
                    blurRadius: 40,
                    spreadRadius: 8,
                  ),
                ],
              ),
              child: const Icon(Icons.verified_user_rounded, color: Colors.white, size: 60),
            ),
            const SizedBox(height: 24),
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [GymAppColors.primaryBlue, GymAppColors.accentCyan],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: const Text(
                "SMARTFIT",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Colors.white),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Premium Experience for High-Performance Athletes",
              style: TextStyle(color: GymAppColors.textSecondary, fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 32),
            
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      "A next-generation fitness tracking environment designed for high-performance athletes.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: GymAppColors.textSecondary,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 1,
                      color: Colors.white.withOpacity(0.1),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Developed by Cedric, Sean, Michael, and Princess",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: GymAppColors.textSecondary,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            Text(
              "© 2026 SMARTFIT. All rights reserved.",
              style: TextStyle(color: GymAppColors.textSecondary.withOpacity(0.5), fontSize: 12),
            ),
            const SizedBox(height: 8),
            Text(
              "Designed for athletes. Built for performance.",
              style: TextStyle(color: GymAppColors.textSecondary.withOpacity(0.5), fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

}
