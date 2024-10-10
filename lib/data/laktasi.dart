class DataLaktasi {
  final int babyId;
  final DateTime mulai;
  final int durasi;
  final String posisi;

  DataLaktasi({
    required this.babyId,
    required this.mulai,
    required this.durasi,
    required this.posisi,
  });

  Map<String, dynamic> toJson() => {
        'baby_id': babyId,
        'mulai': mulai.toString(),
        'durasi': durasi,
        'posisi': posisi,
      };
}
