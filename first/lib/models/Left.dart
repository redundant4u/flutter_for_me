class Left {
  int id;
  String name;

  Left({ this.id, this.name });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name
    };
  }
}