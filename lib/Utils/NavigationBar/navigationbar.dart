import 'package:firebase_authentication/UserPage/All%20Post/perform_posts.dart';
import 'package:firebase_authentication/Utils/NavigationBar/customapaint.dart';
import 'package:flutter/material.dart';

class Navigation extends StatelessWidget {
  const Navigation({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: 80,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(size.width, 80),
            painter: BNBCustomePainter(),
          ),
          Center(
            heightFactor: 0.6,
            child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const PerformPost()));
                },
                backgroundColor: Colors.purple,
                elevation: 0.1,
                child: const Icon(Icons.add)),
          ),
        ],
      ),
    );
  }
}
