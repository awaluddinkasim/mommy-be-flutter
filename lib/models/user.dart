class User {
  final String email;
  final String nama;
  final int usia;
  final DateTime tanggalLahir;
  final String nomorHp;

  const User({
    required this.email,
    required this.nama,
    required this.usia,
    required this.tanggalLahir,
    required this.nomorHp,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      nama: json['nama'],
      usia: json['usia'],
      tanggalLahir: DateTime.parse(json['tgl_lahir']),
      nomorHp: json['no_hp'],
    );
  }
}
