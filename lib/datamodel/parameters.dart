class Questionjson {
  String? label;
  int? isCorrect;
  int? score;
  String? elapsedtime;

  Questionjson({this.label, this.isCorrect, this.score, this.elapsedtime});

  Map<String, dynamic> toJson() => {
        "label": label,
        "isCorrect": isCorrect,
        "score": score,
      };
}
