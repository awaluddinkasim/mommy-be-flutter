class DataPertumbuhan {
  final DateTime tanggal;
  final double beratBadan;
  final double panjangBadan;

  DataPertumbuhan({
    required this.tanggal,
    required this.beratBadan,
    required this.panjangBadan,
  });

  Map<String, dynamic> toJson() => {
        'tanggal': tanggal.toString(),
        'berat_badan': beratBadan,
        'panjang_badan': panjangBadan,
      };
}
