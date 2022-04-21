import 'package:flutter/material.dart';

import '../widgets/widgets.dart';
import '../models/shoe.dart';

class ShowViewerDetail extends StatelessWidget {
  final Shoe shoe;

  const ShowViewerDetail({Key? key, required this.shoe}) : super(key: key);

  static const _buttonPadding = 20.0;
  static const _imagePadding = 18.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //----------------------------
        // Background
        //----------------------------
        const Positioned.fill(
          child: Hero(
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
        ),

        //----------------------------
        // Image And Buttons
        //----------------------------
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(_imagePadding),
                child: Hero(
                  tag: shoe.name,
                  child: ShoeImage(shoe: shoe)
                )
              ),
            ),
            const Padding(
              padding:  EdgeInsets.fromLTRB(_buttonPadding, 0.0, _buttonPadding, _buttonPadding),
              child: Hero(
                tag: 'size_buttons',
                child: SizedBox()
              )
            )
          ],
        )

        //----------------------------
        // Image
        //----------------------------
        // Positioned.fill(
        //   child: Padding(
        //     padding: const EdgeInsets.all(_buttonPadding),
        //     child: Hero(
        //       tag: shoe.name,
        //       child: ShoeImage(shoe: shoe),
        //     ),
        //   ),
        // ),
        // //----------------------------
        // // Fake Size Buttons
        // //----------------------------
        // const Positioned(
        //   left: 20.0,
        //   right: 20.0,
        //   bottom: 20.0,
        //   child: Hero(
        //     tag: 'size_buttons',
        //     // child: SizedBox(height: 40), /// Tambien funciona bien
        //     child: Opacity(
        //       opacity: 0,
        //       child: IgnorePointer(child: SizeButtons())
        //     )
        //   ),
        // )
      ],
    );
  }
}