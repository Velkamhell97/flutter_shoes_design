import 'package:flutter/material.dart';

import '../models/shoe.dart';

class ShoeInfo extends StatelessWidget {
  final Shoe shoe;
  final int paragraphs;

  const ShoeInfo({
    Key? key, 
    required this.shoe, 
    this.paragraphs = 1
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          shoe.name,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w700
          )
        ),
        for (int i = 0; i < paragraphs; i++) 
          Column(
            children: [
              const SizedBox(height: 10.0),
              Text(
                shoe.description,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.4,
                  fontWeight: FontWeight.w300
                )
              ),
            ],
          )
      ],
    );
  }
}