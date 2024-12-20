class Obstetri {
  final int id;
  final int kehamilan;
  final int persalinan;
  final int riwayatAbortus;
  final String metodePersalinan;
  final int jarakKelahiran;
  final String resiko;
  final String pesan;
  final bool expanded;

  Obstetri({
    required this.id,
    required this.kehamilan,
    required this.persalinan,
    required this.riwayatAbortus,
    required this.metodePersalinan,
    required this.jarakKelahiran,
    required this.resiko,
    required this.pesan,
    this.expanded = false,
  });

  factory Obstetri.fromJson(Map<String, dynamic> json) {
    return Obstetri(
      id: json['id'],
      kehamilan: json['kehamilan'],
      persalinan: json['persalinan'],
      riwayatAbortus: json['riwayat_abortus'],
      metodePersalinan: json['metode_persalinan'],
      jarakKelahiran: json['jarak_kelahiran'],
      pesan: json['pesan'],
      resiko: json['resiko'],
    );
  }

  Obstetri copyWith({
    int? id,
    int? kehamilan,
    int? persalinan,
    int? riwayatAbortus,
    String? metodePersalinan,
    int? jarakKelahiran,
    String? resiko,
    String? pesan,
    bool? expanded,
  }) {
    return Obstetri(
      id: id ?? this.id,
      kehamilan: kehamilan ?? this.kehamilan,
      persalinan: persalinan ?? this.persalinan,
      riwayatAbortus: riwayatAbortus ?? this.riwayatAbortus,
      metodePersalinan: metodePersalinan ?? this.metodePersalinan,
      jarakKelahiran: jarakKelahiran ?? this.jarakKelahiran,
      resiko: resiko ?? this.resiko,
      pesan: pesan ?? this.pesan,
      expanded: expanded ?? this.expanded,
    );
  }
}
