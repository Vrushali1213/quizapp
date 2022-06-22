import 'dart:async';
import 'dart:convert';

import 'package:animated_widgets/widgets/opacity_animated.dart';
import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/translation_animated.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/datamodel/dataview.dart';
import 'package:quizapp/modules/selectedans.dart';
import 'package:quizapp/modules/summary.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class SecondQuizPage extends StatefulWidget {
  SecondQuizPage({
    Key? key,
  }) : super(key: key);

  @override
  _SecondQuizPageState createState() => _SecondQuizPageState();
}

class _SecondQuizPageState extends State<SecondQuizPage> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.asset("assets/background.mp4")
      ..initialize().then((_) {
        _controller?.play();
        _controller?.setLooping(true);
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xffb55e28),
        accentColor: Color(0xffffd544),
      ),
      home: SafeArea(
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _controller?.value.size.width ?? 0,
                    height: _controller?.value.size.height ?? 0,
                    child: VideoPlayer(_controller!),
                  ),
                ),
              ),
              QuestionPageSecond()
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class QuestionPageSecond extends StatefulWidget {
  QuestionPageSecond({
    Key? key,
  }) : super(key: key);

  @override
  _TopicListState createState() => _TopicListState();
}

class _TopicListState extends State<QuestionPageSecond>
    with TickerProviderStateMixin {
  bool expanded = false;
  String? _question;
  String? _question1;
  int _duration = 10;
  List AnswerList = [];
  final CountDownController _countdowncontroller = CountDownController();
  final scrollController = ScrollController();
  bool isbackground = false;
  var count;

  Future<void> ReadJsonData() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('jsonfile/question2.json');
    List<dynamic> list = json.decode(jsondata);
    List list1 = list[0]["data"]["options"];
    _question1 = list[0]["data"]["stimulus"];
    setState(() {
      AnswerList = list1;
    });
    print("list....${list[0]["data"]}");
  }

  Timer? _timer;
  int _start = 3;

  int _startanimation = 0;
  bool selected = false;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;

            _startanimation++;
          });
        }
        if (_startanimation <= 10) {
          setState(() {
            selected = false;
          });
        } else {
          setState(() {
            selected == true;
            print("selected..$selected");
          });
        }
      },
    );
  }

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 700),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );
  Stopwatch stopwatch = new Stopwatch();

  late AnimationController controller;
  Animation? sizeAnimation;
  Animation? colorAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ReadJsonData();
    startTimer();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 6));
    sizeAnimation = Tween(begin: 100.0, end: 900.0).animate(
        CurvedAnimation(parent: controller, curve: Interval(0.0, 0.15)));
    colorAnimation = ColorTween(begin: Colors.red, end: Colors.blue).animate(
        CurvedAnimation(parent: controller, curve: Interval(0.5, 1.0)));
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    if (_question1 != null) {
      var pos = _question1?.lastIndexOf('&');
      _question = (pos != -1) ? _question1?.substring(3, pos) : _question1;
    }
    return Column(
      children: <Widget>[
        _start != 0
            ? Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.2,
                  ),
                  const Center(
                    child: Text("Get Ready!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                            color: Colors.white)),
                  ),
                  SizedBox(
                    height: screenHeight * 0.1,
                  ),
                  Center(
                    child: FadeTransition(
                      opacity: _animation,
                      child: Text("$_start",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 170,
                              color: Colors.white)),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              )
            : Expanded(
                flex: 1,
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                    const Center(
                      child: Text("Oh My Quiz!",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.white)),
                    ),
                    TranslationAnimatedWidget.tween(
                      translationDisabled: Offset(0, 200),
                      translationEnabled: Offset(0, 0),
                      child: OpacityAnimatedWidget.tween(
                          opacityDisabled: 0,
                          opacityEnabled: 1,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    25.0, 20.0, 20.0, 20.0),
                                child: Center(
                                  child: _question == null
                                      ? Container()
                                      : Text(_question!,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25,
                                              color: Colors.white)),
                                ),
                              ),
                              Center(
                                  child: CircularCountDownTimer(
                                duration: _duration,
                                initialDuration: 0,
                                controller: _countdowncontroller,
                                width: screenWidth * 0.7,
                                height: screenHeight * 0.17,
                                ringColor: Colors.grey[200]!,
                                ringGradient: null,
                                fillColor: Colors.red[300]!,
                                fillGradient: null,
                                backgroundGradient: null,
                                strokeWidth: 11.0,
                                strokeCap: StrokeCap.round,
                                textStyle: const TextStyle(
                                    fontSize: 33.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                textFormat: CountdownTextFormat.S,
                                onStart: () {
                                  debugPrint('Countdown Started');
                                  count = _duration;
                                  print(count);
                                  stopwatch.start();
                                  print(
                                      'doSomething() executed in ${stopwatch.elapsed}');
                                },
                                onComplete: () {
                                  debugPrint('Countdown Ended');
                                  count = 0;
                                  print(count);
                                },
                              )),
                            ],
                          )),
                    ),
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                    answerSet()
                  ],
                ))
      ],
    );
  }

  Widget answerSet() {
    final width = MediaQuery.of(context).size.width;
    return Expanded(
        flex: 2,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: AnimationLimiter(
            child: GridView.count(
              controller: scrollController,
              crossAxisCount: 2,
              childAspectRatio: 1.6 / 1.4,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              padding: const EdgeInsets.all(5.0),
              children: List.generate(
                AnswerList.length,
                (int index) {
                  var iscorrect;
                  if (AnswerList[index]["isCorrect"] != null) {
                    iscorrect = AnswerList[index]["isCorrect"];
                  }
                  var item1;
                  var item;
                  if (AnswerList[index] != null) {
                    item1 = AnswerList[index]["label"];
                    if (item1 != null) {
                      var pos = item1?.lastIndexOf('<');
                      item = (pos != -1) ? item1?.substring(3, pos) : item1;
                    }
                  }
                  return RotationAnimatedWidget.tween(
                      rotationDisabled: Rotation.deg(z: 90),
                      rotationEnabled: Rotation.deg(z: 360),
                      child: AnimationConfiguration.staggeredGrid(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        columnCount: 2,
                        child: ScaleAnimation(
                          child: FadeInAnimation(
                              child: Consumer<ProductsVM>(
                                  builder: (context, value, child) => InkWell(
                                        onTap: () async {
                                          if (count != 0) {
                                            print(index);
                                            var timeee =
                                                stopwatch.elapsed.toString();
                                            var newtime =
                                                timeee.substring(5, 7);
                                            print(
                                                'doSomething() executed in $newtime');
                                            setState(() {
                                              value.add(
                                                item!,
                                                AnswerList[index]["isCorrect"]!,
                                                AnswerList[index]["score"]!,
                                                newtime,
                                              );
                                              value.totalscore(
                                                  AnswerList[index]["score"]!,
                                                  newtime);
                                              isbackground = true;
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SelectedAnswer(
                                                          selectedindex: index,
                                                          selectedanswer: item,
                                                          selectedansIsCorrect:
                                                              iscorrect,
                                                          questionid: 2,
                                                        )),
                                              );
                                            });
                                          } else {
                                            var timeee =
                                                stopwatch.elapsed.toString();
                                            var newtime =
                                                timeee.substring(5, 7);
                                            print(
                                                'doSomething() executed in $newtime');

                                            Fluttertoast.showToast(
                                                msg: "Time is Out",
                                                backgroundColor: Colors.grey,
                                                textColor: Colors.white,
                                                fontSize: 16.0);

                                            value.add(item!, 0, 0, newtime);
                                            value.totalscore(0, newtime);
                                            isbackground = true;
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      QuizSummary()),
                                            );
                                          }
                                        },
                                        child: AnswerList[index] == null
                                            ? Container()
                                            : Container(
                                                height: 60,
                                                width: 70,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Center(
                                                    child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    index == 0
                                                        ? const CircleAvatar(
                                                            backgroundColor:
                                                                Colors.amber,
                                                            radius: 20,
                                                            child: Text(
                                                              'A',
                                                              style: TextStyle(
                                                                fontSize: 25,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ), //Text
                                                          )
                                                        : index == 1
                                                            ? CircleAvatar(
                                                                backgroundColor:
                                                                    Colors.blue[
                                                                        300],
                                                                radius: 20,
                                                                child:
                                                                    const Text(
                                                                  'B',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        25,
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ), //Text
                                                              )
                                                            : index == 2
                                                                ? CircleAvatar(
                                                                    backgroundColor:
                                                                        Colors.lightGreenAccent[
                                                                            400],
                                                                    radius: 20,
                                                                    child:
                                                                        const Text(
                                                                      'C',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            25,
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ), //Text
                                                                  )
                                                                : CircleAvatar(
                                                                    backgroundColor:
                                                                        Colors.red[
                                                                            300],
                                                                    radius: 20,
                                                                    child:
                                                                        const Text(
                                                                      'D',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            25,
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ), //Text
                                                                  ),
                                                    //CircleAvatar, //CircleAvatar, //CircleAvatar//CircleAvatar

                                                    Padding(
                                                        padding:
                                                            EdgeInsets.all(15),
                                                        child: Text('${item}',
                                                            style:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15,
                                                            )))
                                                  ],
                                                )),
                                              ),
                                      ))),
                        ),
                      ));
                },
              ),
            ),
          ),
        ));
  }
}
