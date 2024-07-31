import 'package:flutter/material.dart';

class IntroBox extends StatelessWidget {
  final Icon icon;
  final String title;
  final String sampleText1;
  final String sampleText2;
  final Function(String) onTap; // Add onTap callback

  IntroBox({
    required this.icon,
    required this.title,
    required this.sampleText1,
    required this.sampleText2,
    required this.onTap, // Add onTap parameter
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Icon(
            icon.icon,
            size: 28,
          ),
          SizedBox(height: 1),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Column(
            children: <Widget>[
              GestureDetector(
                onTap: () => onTap(sampleText1), // Add onTap handler
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    sampleText1,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => onTap(sampleText2), // Add onTap handler
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    sampleText2,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}