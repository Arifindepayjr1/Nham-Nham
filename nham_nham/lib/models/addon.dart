class AddOnOption {
  final String id;
  final String name;
  final double price;

  const AddOnOption({
    required this.id,
    required this.name,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
    };
  }

  factory AddOnOption.fromJson(Map<String, dynamic> json) {
    return AddOnOption(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
    );
  }
}



class AddOnGroup {
  final String id;
  final String name;
  final List<AddOnOption> options;

  const AddOnGroup({
    required this.id,
    required this.name,
    required this.options,
  });

    Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'options': options.map((option) => option.toJson()).toList(),
    };
  }

  factory AddOnGroup.fromJson(Map<String, dynamic> json) {
    return AddOnGroup(
      id: json['id'] as String,
      name: json['name'] as String,
      options: (json['options'] as List<dynamic>)
          .map((option) => AddOnOption.fromJson(option as Map<String, dynamic>))
          .toList(),
    );
  }
}
