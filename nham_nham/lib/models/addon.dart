class AddOnOption {
  final String id;
  final String name;
  final double price;

  const AddOnOption({
    required this.id,
    required this.name,
    required this.price,
  });
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
}
