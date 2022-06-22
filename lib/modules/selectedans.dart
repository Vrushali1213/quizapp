import 'dart:async';

import 'package:animated_widgets/widgets/opacity_animated.dart';
import 'package:animated_widgets/widgets/translation_animated.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/modules/secondquizpage.dart';
import 'package:quizapp/modules/summary.dart';
import 'package:video_player/video_player.dart';

class SelectedAnswer extends StatefulWidget {
  var selectedindex;
  String? selectedanswer;
  var selectedansIsCorrect;
  var questionid;

  SelectedAnswer(
      {Key? key,
      this.selectedindex,
      this.selectedanswer,
      this.selectedansIsCorrect,
      this.questionid})
      : super(key: key);

  @override
  _SelectedAnswerState createState() => _SelectedAnswerState();
}

class _SelectedAnswerState extends State<SelectedAnswer> {
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
              flipcardAnswer(
                  selectedindex: widget.selectedindex,
                  selectedanswer: widget.selectedanswer,
                  selectedansIsCorrect: widget.selectedansIsCorrect,
                  questionid: widget.questionid)
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class flipcardAnswer extends StatefulWidget {
  var selectedindex;
  String? selectedanswer;
  var selectedansIsCorrect;
  var questionid;

  flipcardAnswer(
      {Key? key,
      this.selectedindex,
      this.selectedanswer,
      this.selectedansIsCorrect,
      this.questionid})
      : super(key: key);

  @override
  _flipcardAnswerState createState() => _flipcardAnswerState();
}

class _flipcardAnswerState extends State<flipcardAnswer> {
  VideoPlayerController? _controllercheck;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllercheck = VideoPlayerController.asset("assets/sparkles.mp4")
      ..initialize().then((_) {
        _controllercheck?.play();
        _controllercheck?.setLooping(true);
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controllercheck?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: FlipCard(
              key: Key('flip'),
              direction: FlipDirection.HORIZONTAL,
              front: TranslationAnimatedWidget.tween(
                translationDisabled: Offset(0, 200),
                translationEnabled: Offset(0, 0),
                child: OpacityAnimatedWidget.tween(
                  opacityDisabled: 0,
                  opacityEnabled: 1,
                  child: Container(
                    height: screenHeight * 0.22,
                    width: screenWidth * 0.43,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        widget.selectedindex == 0
                            ? const CircleAvatar(
                                backgroundColor: Colors.amber,
                                radius: 20,
                                child: Text(
                                  'A',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ), //Text
                              )
                            : widget.selectedindex == 1
                                ? CircleAvatar(
                                    backgroundColor: Colors.blue[300],
                                    radius: 20,
                                    child: const Text(
                                      'B',
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ), //Text
                                  )
                                : widget.selectedindex == 2
                                    ? CircleAvatar(
                                        backgroundColor:
                                            Colors.lightGreenAccent[400],
                                        radius: 20,
                                        child: const Text(
                                          'C',
                                          style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ), //Text
                                      )
                                    : CircleAvatar(
                                        backgroundColor: Colors.red[300],
                                        radius: 20,
                                        child: const Text(
                                          'D',
                                          style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ), //Text
                                      ),
                        Padding(
                            padding: EdgeInsets.all(20),
                            child: Text("${widget.selectedanswer}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                )))
                      ],
                    )),
                  ),
                ),
              ),
              back: Column(
                children: [
                  InkWell(
                    onTap: () async {
                      if (widget.questionid != 2 &&
                          widget.selectedansIsCorrect == 1) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => SecondQuizPage()));
                      } else {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => QuizSummary()));
                      }
                      ;
                    },
                    child: Container(
                      height: screenHeight * 0.22,
                      width: screenWidth * 0.43,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          (widget.selectedansIsCorrect != null) &&
                                  (widget.selectedansIsCorrect == 1)
                              ? RadiantGradientMask(
                                  child: const Icon(
                                  Icons.check,
                                  size: 150,
                                  color: Colors.white,
                                ))
                              : const Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Text("Wrong Answer !",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          color: Colors.purple)))
                        ],
                      )),
                    ),
                  )
                ],
              )),
        ),
      ],
    );
  }
}

class RadiantGradientMask extends StatelessWidget {
  RadiantGradientMask({this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const RadialGradient(
        center: Alignment.center,
        radius: 1.0,
        colors: [Colors.purpleAccent, Colors.red],
        tileMode: TileMode.decal,
      ).createShader(bounds),
      child: child,
    );
  }
}
