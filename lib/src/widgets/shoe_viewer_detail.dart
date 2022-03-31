import 'package:flutter/material.dart';

import '../widgets/widgets.dart';
import '../models/shoe.dart';

class ShowViewerDetail extends StatelessWidget {
  final Shoe shoe;

  const ShowViewerDetail({Key? key, required this.shoe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        //----------------------------
        // Background
        //----------------------------
        const Hero(
          tag: 'background',
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(40.0),
                top: Radius.circular(20.0)
              ),
              color: Color(0xffFFCF53)
            ),
          ),
        ),
        //----------------------------
        // Image
        //----------------------------
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Hero(
              tag: shoe.name,
              child: ShoeImage(shoe: shoe),
            ),
          ),
        ),
        //----------------------------
        // Fake Size Buttons
        //----------------------------
        const Positioned(
          left: 20.0,
          right: 20.0,
          bottom: 20.0,
          child: Hero(
            tag: 'size_buttons',
            child: Opacity(
              opacity: 0,
              child: IgnorePointer(child: SizeButtons(buttonSize: 40))
            )
          ),
        )
      ],
    );
  }
}