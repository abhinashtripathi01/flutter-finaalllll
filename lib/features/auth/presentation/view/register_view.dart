import 'package:flaviourfleet/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20.0),
            _buildTextField('First Name', false),
            const SizedBox(height: 20.0),
            _buildTextField('Last Name', false),
            const SizedBox(height: 20.0),
            _buildTextField('Email address', false),
            const SizedBox(height: 20.0),
            _buildTextField('Address', false),
            const SizedBox(height: 20.0),
            _buildTextField('Password', true),
            const SizedBox(height: 20.0),
            _buildTextField('Confirm Password', true),
            const SizedBox(height: 20.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text('Sign Up'),
              onPressed: () {
                // Handle signup logic here
              },
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Already have an account?',
                  style: TextStyle(color: Colors.black),
                ),
                TextButton(
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.orangeAccent),
                  ),
                  onPressed: () {
                    ref.read(authViewModelProvider.notifier).openLoginView();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.orange[50],
    );
  }

  Widget _buildTextField(String labelText, bool obscureText) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: labelText,
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.black),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orangeAccent),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orangeAccent),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
