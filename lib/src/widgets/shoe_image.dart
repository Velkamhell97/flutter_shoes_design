import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes_app/src/models/shoe.dart';
import 'package:shoes_app/src/models/shoe_notifier.dart';

class ShoeImage extends StatelessWidget {
  final Shoe shoe;

  const ShoeImage({Key? key, required this.shoe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shoeProvider = Provider.of<ShoeNotifier>(context);

    return Stack(
      alignment: Alignment.center, 
      // fit: StackFit.expand,
      children: [
        //-Sombra artificial del zapato
        Transform.rotate(
          angle: 1.0,
          child: Container(
            width: 100,
            height: 230,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: const [
                BoxShadow(
                  // color: Color(0xffEAA14E),
                  color: Colors.black26,
                  offset: Offset(40, 0.0),
                  blurRadius: 30,
                  spreadRadius: 4
                )
              ]
            )
          ),
        ),
        Image.asset(
          shoe.images[shoeProvider.selectedColor],
        ),
      ],
    );
  }
}