class DataRegister {
  final String nama;
  final String email;
  final String password;
  final DateTime tanggalLahir;
  final String nomorHp;

  DataRegister({
    required this.nama,
    required this.email,
    required this.password,
    required this.tanggalLahir,
    required this.nomorHp,
  });

  Map<String, dynamic> toJson() => {
        'nama': nama,
        'email': email,
        'password': password,
        'tgl_lahir': tanggalLahir.toString(),
        'no_hp': nomorHp,
      };
}
