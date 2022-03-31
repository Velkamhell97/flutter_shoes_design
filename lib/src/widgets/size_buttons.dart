import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shoes_app/src/models/shoe_notifier.dart';

class SizeButtons extends StatelessWidget {
  final double buttonSize;

  const SizeButtons({Key? key, required this.buttonSize}) : super(key: key);

  static const _sizes = [7, 7.5, 8, 8.5, 9, 9.5];

  @override
  Widget build(BuildContext context) {
    final shoeProvider = Provider.of<ShoeNotifier>(context);

    return Row( 
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(_sizes.length, (index) {
        final selected = index == shoeProvider.selectedSize;

        return Flexible(
          child: GestureDetector(
            onTap: () => shoeProvider.selectedSize = index,
            child: Container(
              alignment: Alignment.center,
              width: buttonSize,
              height: buttonSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: selected ? const Color(0xffF1A23A) : Colors.white,
                boxShadow:[ 
                  BoxShadow(
                    color: const Color(0xffF1A23A),
                    blurRadius: selected ? 10 : 0,
                    spreadRadius: selected ? 3 : 0,
                  )
                ]
              ),
              child: Material( //--Para evitar errore en el hero (modo stack)
                type: MaterialType.transparency, 
                child: Text(
                  _sizes[index].toString(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: selected ? Colors.white : const Color(0xffF1A23A)
                  )
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}