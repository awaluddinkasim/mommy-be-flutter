class Obstetri {
  final int kehamilan;
  final int persalinan;
  final int riwayatAbortus;
  final String metodePersalinan;
  final int jarakKelahiran;
  final String resiko;

  Obstetri({
    required this.kehamilan,
    required this.persalinan,
    required this.riwayatAbortus,
    required this.metodePersalinan,
    required this.jarakKelahiran,
    required this.resiko,
  });

  factory Obstetri.fromJson(Map<String, dynamic> json) {
    return Obstetri(
      kehamilan: json['kehamilan'],
      persalinan: json['persalinan'],
      riwayatAbortus: json['riwayat_abortus'],
      metodePersalinan: json['metode_persalinan'],
      jarakKelahiran: json['jarak_kelahiran'],
      resiko: json['resiko'],
    );
  }
}
