class Bayi {
  final String nama;
  final String jenisKelamin;
  final String tanggalLahir;

  Bayi({
    required this.nama,
    required this.jenisKelamin,
    required this.tanggalLahir,
  });

  factory Bayi.fromJson(Map<String, dynamic> json) {
    return Bayi(
      nama: json['nama'],
      jenisKelamin: json['jenis_kelamin'],
      tanggalLahir: json['tgl_lahir'],
    );
  }
}
