class Bayi {
  final int id;
  final String nama;
  final String jenisKelamin;
  final DateTime tanggalLahir;

  Bayi({
    required this.id,
    required this.nama,
    required this.jenisKelamin,
    required this.tanggalLahir,
  });

  factory Bayi.fromJson(Map<String, dynamic> json) {
    return Bayi(
      id: json['id'],
      nama: json['nama'],
      jenisKelamin: json['jenis_kelamin'],
      tanggalLahir: DateTime.parse(json['tgl_lahir']),
    );
  }
}
