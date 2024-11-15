class Pertumbuhan {
  final int id;
  final int usia;
  final double beratBadan;
  final double tinggiBadan;

  Pertumbuhan({
    required this.id,
    required this.usia,
    required this.beratBadan,
    required this.tinggiBadan,
  });

  factory Pertumbuhan.fromJson(Map<String, dynamic> json) {
    return Pertumbuhan(
      id: json['id'],
      usia: json['usia'],
      beratBadan: json['berat_badan'].toDouble(),
      tinggiBadan: json['panjang_badan'].toDouble(),
    );
  }
}
