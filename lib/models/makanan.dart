class Makanan {
  final String nama;
  final double kalori;
  final double porsi;

  Makanan({
    required this.nama,
    required this.kalori,
    required this.porsi,
  });

  factory Makanan.fromJson(Map<String, dynamic> json) {
    return Makanan(
      nama: json['nama'],
      kalori: double.parse(json['kalori'].toString()),
      porsi: double.parse(json['porsi'].toString()),
    );
  }
}
