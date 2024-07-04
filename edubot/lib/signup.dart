import 'package:edubot/login_screen.dart';
import 'package:edubot/home_page.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _usernameController = TextEditingController();
  //final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/wall.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Icon position
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Image.asset(
                  'assets/icon.png',
                  width: 300,
                  height: 300,
                ),
              ),
            ),
          ),
          // Column containing text fields and signup button
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      controller: _usernameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Email adress',
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                      validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email address is required';
                          } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }else{
                              return null;
                          }
                           
                        },

                    ),
                    
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.yellow),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Perform signup action
                          // For demonstration purposes, simply navigate to the home screen
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (ctx1) => HomeScreen()));
                        }
                      },
                      child: const Text(
                        'Proceed',
                        style: TextStyle(
                          color: Color.fromARGB(255, 53, 52, 45),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Positioned widget for "Already have an account?" text
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Already have an account?',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 254),
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          // Positioned widget for "Login" button
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                onPressed: () {
                  // Navigate to the login screen
                  // Replace 'LoginPage()' with your actual login screen widget
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ));
                },
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Color.fromARGB(255, 231, 231, 104),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                    decorationColor: Color.fromARGB(255, 231, 231, 104),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
