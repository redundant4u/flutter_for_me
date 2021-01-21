class Right {
  int id;
  double dB1, dB2, dB3, dB4, dB5, dB6, dB7;
  String name, date;

  Right({ this.id, this.name, this.dB1, this.dB2, this.dB3, this.dB4, this.dB5, this.dB6, this.dB7, this.date });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'dB1': dB1,
      'dB2': dB2,
      'dB3': dB3,
      'dB4': dB4,
      'dB5': dB5,
      'dB6': dB6,
      'dB7': dB7,
      'date': date
    };
  }
}