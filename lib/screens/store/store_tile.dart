// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:course_app/models/store_item_model.dart';
import 'package:course_app/screens/store/explore_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class StoreTile extends StatelessWidget {
  const StoreTile({super.key, required this.storeItem, required this.index});
  final StoreItemModel storeItem;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => ExploreStoreItem(storeItem: storeItem));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        padding: EdgeInsets.all(8),
        height: context.screenHeight * 0.25,
        width: context.screenWidth * 0.25,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: '${index}0',
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: storeItem.image,
                  height: 100,
                ),
              ),
            ),
            Text(
              storeItem.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              storeItem.category.name.toString(),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              'Rs. ${storeItem.price}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
