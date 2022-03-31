class Shoe {
  final String name;
  final String description;
  final double price;
  final List<String> images;

  static const _path = 'assets/images';
  
  static const _colors =  [
    '$_path/black.png',
    '$_path/blue.png',
    '$_path/yellow.png',
    '$_path/green.png',
  ];

  static const shoe = Shoe(
    name: 'Nike Air Max 720',
    description: 'The nike Air Max 720 goes bigger than ever before with Nike\'s taller Air unit yet, offering more air underfoot for unmaginable all-day comfort Has Air Max gone too far? We hope so.',
    price: 180.0,
    images: _colors
  );

  const Shoe({
    required this.name, 
    required this.description, 
    required this.price, 
    required this.images
  });
}