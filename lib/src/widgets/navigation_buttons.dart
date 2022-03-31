import 'package:flutter/material.dart';

class NavigationButtons extends StatefulWidget {
  const NavigationButtons({Key? key}) : super(key: key);

  @override
  _NavigationButtonsState createState() => _NavigationButtonsState();
}

class _NavigationButtonsState extends State<NavigationButtons> {
  final Map<IconData, VoidCallback> _button = {
    Icons.star          : () {},
    Icons.shopping_cart : () {},
    Icons.settings      : () {},
  };

  IconData _selected = Icons.star;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _button.entries.map((entry) {
        //Utilizar este en vez de iconbutton da un efecto de sombra al hacer click
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            primary: Colors.white,
            padding: const EdgeInsets.all(15.0)
          ),
          onPressed: () {
            setState(() => _selected = entry.key);
            entry.value();
          }, 
          child: Icon(
            entry.key, 
            color: _selected == entry.key ? Colors.red : Colors.grey
          )
        );
      }).toList(),
    );
  }
}