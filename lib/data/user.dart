class DataUser {
  final String nama;
  final String email;
  final String? password;
  final DateTime tanggalLahir;
  final String nomorHp;

  const DataUser({
    required this.email,
    required this.nama,
    this.password,
    required this.tanggalLahir,
    required this.nomorHp,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'nama': nama,
        'password': password,
        'tgl_lahir': tanggalLahir.toString(),
        'no_hp': nomorHp,
      };
}
