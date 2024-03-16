// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactusScreen extends StatelessWidget {
  const ContactusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
        elevation: 1,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text(
                  'You can get in touch with us through below platforms. Our Team will reach out to you as soon asit would be possible',
                  style: TextStyle(color: Colors.grey)),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Customer Support',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      ListTile(
                        onTap: () {
                          launchUrl(Uri.parse('tel:+918290519977'));
                        },
                        title: Text('Contact Number',
                            style: TextStyle(fontSize: 14, color: Colors.grey)),
                        leading: CircleAvatar(
                            backgroundColor: Colors.grey.shade100,
                            child: Icon(
                              Icons.phone_outlined,
                              color: Colors.grey,
                            )),
                        subtitle: Text(
                          '+918290519977',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          launchUrl(Uri.parse(
                              'mailto:venomleader9977?subject=From App'));
                        },
                        title: Text(
                          'Email Address',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        leading: CircleAvatar(
                            backgroundColor: Colors.grey.shade100,
                            child:
                                Icon(Icons.mail_outline, color: Colors.grey)),
                        subtitle: Text(
                          'venomleader9977@gmail.com',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    // boxShadow: [
                    // BoxShadow(color: Colors.grey,offset: Offset(-1, 1),bl),
                    // ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Social Media',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      ListTile(
                        onTap: () async {
                          await launchUrl(Uri.parse(
                              'https://www.instagram.com/codewithvenom/'));
                        },
                        title: Text('Instagram',
                            style: TextStyle(fontSize: 14, color: Colors.grey)),
                        leading: CircleAvatar(
                            backgroundColor: Colors.pink.shade400,
                            child: Icon(
                              LineIcons.instagram,
                              color: Colors.white,
                            )),
                        subtitle: Text(
                          '@notepediax',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListTile(
                        onTap: () async {
                          await launchUrl(Uri.parse(
                              'https://www.instagram.com/codewithvenom/'));
                        },
                        title: Text(
                          'Twitter',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        leading: CircleAvatar(
                            backgroundColor: Colors.blue,
                            child:
                                Icon(LineIcons.twitter, color: Colors.white)),
                        subtitle: Text(
                          '@notepediax_official',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListTile(
                        onTap: () async {
                          await launchUrl(Uri.parse(
                              'https://www.instagram.com/codewithvenom/'));
                        },
                        title: Text(
                          'Facebook',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        leading: CircleAvatar(
                            backgroundColor: Colors.blue.shade800,
                            child:
                                Icon(LineIcons.facebookF, color: Colors.white)),
                        subtitle: Text(
                          '@notepediax',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
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
