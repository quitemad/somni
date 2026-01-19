import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/util/navigation_util.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

final sl = GetIt.instance;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});


  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _passwordConfirmCtrl = TextEditingController();
  final _occupationCtrl = TextEditingController();
  final _ageCtrl = TextEditingController();
  String _gender = 'male';
  bool _obscure = true;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _passwordConfirmCtrl.dispose();
    _occupationCtrl.dispose();
    _ageCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final name = _nameCtrl.text.trim();
    final email = _emailCtrl.text.trim();
    final password = _passwordCtrl.text;
    final passwordConfirmation = _passwordConfirmCtrl.text;
    final gender = _gender;
    final age = int.tryParse(_ageCtrl.text) ?? 0;
    final occupation = _occupationCtrl.text.trim();

    context.read<AuthBloc>().add(RegisterRequested(
      name: name,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
      gender: gender,
      age: age,
      occupation: occupation,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          NavigationUtil.replace(context, '/home');
        }
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg_fog_plain.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Hero(tag: "fullMoon", child: Image(image: AssetImage("assets/svgs/mini_moon.png"), height: 80)),
                    const SizedBox(height: 12),
                    Text('Create account', style: theme.textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withAlpha(30),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _nameCtrl,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(labelText: 'Full name', prefixIcon: Icon(Icons.person,color: Colors.white,),labelStyle: TextStyle(color: Colors.white)),
                              validator: (v) => (v == null || v.trim().isEmpty) ? 'Name required' : null,
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _emailCtrl,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email,color: Colors.white),labelStyle: TextStyle(color: Colors.white)),
                              validator: (v) {
                                if (v == null || v.trim().isEmpty) return 'Email required';
                                final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                                if (!emailRegex.hasMatch(v.trim())) return 'Invalid email';
                                return null;
                              },
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _passwordCtrl,
                                    obscureText: _obscure,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      labelStyle: TextStyle(color: Colors.white),
                                      prefixIcon: const Icon(Icons.lock,color: Colors.white,),
                                      suffixIcon: IconButton(
                                        icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off,color: Colors.white,),
                                        onPressed: () => setState(() => _obscure = !_obscure),
                                      ),
                                    ),
                                    validator: (v) {
                                      if (v == null || v.isEmpty) return 'Password required';
                                      if (v.length < 6) return 'Min 6 chars';
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: TextFormField(
                                    controller: _passwordConfirmCtrl,
                                    obscureText: _obscure,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(labelText: 'Confirm', labelStyle: TextStyle(color: Colors.white),prefixIcon: Icon(Icons.lock_outline,color: Colors.white,)),
                                    validator: (v) {
                                      if (v == null || v.isEmpty) return 'Confirm required';
                                      if (v != _passwordCtrl.text) return 'Passwords do not match';
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _ageCtrl,
                                    keyboardType: TextInputType.number,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                        labelText: 'Age',
                                        labelStyle: TextStyle(color: Colors.white),
                                        prefixIcon: Icon(Icons.calendar_today, color: Colors.white,)),
                                    validator: (v) {
                                      if (v == null || v.isEmpty) return 'Age required';
                                      if (int.tryParse(v) == null) return 'Invalid age';
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: TextFormField(
                                    controller: _occupationCtrl,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(labelText: 'Occupation', prefixIcon: Icon(Icons.work,color: Colors.white,),labelStyle: TextStyle(color: Colors.white)),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Text('Gender:', style: TextStyle(color: Colors.white70)),
                                const SizedBox(width: 8),
                                DropdownButton<String>(
                                  value: _gender,
                                  dropdownColor: theme.colorScheme.primary,
                                  items: const [
                                    DropdownMenuItem(value: 'male', child: Text('Male',style: TextStyle(color: Colors.white70))),
                                    DropdownMenuItem(value: 'female', child: Text('Female',style: TextStyle(color: Colors.white70))),
                                    DropdownMenuItem(value: 'other', child: Text('Other',style: TextStyle(color: Colors.white70))),
                                  ],
                                  onChanged: (v) => setState(() => _gender = v ?? 'male'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                final loading = state is AuthLoading;
                                return SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: loading ? null : _submit,
                                    style: ElevatedButton.styleFrom(backgroundColor: theme.colorScheme.primary, padding: const EdgeInsets.symmetric(vertical: 14)),
                                    child: loading
                                        ? const SizedBox(height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2))
                                        : const Text('Register',style: TextStyle(color: Colors.white),),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 8),
                            TextButton(
                              onPressed: () => NavigationUtil.goTo(context, '/login'),
                              child: const Text('Already have an account? Login', style: TextStyle(color: Colors.white70)),
                            ),
                          ],
                        ),
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
}