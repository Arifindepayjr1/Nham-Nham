class Category {
  final String id;
  final String name;
  final String iconUrl;

  const Category({
    required this.id, 
    required this.name, 
    required this.iconUrl
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'iconUrl': iconUrl,
    };
  }

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as String,
      name: json['name'] as String,
      iconUrl: json['iconUrl'] as String,
    );
  }
}
