// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SearchBarHomeScreen extends StatelessWidget {
  const SearchBarHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 35,
          width: context.screenWidth * 0.75,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.search),
              SizedBox(width: 20),
              Text('Search for \'batches\'...')
            ],
          ),
        )
      ],
    );
  }
}
