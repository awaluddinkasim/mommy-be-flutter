class DataBayi {
  final String nama;
  final String jenisKelamin;
  final DateTime tanggalLahir;

  DataBayi({
    required this.nama,
    required this.jenisKelamin,
    required this.tanggalLahir,
  });

  Map<String, dynamic> toJson() => {
        'nama': nama,
        'jenis_kelamin': jenisKelamin,
        'tgl_lahir': tanggalLahir.toString(),
      };
}
