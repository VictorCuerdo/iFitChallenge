import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ifitchallenge/controllers/navigation_utils.dart';

class PlanDisplay extends StatelessWidget {
  const PlanDisplay({super.key});


  @override
  Widget build(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double iconSize = screenWidth * 0.08; // Adjust the size as needed

  return Scaffold(
  backgroundColor: Color(0xFF242A3A),
  body: SafeArea(
  child: Padding(
  padding: EdgeInsets.only(
  left: 16.0,
  right: 16.0,
  bottom: MediaQuery.of(context).size.height * 0.05),
  child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Adjust for symmetrical spacing
  children: <Widget>[
  Row( // Wrap IconButton in a Row
  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Push the icon to the right
  children: [
  Container(), // Empty container to balance the row
  IconButton(
  padding: const EdgeInsets.only(right: 16),
  onPressed: () {
  // Replace with your navigation logic
  Navigator.of(context).pushReplacementNamed('/HomePage');
  },
  splashRadius: iconSize * 0.6,
  icon: Icon(Icons.close_outlined, color: Colors.white, size: iconSize),
  ),
  ],
  ),
  const SizedBox(height: 20),
  const Text(
  'YOUR PLAN IS READY',
  style: TextStyle(
  fontSize: 32,
  color: Colors.white,
  fontWeight: FontWeight.bold),
  ),
  const SizedBox(height: 10),
  const Text(
  'YOU ARE CLOSER TO YOUR GOAL!',
  style: TextStyle(fontSize: 18, color: Colors.white),
  ),
  const SizedBox(height: 20),
  Expanded(
  child: Container(
  decoration: BoxDecoration(
  color: const Color(0xFF242A3A),
  border: Border.all(color: const Color(0xFFFC5C7D), width: 3),
  borderRadius: BorderRadius.circular(3),
  ),
  child: Padding( // Added padding inside the container
  padding: const EdgeInsets.symmetric(horizontal: 16.0), // Horizontal padding for inner content
  child: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
  const CircleAvatar(
  radius: 50,
  backgroundImage: AssetImage('assets/images/finlandia_flag.png'),
  ),
  const SizedBox(height: 20),
  const Text(
  'WEEK 1: WEEK OF EVALUATION',
  style: TextStyle(fontSize: 20, color: Colors.white),
  ),
  const SizedBox(height: 10),
  const Padding( // Padding for subtitle text
  padding: EdgeInsets.symmetric(horizontal: 8.0), // Adjust this value as needed
  child: AutoSizeText(
  'We will adjust your training plan so it adapts better to your performance',
  style: TextStyle(fontSize: 18, color: Colors.grey),
  minFontSize: 12,
  maxLines: 3,
  ),
  ),
    const SizedBox(height: 20),
    const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          children: <Widget>[
            Text('3', style: TextStyle(fontSize: 24, color: Colors.white)),
            SizedBox(height: 4), // Adjust spacing as needed
            Text('Times a week', style: TextStyle(fontSize: 16, color: Colors.white)),
          ],
        ),
        Column(
          children: <Widget>[
            Text('7-10', style: TextStyle(fontSize: 24, color: Colors.white)),
            SizedBox(height: 4), // Adjust spacing as needed
            Text('MIN', style: TextStyle(fontSize: 16, color: Colors.white)),
          ],
        ),
        Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.flash_on, color: Color(0xFFFC5C7D)),
                Icon(Icons.flash_on, color: Colors.grey),
                Icon(Icons.flash_on, color: Colors.grey),
              ],
            ),
            SizedBox(height: 12), // Adjust spacing as needed
            Text('LEVEL', style: TextStyle(fontSize: 16, color: Colors.white)),
          ],
        ),
      ],
    ),
  const SizedBox(height: 50),
  ElevatedButton(
  onPressed: () {
    Navigator.of(context).pushReplacementNamed('/PayWall');
  },
  style: ElevatedButton.styleFrom(
  foregroundColor: Colors.white,
  backgroundColor: Colors.transparent,
  shadowColor: Colors.black.withOpacity(0.2),
  elevation: 4,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
  padding: EdgeInsets.zero, // Set padding to zero
  ).copyWith(
  backgroundColor: MaterialStateProperty.resolveWith<Color>(
  (Set<MaterialState> states) {
  if (states.contains(MaterialState.pressed)) {
  return Colors.white;
  }
  return Colors.transparent; // Use the same gradient as the container here
  },
  ),
  overlayColor: MaterialStateProperty.resolveWith<Color>(
  (Set<MaterialState> states) {
  if (states.contains(MaterialState.pressed)) {
  return Colors.transparent;
  }
  return Colors.transparent;
  },
  ),
  ),
  child: Ink(
  decoration: BoxDecoration(
  gradient: LinearGradient(
  colors: [
  const Color(0xFFA54664).withOpacity(0.7),
  const Color(0xFFFC5C7D).withOpacity(0.7),
  const Color(0xFF005C97).withOpacity(0.7),
  ],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  ),
  borderRadius: BorderRadius.circular(20.0),
  ),
  child: Container(
  constraints: const BoxConstraints(minWidth: double.infinity, minHeight: 48), // Fill the width
  alignment: Alignment.center,
  child: const Text(
  'GET MY PLAN',
  textAlign: TextAlign.center,
  style: TextStyle(
  fontFamily: 'Open Sans',
  fontSize: 18,
  fontWeight: FontWeight.bold,
  ),
  ),
  ),
  ),
  ),
  ],
  ),
  ),
  ),
  ),
  ],
  ),
  ),
  ),
  );
  }
  }




