class User {
  int id;
  int male, female;
  String name, birth;

  User({ this.id, this.name, this.male, this.female, this.birth });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'male': male,
      'female': female,
      'birth': birth
    };
  }
}