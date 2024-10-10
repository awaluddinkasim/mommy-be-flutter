class StatusGizi {
  final double tinggiBadan;
  final double bbSebelumHamil;
  final double bbSaatHamil;
  final double bbSetelahMelahirkan;
  final String aktifitasHarian;
  final double imtPraHamil;
  final double imtPostHamil;
  final double resistensiBB;
  final double kebutuhanKalori;

  StatusGizi({
    required this.tinggiBadan,
    required this.bbSebelumHamil,
    required this.bbSaatHamil,
    required this.bbSetelahMelahirkan,
    required this.aktifitasHarian,
    required this.imtPraHamil,
    required this.imtPostHamil,
    required this.resistensiBB,
    required this.kebutuhanKalori,
  });

  factory StatusGizi.fromJson(Map<String, dynamic> json) {
    return StatusGizi(
      tinggiBadan: json['tinggi_badan'],
      bbSebelumHamil: json['bb_sebelum_hamil'],
      bbSaatHamil: json['bb_saat_hamil'],
      bbSetelahMelahirkan: json['bb_setelah_melahirkan'],
      aktifitasHarian: json['aktifitas_harian'],
      imtPraHamil: json['imt_pra_hamil'],
      imtPostHamil: json['imt_post_hamil'],
      resistensiBB: json['resistensi_bb'],
      kebutuhanKalori: json['kebutuhan_kalori'],
    );
  }
}
