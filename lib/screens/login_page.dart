import 'package:chatbot/providers/auth_provider.dart';
import 'package:chatbot/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: AppSizes.gapMedium),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 20),
            if (authProvider.isLoading)
              const CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: () {
                  final username = _usernameController.text;
                  final password = _passwordController.text;
                  authProvider.login(username, password);
                },
                child: const Text('Login'),
              ),
            if (authProvider.errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  authProvider.errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
