class Contact {
  final int? id; // id bisa null atau int
  final String name;
  final String phoneNumber;
  final String? email; // email bisa null atau string

  Contact({
    this.id,
    required this.name, //diperlukan 
    required this.phoneNumber,
    this.email,
  });

  Map<String, dynamic> toMap() { //menyimpan data dalam penguncian nilai
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) { //factory adalah konstruktor khusus yang memungkinkan Anda untuk mengontrol proses pembuatan objek.
    return Contact(
      id: map['id'],
      name: map['name'],
      phoneNumber: map['phoneNumber'],
      email: map['email'],
    );
  }
}
