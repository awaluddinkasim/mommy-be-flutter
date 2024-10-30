class ScreeningPPD {
  final int totalScore;
  final String tingkatRisiko;
  final String pesan;

  ScreeningPPD({
    required this.totalScore,
    required this.tingkatRisiko,
    required this.pesan,
  });

  factory ScreeningPPD.fromJson(Map<String, dynamic> json) {
    return ScreeningPPD(
      totalScore: json['total_score'],
      tingkatRisiko: json['tingkat_risiko'],
      pesan: json['pesan'],
    );
  }
}
