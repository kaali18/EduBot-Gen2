import 'package:edubot/Chatbot.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 342,
              width: 357,
              color: Colors.white.withOpacity(0.4),
            ),
          ),
          Positioned(
            top: 280,
            left: 30,
            child: Container(
          width: 79,
          height: 79,
          color: Colors.black,
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.note),
            color: Colors.white,
          ),
        ),
          ),
          SizedBox(height: 4),
          Positioned(
            top: 363,
            left: 30,
            child: Text(
              'Calender',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          
          
        
          Positioned(
            top: 280,
            left: 149,
            child: Container(
          width: 79,
          height: 79,
          color: Colors.black,
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.alarm),
            color: Colors.white,
          ),
        ),
          ),
          SizedBox(height: 4),
          Positioned(
            top: 363,
            left: 149,
            child: Text(
              'My Activity',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          
          
           Positioned(
            bottom: 10,
            left: 150,
            child: RawMaterialButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx2)=>ChatScreen()));
              },
              elevation: 2.0,
              fillColor: Colors.black.withOpacity(0.6),
              child: ImageIcon(
                AssetImage('assets/icon.png'), // Use your icon.png here
                color: Colors.yellow.withOpacity(0.6),
                size: 48.0, // Adjust the size as needed
              ),
              padding: EdgeInsets.all(15.0),
              shape: CircleBorder(),
            ),
          ),
          Positioned(
            top: 459,
            left: 30,
            child: Container(
          width: 79,
          height: 79,
          color: Colors.black,
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.auto_graph_sharp),
            color: Colors.white,
          ),
        ),
          ),
          SizedBox(height: 4),
          Positioned(
            top: 542,
            left: 30,
            child: Text(
              'Progress',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          
          Positioned(
            top: 459,
            left: 149,
            child: Container(
          width: 79,
          height: 79,
          color: Colors.black,
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings),
            color: Colors.white,
          ),
        ),
          ),
          SizedBox(height: 4),
          Positioned(
            top: 542,
            left: 149,
            child: Text(
              'Settings',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          
          Positioned(
            top: 459,
            left: 268,
            child: Container(
          width: 79,
          height: 79,
          color: Colors.black,
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.info),
            color: Colors.white,
          ),
        ),
          ),
          SizedBox(height: 4),
         Positioned(
            top: 542,
            left: 268,
            child: Text(
              'Info',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          
          Positioned(
            top: 280,
            left: 268,
          child: Container(
          width: 79,
          height: 79,
          color: Colors.black,
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.headphones),
            color: Colors.white,
          ),
        ),
          ),
          SizedBox(height: 4),
          Positioned(
            top: 363,
            left: 268,
            child: Text(
              'Music',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          
        ],
        
      ),
    );
  }

//   Widget _buildIconButtonWithText({required IconData icon, required String text}) {
//     return Column(
//       children: [
//         Container(
//           width: 79,
//           height: 79,
//           color: Colors.black,
//           child: IconButton(
//             onPressed: () {},
//             icon: Icon(icon),
//             color: Colors.white,
//           ),
//         ),
//         SizedBox(height: 4),
//         Text(
//           text,
//           style: TextStyle(
//             color: Colors.white,
//           ),
//         ),
//       ],
//     );
//   }
}
