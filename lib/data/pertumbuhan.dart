class DataPertumbuhan {
  final int usia;
  final double beratBadan;
  final double tinggiBadan;

  DataPertumbuhan({
    required this.usia,
    required this.beratBadan,
    required this.tinggiBadan,
  });

  Map<String, dynamic> toJson() => {
        'usia': usia.toString(),
        'berat_badan': beratBadan,
        'panjang_badan': tinggiBadan,
      };
}
