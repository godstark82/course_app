// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutusScreen extends StatelessWidget {
  const AboutusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () async {
                await launchUrl(
                  Uri.parse('https://www.instagram.com/codewithvenom/'),
                );
              },
              icon: Icon(LineIcons.instagram, size: 26, color: Colors.pink))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Center(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/images/notepediax_black.png',
                        height: context.width * 0.75,
                        width: context.width * 0.75,
                      ))),
              SizedBox(height: 30),
              Text(
                'About Notepediax',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
              ),
              SizedBox(height: 10),
              Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
                style: TextStyle(fontSize: 16, color: Colors.grey.shade800),
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
