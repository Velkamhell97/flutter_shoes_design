import 'package:flutter/material.dart';

class ShoeNotifier extends ChangeNotifier {
  int _selectedSize = 0;

  int get selectedSize => _selectedSize;

  set selectedSize(int selectedSize) {
    _selectedSize = selectedSize;
    notifyListeners();
  }

  int _selectedColor = 0;

  int get selectedColor => _selectedColor;

  set selectedColor(int selectedColor) {
    _selectedColor = selectedColor;
    notifyListeners();
  }

}