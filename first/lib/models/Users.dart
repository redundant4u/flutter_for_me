class Users {
  int id;
  List<bool> gender;
  String name, birth;

  Users({ this.id, this.name, this.gender, this.birth });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'birth': birth
    };
  }
}