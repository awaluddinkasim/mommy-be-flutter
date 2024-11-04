class LaktasiGrafik {
  final int index;
  final DateTime tanggal;
  final double durasi;

  LaktasiGrafik(this.index, this.tanggal, this.durasi,);

  factory LaktasiGrafik.fromJson(Map<String, dynamic> json, index) {
    return LaktasiGrafik(index, DateTime.parse(json['tanggal']), json['durasi']);
  }
}
