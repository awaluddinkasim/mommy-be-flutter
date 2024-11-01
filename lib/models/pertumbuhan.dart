class Pertumbuhan {
  final int id;
  final DateTime tanggal;
  final double beratBadan;
  final double panjangBadan;

  Pertumbuhan({
    required this.id,
    required this.tanggal,
    required this.beratBadan,
    required this.panjangBadan,
  });

  factory Pertumbuhan.fromJson(Map<String, dynamic> json) {
    return Pertumbuhan(
      id: json['id'],
      tanggal: DateTime.parse(json['tanggal']),
      beratBadan: json['berat_badan'].toDouble(),
      panjangBadan: json['panjang_badan'].toDouble(),
    );
  }
}
