import 'package:flutter/material.dart';
import 'dart:ui';

import '../models/shoe.dart';
import '../widgets/widgets.dart';

class ShoeViewerHome extends StatelessWidget {
  final Shoe shoe;

  const ShoeViewerHome({Key? key, required this.shoe}) : super(key: key);
  
  Widget _backgroundHeroFlight (_, Animation<double> animation, __, ___, ____){
    return AnimatedBuilder(
      animation: animation, 
      builder: (context, child) => DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(lerpDouble(50.0, 20.0, animation.value)!),
            bottom: Radius.circular(lerpDouble(50.0, 40.0, animation.value)!),
          ),
          color: const Color(0xffFFCF53)
        ),
      )
    );
  }

  /// Asi podemos manejar el cambio de tamaño de el shoe, sin que hayan saltos bruscos
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
    final traslation = Tween(begin: const Offset(0.0, 0.0), end: const Offset(0.0, -3.0)).animate(animation);

    final child = direction == HeroFlightDirection.push ? from.widget : to.widget;

    /// Con esto se puede compensar la transicion de los botones para la Forma con columna
    return  SlideTransition(
      position: traslation,
      child: FadeTransition(
        opacity: opacity, 
        child: child
      ),
    );
  }

  static const _buttonPadding = 20.0;
  static const _imagePadding = 18.0;

  // static const _buttonSize = 45.0;
  // static const _buttonOffset = 20.0;

  @override
  Widget build(BuildContext context) {
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

        /// Forma con Columna, auqnue sea mas limpio y sintactico, tiene un problema al momento de ocultar
        /// los botones en la otra pantalla porque se tienen que reemplazar por un SizedBox por lo que
        /// no data el mismo efecto que con los elementos con positioned, pero es bastante aceptable, una
        /// ventaja esque los tamaños estan correctamente asignados por la columna y se puede hacer un poco
        /// mas responsve
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
                  child: ShoeImage(shoe: shoe),
                ),
              ),
            ),
            Padding(
              padding:  const EdgeInsets.fromLTRB(_buttonPadding, 0.0, _buttonPadding, _buttonPadding),
              child: Hero(
                tag: 'size_buttons',
                flightShuttleBuilder: _buttonsHeroFlight,
                child: const SizeButtons()
              )
            )
          ],
        )

        /// Forma con Positioneds, Tiene la ventaja de que podemos manejar de una manera mas completa las tran
        /// siciones hero, y se noten menos flicks, por ejemplo podemos modficar la forma en la que desaparece
        /// los botones, el unico problema esque es mas dificil posicionar los widgets ya que toca tener en cuenta
        /// el espacio que ocupan otros widgets si se quieren posicionar como el estilo de una columna
        //----------------------------
        // Image
        //----------------------------
        // Positioned.fill(
        //   bottom: _buttonOffset + _buttonSize,
        //   child: Padding(
        //     padding: const EdgeInsets.all(_buttonPadding),
        //     child: Hero(
        //       tag: shoe.name,
        //       child: ShoeImage(shoe: shoe),
        //     ),
        //   ),
        // ),
        // //----------------------------
        // // Button Size
        // //----------------------------
        // Positioned(
        //   left: _buttonPadding,
        //   right: _buttonPadding,
        //   bottom: _buttonOffset,
        //   child: Hero(
        //     tag: 'size_buttons',
        //     flightShuttleBuilder: _buttonsHeroFlight,
        //     child: const SizeButtons(),
        //   ),
        // )
      ],
    );
  }
}