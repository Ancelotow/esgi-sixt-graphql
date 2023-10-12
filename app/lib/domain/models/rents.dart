class Rent {
  final String id;
  final int nbDays;
  final int amountExcluding;
  final int? vatRate;
  final String rentAt;
  final String createdAt;
  final int vehicleId;
  final int userId;
  final int statusId;


  Rent({
    required this.id,
    required this.nbDays,
    required this.amountExcluding,
    this.vatRate,
    required this.rentAt,
    required this.createdAt,
    required this.vehicleId,
    required this.userId,
    required this.statusId,
  });

  Rent copyWith({
    String? id,
    int? nbDays,
    int? amountExcluding,
    int? vatRate,
    String? rentAt,
    String? createdAt,
    int? vehicleId,
    int? userId,
    int? statusId,
  }) {
    return Rent(
      id: id ?? this.id,
      nbDays: nbDays ?? this.nbDays,
      amountExcluding: amountExcluding ?? this.amountExcluding,
      vatRate: vatRate ?? this.vatRate,
      rentAt: rentAt ?? this.rentAt,
      createdAt: createdAt ?? this.createdAt,
      vehicleId: vehicleId ?? this.vehicleId,
      userId: userId ?? this.userId,
      statusId: statusId ?? this.statusId,
    );
  }
}