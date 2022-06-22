import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/datamodel/dataview.dart';
import 'package:video_player/video_player.dart';

class QuizSummary extends StatefulWidget {
  QuizSummary({
    Key? key,
  }) : super(key: key);

  @override
  _QuizSummaryState createState() => _QuizSummaryState();
}

class _QuizSummaryState extends State<QuizSummary> {
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
              SummaryPage()
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SummaryPage extends StatefulWidget {
  SummaryPage({
    Key? key,
  }) : super(key: key);

  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  var totalscore = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Consumer<ProductsVM>(
        builder: (context, value, child) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: screenHeight * 0.1,
                  child: const Center(
                    child: Text("Quiz Summary",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.white)),
                  ),
                ),
                Expanded(
                    child: AnimationLimiter(
                  child: ListView.builder(
                    itemCount: value.lst.length,
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(seconds: 1),
                          child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                  child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Container(
                                          height: screenHeight * 0.15,
                                          width: screenWidth * 0.85,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Padding(
                                              padding: EdgeInsets.all(20),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Text("Q. ${index + 1}",
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18,
                                                        )),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        const Text("Score",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 18,
                                                            )),
                                                        Text(
                                                            "${value.lst[index].score.toString()}",
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                            )),
                                                      ],
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        const Text(
                                                            "Elapsed time",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 18,
                                                            )),
                                                        Text(
                                                            "${value.lst[index].elapsedtime} Seconds",
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                            ))
                                                      ],
                                                    ),
                                                  ])))))));
                    },
                  ),
                )),
                SizedBox(
                    height: screenHeight * 0.1,
                    width: screenWidth * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Total Score:   ${value.getCounter()}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.white)),
                      ],
                    )),
              ],
            ));
  }
}
