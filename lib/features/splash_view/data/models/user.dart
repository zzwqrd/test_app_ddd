class UserModle {
  UserModle({
    required this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.status,
  });

  final int id;
  final String name;
  final String email;
  final String gender;
  final String status;

  UserModle copyWith({
    int? id,
    String? name,
    String? email,
    String? gender,
    String? status,
  }) {
    return UserModle(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      status: status ?? this.status,
    );
  }

  factory UserModle.fromJson(Map<String, dynamic> json) {
    return UserModle(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      gender: json["gender"] ?? "",
      status: json["status"] ?? "",
    );
  }
  static List<UserModle> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => UserModle.fromJson(json)).toList();
  }
}
