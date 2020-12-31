class Right {
  int id;
  String name;

  Right({ this.id, this.name });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name
    };
  }
}