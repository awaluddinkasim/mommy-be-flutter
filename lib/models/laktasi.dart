class Laktasi {
  final DateTime pukul;
  final String durasi;
  final String posisi;

  Laktasi({
    required this.pukul,
    required this.durasi,
    required this.posisi,
  });

  factory Laktasi.fromJson(Map<String, dynamic> json) {
    return Laktasi(
      pukul: DateTime.parse(json['pukul']),
      durasi: json['durasi'],
      posisi: json['posisi'],
    );
  }
}
