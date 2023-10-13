class VehicleColor {
  final int id;
  final String name;
  final String hex;

  VehicleColor({
    required this.id,
    required this.name,
    required this.hex,
  });

  factory VehicleColor.fromJson(Map<String, dynamic> json) {
    return VehicleColor(
      id: int.parse(json['id']),
      name: json['name'],
      hex: json['hex'],
    );
  }
}
