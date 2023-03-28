class Users {
  final String email;
  final String address;
  final String phone;
  // final List<String> favoriteList;

  Users({
    required this.email,
    required this.address,
    required this.phone,
    // required this.favoriteList,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      // 'address': address,
      // 'phone': phone,
      // 'favoriteList': favoriteList,
    };
  }

  static Users fromMap(Map<String, dynamic> map) {
    return Users(
      email: map['email'],
      address: map['address'],
      phone: map['phone'],
      // favoriteList: List<String>.from(map['favoriteList']),
    );
  }

  Users copyWith({
    String? email,
    String? address,
    String? phone,
    List<String>? favoriteList,
  }) {
    return Users(
      email: email ?? this.email,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      // favoriteList: favoriteList ?? this.favoriteList,
    );
  }
}
