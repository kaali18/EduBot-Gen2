import 'package:edubot/home_page.dart';
import 'package:flutter/material.dart';



class LoginPage extends StatefulWidget {



  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();

  final _passwordController = TextEditingController();


  bool _isDataMatched = true;

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
          // Column containing text fields and login button
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
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      validator: (value) {
                        // if(_isDataMatched){
                        //   return null;
                        // }else{
                        //   return 'not matching';
                        // }
                        if(value == null || value.isEmpty)
                        {
                          return 'username is empty';
                        }
                        else
                        {
                          return null;
                        }

                      }
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      validator: (value) {
                        // if(_isDataMatched){
                        //   return null;
                        // }else{
                        //   return 'not matching';
                        // }
                        if(value == null || value.isEmpty)
                        {
                          return 'password is empty';
                        }
                        else
                        {
                          return null;
                        }

                      }
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(30),
                            child: Visibility(
                              visible: !_isDataMatched,
                              child: Text('username password does not match',
                                style: TextStyle(
                                  color: Colors.red
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.yellow),
                            ),
                            onPressed: () {
                              if(_formKey.currentState!.validate()){
                                checkLogin(context);
                              }
                              else
                              {
                                print('Data Empty');
                              }
                              
                              //checkLogin(context);
                            },
                            child: const Text(
                              'Login',
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
                  ],
                ),
              ),
            ),
          ),
          const Positioned(
            bottom: 100,
            left: 100,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
              
                'Dont have an account?',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 254),
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),

              ),
            ),
          ),
          // Sign-up button positioned at the bottom
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                    onPressed: () {

                    },
                  
                child: const Text(
                  'SIGN-UP',
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

  void checkLogin(BuildContext ctx)
  {
    final _username =_usernameController.text;
    final _password = _passwordController.text;
    if(_username == _password)
    {
      print('username password match');
      Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (ctx1)=>HomeScreen()));
    }
    else{

      //final _errorMessage = 'Username Password doesnot match';
      //snackbar
      /*
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          margin: EdgeInsets.all(10),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          content: Text(_errorMessage,
            style: TextStyle(
              color: Colors.white,
            ),
          ) ,
          ),
        );
        */

      //Alert dialog
      /*

      showDialog(context: ctx, builder: (ctx4){
        return AlertDialog(
          title: Text('Error'),
          content: Text(_errorMessage),
          actions: [
            TextButton(onPressed: (){
              Navigator.of(ctx4).pop();
            }, 
            child: Text('close'),
            )
          ],
        );
      });
      */

      
      print('User name pass doesnt match');
      //Show text

    setState(() {
      _isDataMatched = false;
    });  


    }
  }
}
