class Model {
  final String name;
  final String price;
  final String description;
  final String category;
  final List image;
  final String id;

  Model({
    required this.name,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.id,

  });
}

class TabBarMenuButton {
  final int id;
  final String name;

  TabBarMenuButton({required this.id, required this.name});
}
