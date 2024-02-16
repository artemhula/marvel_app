class Character {
  final String name;
  final String description;
  final String image;
  const Character(
      {required this.name, required this.description, required this.image});

  factory Character.fromjson(Map<String, dynamic> json) => Character(
        name: json['name'],
        description: json['description'],
        image: json['thumbnail']['path'] + '.' + json['thumbnail']['extension'],
      );
}
