import 'package:flutter/widgets.dart';
import 'package:quizapp/datamodel/parameters.dart';

class ProductsVM with ChangeNotifier {
  List<Questionjson> lst = [];

  add(String label, int isCorrect, int score, String elapsedtime) {
    lst.add(Questionjson(
        label: label,
        isCorrect: isCorrect,
        score: score,
        elapsedtime: elapsedtime));
    notifyListeners();
  }

  int totoalscore = 0;

  getCounter() => totoalscore;

  totalscore(int score, String elapsedtime) {
    totoalscore = totoalscore + score;
    notifyListeners();
  }
}
