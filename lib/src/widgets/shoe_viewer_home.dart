import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:shoes_app/src/models/shoe.dart';
import 'package:shoes_app/src/widgets/widgets.dart';

class ShoeViewerHome extends StatelessWidget {
  final Shoe shoe;

  const ShoeViewerHome({Key? key, required this.shoe}) : super(key: key);
  
  Widget _backgroundHeroFlight (_, Animation<double> animation, __, ___, ____){
    return AnimatedBuilder(
      animation: animation, 
      builder: (context, child) {
        return  DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(lerpDouble(50.0, 20.0, animation.value)!),
              bottom: Radius.circular(lerpDouble(50.0, 40.0, animation.value)!),
            ),
            color: const Color(0xffFFCF53)
          ),
        );
      },
    );
  }

  //--Asi podemos manejar el cambio de tamaño de el shoe, sin que hayan saltos bruscos
  // Widget _imageHeroFlight (_, Animation<double> animation, __, ___, ____){
  //   return AnimatedBuilder(
  //     animation: animation, 
  //     builder: (context, child) {
  //       return Padding(
  //         padding: EdgeInsets.all(lerpDouble(20.0, 20.0, animation.value)!),
  //         child: ShoeImage(shoe: shoe)
  //       );
  //     },
  //   );
  // }

  Widget _buttonsHeroFlight (_, Animation<double> animation, HeroFlightDirection direction, BuildContext from, BuildContext to){
    final curveAnimation = CurvedAnimation(parent: animation, curve: Curves.easeOut);
    final opacity = Tween(begin: 1.0, end: 0.0).animate(curveAnimation);

    final child = direction == HeroFlightDirection.push ? from.widget : to.widget;

    return  FadeTransition(
      opacity: opacity,
      child: child,
    );
  }

  static const _buttonSize = 45.0;
  static const _buttonOffset = 20.0;

  @override
  Widget build(BuildContext context) {
    //Se deja todo en stack para que los hero se muevan de manera independiente
    //-de este modo los efectos son mucho mas fluidos, el problema es el calculo del espacio

    //-Ya que un stack mientras no tenga un children fuera de un positioned no adoptara un height
    //-por lo que toca setear heights fijos fuera del stack y jugar con los positioned para ubicarlos
    return Stack(
      children: [
        //----------------------------
        // Background
        //----------------------------
        Positioned.fill(
          child: Hero(
            tag: 'background',
            flightShuttleBuilder: _backgroundHeroFlight,
            child: const DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(50.0),
                  top: Radius.circular(50.0)
                ),
                color: Color(0xffFFCF53)
              ),
            ),
          )
        ),
        //----------------------------
        // Image
        //----------------------------
        Positioned.fill(
          bottom: _buttonOffset + _buttonSize,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Hero(
              tag: shoe.name,
              // flightShuttleBuilder: _imageHeroFlight,
              child:  ShoeImage(shoe: shoe),
            ),
          ),
        ),
        //----------------------------
        // Button Size
        //----------------------------
        Positioned(
          left: 20,
          right: 20,
          bottom: _buttonOffset,
          child: Hero(
            tag: 'size_buttons',
            flightShuttleBuilder: _buttonsHeroFlight,
            child: const SizeButtons(
              buttonSize: _buttonSize,
            ),
          ),
        )
      ],
    );
  }
}