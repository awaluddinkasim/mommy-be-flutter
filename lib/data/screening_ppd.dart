class DataScreeningPPD {
  final int q1;
  final int q2;
  final int q3;
  final int q4;
  final int q5;
  final int q6;
  final int q7;
  final int q8;
  final int q9;
  final int q10;

  DataScreeningPPD({
    required this.q1,
    required this.q2,
    required this.q3,
    required this.q4,
    required this.q5,
    required this.q6,
    required this.q7,
    required this.q8,
    required this.q9,
    required this.q10,
  });

  Map<String, dynamic> toJson() => {
        'q1': q1,
        'q2': q2,
        'q3': q3,
        'q4': q4,
        'q5': q5,
        'q6': q6,
        'q7': q7,
        'q8': q8,
        'q9': q9,
        'q10': q10,
      };
}
