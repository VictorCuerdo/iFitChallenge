import 'package:flutter/material.dart';

class AuthDivider extends StatelessWidget {
  const AuthDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: const Row(
        children: [
          Expanded(
            child: Divider(
              color: Colors.white,
              height: 1,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              'OR',
              style: TextStyle(
                fontFamily: 'Open Sans',
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              color: Colors.white,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}
