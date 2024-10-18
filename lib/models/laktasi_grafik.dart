class LaktasiGrafik {
  final int index;
  final double durasi;

  LaktasiGrafik(this.index, this.durasi);

  factory LaktasiGrafik.fromJson(Map<String, dynamic> json) {
    return LaktasiGrafik(json['index'], json['durasi']);
  }
}
