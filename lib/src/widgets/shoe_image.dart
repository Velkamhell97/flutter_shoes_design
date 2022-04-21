import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/shoe.dart';
import '../providers/shoe_provider.dart';

class ShoeImage extends StatelessWidget {
  final Shoe shoe;

  const ShoeImage({Key? key, required this.shoe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ShoeProvider>(
      builder: (_, shoeNotifier, __) {
        final color = shoeNotifier.selectedColor;
        final scale = shoeNotifier.scale;

        return Stack(
          alignment: Alignment.center, 
          children: [
            /// Sombra artificial del zapato (se podrian probar otras soluciones)
            Transform.rotate(
              angle: 1.0,
              /// Se deberia modificar por si cambia el tamaño del container o la imagen
              child: Container(
                width: 100,
                height: 230,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xffEAA14E),
                      // color: Colors.black26,
                      offset: Offset(40, 0.0),
                      blurRadius: 30,
                      spreadRadius: 4
                    )
                  ]
                )
              ),
            ),
            AnimatedScale(
              duration: const Duration(milliseconds: 300),
              scale: scale,
              child: Image.asset(shoe.images[color])
            )
          ],
        );
      },
    );
  }
}