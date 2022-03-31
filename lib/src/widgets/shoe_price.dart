import 'package:flutter/material.dart';
import 'package:shoes_app/src/models/shoe.dart';

class ShoePrice extends StatelessWidget {
  final Shoe shoe;
  final double animation;
  final VoidCallback onTapBuy;
  final String text;
  final EdgeInsets? buttonPadding;

  const ShoePrice({
    Key? key, 
    required this.shoe, 
    this.animation = 0, 
    required this.onTapBuy,
    required this.text,
    this.buttonPadding
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '\$${shoe.price}',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800
          )
        ),
        Transform.translate(
          offset: Offset(0.0, animation),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.orange,
              padding: buttonPadding,
              shape: const StadiumBorder()
            ),
            onPressed: onTapBuy, 
            child: Text(text)
          ),
        )
      ],
    );
  }
}