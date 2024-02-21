// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SearchBarHomeScreen extends StatelessWidget {
  const SearchBarHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 50,
          width: context.screenWidth * 0.70,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.search),
                SizedBox(width: 20),
                Text('Search for \'batches\'...')
              ],
            ),
          ),
        ),
        Container(
          height: 50,
          width: context.screenWidth*0.20,
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
              child: Text('Study', style: TextStyle(color: Colors.white))),
        )
      ],
    );
  }
}
