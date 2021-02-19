class User {
  int id;
  int male, female;
  String name, year, month, day;

  User({ this.id, this.name, this.male, this.female, this.year, this.month, this.day });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'male': male,
      'female': female,
      'year': year,
      'month': month,
      'day': day,
    };
  }
}