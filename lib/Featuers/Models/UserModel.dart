class UserModel {
  late String uid; // Firebase user ID
  late String name;
  late String username;
  late String email;
  late String phoneNumber;
  late String hashedPassword;

  UserModel({
    required this.uid,
    required this.name,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.hashedPassword,
  });

  // Factory method to create a UserModel from a Map (data from Firestore)
  factory UserModel.fromMap(Map<String, dynamic> data, String uid) {
    return UserModel(
      uid: uid,
      name: data['name'] ?? '',
      username: data['username'] ?? '',
      email: data['email'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      hashedPassword: data['password'] ?? '',
    );
  }

  // Convert the UserModel to a Map for storing in Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': hashedPassword,
    };
  }
}
