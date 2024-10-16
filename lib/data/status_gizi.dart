class DataStatusGizi {
  final double tinggiBadan;
  final double bbSebelumHamil;
  final double bbSaatHamil;
  final double bbSetelahMelahirkan;
  final String aktifitasHarian;

  DataStatusGizi({
    required this.tinggiBadan,
    required this.bbSebelumHamil,
    required this.bbSaatHamil,
    required this.bbSetelahMelahirkan,
    required this.aktifitasHarian,
  });

  Map<String, dynamic> toJson() => {
        'tinggi_badan': tinggiBadan,
        'bb_sebelum_hamil': bbSebelumHamil,
        'bb_saat_hamil': bbSaatHamil,
        'bb_setelah_hamil': bbSetelahMelahirkan,
        'aktifitas_harian': aktifitasHarian,
      };
}
