class StatusGizi {
  final int id;
  final double tinggiBadan;
  final double bbSebelumHamil;
  final double bbSaatHamil;
  final double bbSetelahMelahirkan;
  final String aktifitasHarian;
  final double imtPraHamil;
  final double imtPostHamil;
  final double resistensiBB;
  final double kebutuhanKalori;
  final String pesan;

  StatusGizi({
    required this.id,
    required this.tinggiBadan,
    required this.bbSebelumHamil,
    required this.bbSaatHamil,
    required this.bbSetelahMelahirkan,
    required this.aktifitasHarian,
    required this.imtPraHamil,
    required this.imtPostHamil,
    required this.resistensiBB,
    required this.kebutuhanKalori,
    required this.pesan,
  });

  factory StatusGizi.fromJson(Map<String, dynamic> json) {
    return StatusGizi(
      id: json['id'],
      tinggiBadan: double.parse(json['tinggi_badan'].toString()),
      bbSebelumHamil: double.parse(json['bb_sebelum_hamil'].toString()),
      bbSaatHamil: double.parse(json['bb_saat_hamil'].toString()),
      bbSetelahMelahirkan: double.parse(json['bb_setelah_melahirkan'].toString()),
      aktifitasHarian: json['aktifitas_harian'].toString(),
      imtPraHamil: double.parse(json['imt_pra_hamil'].toString()),
      imtPostHamil: double.parse(json['imt_post_hamil'].toString()),
      resistensiBB: double.parse(json['resistensi_bb'].toString()),
      kebutuhanKalori: double.parse(json['kebutuhan_kalori'].toString()),
      pesan: json['pesan'],
    );
  }
}
