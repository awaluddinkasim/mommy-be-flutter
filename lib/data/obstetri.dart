class DataObstetri {
  final int kehamilan;
  final int persalinan;
  final int riwayatAbortus;
  final String metodePersalinan;
  final int jarakKelahiran;

  DataObstetri({
    required this.kehamilan,
    required this.persalinan,
    required this.riwayatAbortus,
    required this.metodePersalinan,
    required this.jarakKelahiran,
  });

  Map<String, dynamic> toJson() => {
        'kehamilan': kehamilan,
        'persalinan': persalinan,
        'riwayat_abortus': riwayatAbortus,
        'metode_persalinan': metodePersalinan,
        'jarak_kelahiran': jarakKelahiran,
      };
}
