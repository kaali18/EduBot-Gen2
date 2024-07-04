import 'package:flutter/material.dart';
import 'package:navassist/camera_screen.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Text('NavAssist')
          ),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.purpleAccent,
      body: Center(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to NavAssist!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white)
              ),
              onPressed: () {

                Navigator.of(context).push(MaterialPageRoute(builder: (ctx1)=>CameraScreen()));

              },

              child: Text(
                'Start Camera Obstacle Detection',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w500
                ),
              )
            ),
            SizedBox(height: 20),

            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white)
              ),
              onPressed: () {

                

              },
              child: Text(
                'Other Features',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}