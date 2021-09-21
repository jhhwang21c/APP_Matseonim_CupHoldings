class UserData {
  final String name, phoneNumber, email, password;
  final String? profession, interest;

  const UserData({
    required this.name, 
    required this.phoneNumber, 
    required this.email, 
    required this.password,
    this.profession,
    this.interest
  });
}