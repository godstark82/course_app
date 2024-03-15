import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:velocity_x/velocity_x.dart';

class FilterView extends StatelessWidget {
  const FilterView(
      {super.key, required this.decreasingFn, required this.increasingFn});

  final VoidCallback increasingFn;
  final VoidCallback decreasingFn;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Courses',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextButton(onPressed: () {}, child: Text('See more'))
            ],
          ),
        ),
        Row(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: const GradientBoxBorder(
                      gradient: LinearGradient(
                          colors: [Colors.blue, Colors.red, Colors.yellow]))),
              child: 'Filter'.text.makeCentered(),
            ),
            Container(
              height: 30,
              width: 2,
              color: Colors.grey,
            ),
            const SizedBox(width: 16),
            RawChip(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                label: const Text('Latest'),
                onPressed: increasingFn),
            const SizedBox(width: 10),
            RawChip(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                label: const Text('Oldest'),
                onPressed: decreasingFn),
            const SizedBox(width: 10),
          ],
        ),
      ],
    );
  }
}
