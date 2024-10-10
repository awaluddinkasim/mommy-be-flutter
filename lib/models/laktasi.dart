class Laktasi {
  final DateTime mulai;
  final DateTime selesai;
  final String posisi;

  Laktasi({
    required this.mulai,
    required this.selesai,
    required this.posisi,
  });

  factory Laktasi.fromJson(Map<String, dynamic> json) {
    return Laktasi(
      mulai: DateTime.parse(json['mulai']),
      selesai: DateTime.parse(json['selesai']),
      posisi: json['posisi'],
    );
  }
}
