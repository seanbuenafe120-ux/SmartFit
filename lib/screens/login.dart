import 'package:flutter/material.dart';
import '../constants.dart';
import '../main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      _showSnackBar("Please fill in all fields", GymAppColors.accentRed);
      return;
    }

    setState(() => _isLoading = true);
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) {
        setState(() => _isLoading = false);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      }
    });
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(fontWeight: FontWeight.w500)),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
      ),
    );
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
              GymAppColors.darkBg,
              GymAppColors.darkBg.withOpacity(0.98),
              GymAppColors.primaryBlue.withOpacity(0.05),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
              child: _FadeInAnimation(
                animationController: _animationController,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
  
                    ScaleTransition(
                      scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                        CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
                      ),
                      child: Container(
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
                              color: GymAppColors.primaryBlue.withOpacity(0.5),
                              blurRadius: 40,
                              spreadRadius: 10,
                            ),
                            BoxShadow(
                              color: GymAppColors.primaryBlue.withOpacity(0.2),
                              blurRadius: 80,
                              spreadRadius: 20,
                            ),
                          ],
                        ),
                        child: const Icon(Icons.bolt, size: 64, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 40),
                    
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [GymAppColors.primaryBlue, GymAppColors.accentCyan],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds),
                      child: const Text(
                        "SMARTFIT",
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 3,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Level Up Your Performance",
                      style: TextStyle(
                        color: GymAppColors.textSecondary,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 70),
                    
                    // Email Field
                    _buildTextField(
                      controller: _emailController,
                      hint: "Email Address",
                      icon: Icons.email_outlined,
                      enabled: !_isLoading,
                    ),
                    const SizedBox(height: 24),
                    
                    _buildTextField(
                      controller: _passwordController,
                      hint: "Password",
                      icon: Icons.lock_outline,
                      enabled: !_isLoading,
                      obscureText: _obscurePassword,
                      onVisibilityToggle: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),
                    const SizedBox(height: 60),
                    
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleLogin,
                        child: _isLoading
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  strokeWidth: 2.5,
                                ),
                              )
                            : const Text("LOGIN", style: TextStyle(letterSpacing: 1.5)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: OutlinedButton(
                        onPressed: _isLoading
                            ? null
                            : () {
                                _emailController.text = "demo@smartfit.com";
                                _passwordController.text = "demo123";
                                _handleLogin();
                              },
                        child: const Text("Try Demo Account"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool enabled = true,
    bool obscureText = false,
    VoidCallback? onVisibilityToggle,
  }) {
    return TextField(
      controller: controller,
      enabled: enabled,
      obscureText: obscureText,
      style: const TextStyle(color: GymAppColors.textPrimary, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon),
        suffixIcon: obscureText != false
            ? IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: GymAppColors.textSecondary,
                ),
                onPressed: onVisibilityToggle,
              )
            : null,
      ),
    );
  }
}

class _FadeInAnimation extends StatelessWidget {
  final AnimationController animationController;
  final Widget child;

  const _FadeInAnimation({
    required this.animationController,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
      ),
      child: child,
    );
  }
}
