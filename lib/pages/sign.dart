import 'package:flutter/material.dart';
import 'package:passtrack/colors.dart';

class SignInUp extends StatefulWidget {
  const SignInUp({super.key});

  @override
  State<SignInUp> createState() => _SignInUpState();
}

class _SignInUpState extends State<SignInUp> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool _isSignUp = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(color: mcgpalette0[50], fontSize: 22),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: mcgpalette0[50]!),
        useMaterial3: true,
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(_isSignUp ? 'Sign Up' : 'Account'),
            centerTitle: true,
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.phone), text: 'Mobile'),
                Tab(icon: Icon(Icons.email_outlined), text: 'Email'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _buildForm('phone'),
              _buildForm('email'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm(String type) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: type == 'phone' ? 'Enter your phone number' : 'Enter your email',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your ${type == 'phone' ? 'phone number' : 'email address'}.';
                  }
                  return null;
                },
                onSaved: (value) => _email = value!,
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Enter password',
                  suffixIcon: Icon(Icons.visibility_off),
                ),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password.';
                  }
                  return null;
                },
                onSaved: (value) => _password = value!,
              ),
              if (_isSignUp) ...[
                const SizedBox(height: 20.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Confirm password',
                    suffixIcon: Icon(Icons.visibility_off),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please confirm your password.';
                    }
                    if (value != _password) {
                      return 'Passwords do not match.';
                    }
                    return null;
                  },
                ),
              ],
              const SizedBox(height: 20.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: mcgpalette0[50],
                  minimumSize: const Size(double.infinity, 40)
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    print('${_isSignUp ? "Sign Up" : "Sign In"}: $_email, Password: $_password');
                  }
                },
                child: Text(_isSignUp ? 'Sign Up' : 'Sign In', style: const TextStyle(color: Colors.white)),
              ),
              if (!_isSignUp) ...[
                const SizedBox(height: 20.0),
                TextButton(
                  onPressed: () {
                    print('Forgot password clicked');
                  },
                  child: const Text('Forgot password?', style: TextStyle(color: Colors.blue)),
                ),
              ],
              const SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(_isSignUp ? 'Already have an account?' : 'Don\'t have an account?'),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isSignUp = !_isSignUp;
                      });
                    },
                    child: Text(
                      _isSignUp ? 'Sign In' : 'Create account',
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}