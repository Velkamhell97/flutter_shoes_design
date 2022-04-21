import 'package:flutter/material.dart';

/// Si hubieran varios shoes se podria crear un state para cada uno con estos valores
class ShoeProvider extends ChangeNotifier {
  int _selectedSize = 0;
  int get selectedSize => _selectedSize;
  set selectedSize(int selectedSize) {
    _selectedSize = selectedSize;
    notifyListeners();
  }

  static const Map<int, double> _scales = {
    0: 0.9,
    1: 0.95,
    2: 1.0,
    3: 1.05,
    4: 1.1,
    5: 1.15
  };

  double get scale => _scales[_selectedSize]!;

  int _selectedColor = 0;
  int get selectedColor => _selectedColor;
  set selectedColor(int selectedColor) {
    _selectedColor = selectedColor;
    notifyListeners();
  }
}