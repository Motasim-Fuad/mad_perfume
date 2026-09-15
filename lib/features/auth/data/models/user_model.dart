class UserModel {
  const UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    this.password = '',
    this.avatarUrl =
        'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
    this.address = '68 Place Vendome, 75001 Paris, France',
  });

  final String id;
  final String fullName;
  final String email;
  final String phone;
  final String password;
  final String avatarUrl;
  final String address;

  UserModel copyWith({
    String? fullName,
    String? email,
    String? phone,
    String? password,
    String? address,
  }) {
    return UserModel(
      id: id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      avatarUrl: avatarUrl,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullName': fullName,
        'email': email,
        'phone': phone,
        'password': password,
        'avatarUrl': avatarUrl,
        'address': address,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String? ?? '',
      fullName: json['fullName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      password: json['password'] as String? ?? '',
      avatarUrl: json['avatarUrl'] as String? ?? '',
      address: json['address'] as String? ?? '',
    );
  }
}
