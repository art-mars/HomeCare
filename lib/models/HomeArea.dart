// creates an area of the home
// Done
class HomeArea {
  final String id;
  final String name;
  bool isSelected;

  HomeArea({required this.id, required this.name, this.isSelected = false});

  // convert home area to JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'isSelected': isSelected,
  };

  // create home area from JSON
  factory HomeArea.fromJson(Map<String, dynamic> json) => HomeArea(
    id: json['id'],
    name: json['name'],
    isSelected: json['isSelected'],
  );
}