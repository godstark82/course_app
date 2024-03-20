import 'package:cached_network_image/cached_network_image.dart';
import 'package:course_app/models/store_item_model.dart';
import 'package:flutter/material.dart';
import 'package:open_whatsapp/open_whatsapp.dart';

class ExploreStoreItem extends StatelessWidget {
  const ExploreStoreItem({super.key, required this.storeItem});
  final StoreItemModel storeItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                  aspectRatio: 16 / 9,
                  child: CachedNetworkImage(imageUrl: storeItem.image)),
              SizedBox(height: 25),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(storeItem.title,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(storeItem.category.name.toString(),
                                  style: TextStyle(color: Colors.grey)),
                              Text('Rs. ${storeItem.price}',
                                  style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))
                            ]),
                        SizedBox(height: 20),
                        Text(storeItem.description)
                      ]))
            ],
          )),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FilledButton(
            onPressed: () async {
              await FlutterOpenWhatsapp.sendSingleMessage("918290519977",
                  "Hi, \n I want to buy a item of title: ${storeItem.title} (Rs. ${storeItem.price})\n The Image of the product is by this link: ${storeItem.image}");
            },
            child: Text('Buy Now'),
          ),
        ));
  }
}
