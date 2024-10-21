class LaktasiGrafik {
  final int index;
  final double durasi;

  LaktasiGrafik(this.index, this.durasi);

  factory LaktasiGrafik.fromJson(Map<String, dynamic> json, index) {
    return LaktasiGrafik(index, json['durasi']);
  }
}
