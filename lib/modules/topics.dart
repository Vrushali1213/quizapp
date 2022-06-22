import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quizapp/modules/quizpage.dart';

class TopicList extends StatefulWidget {
  TopicList({
    Key? key,
  }) : super(key: key);

  @override
  _TopicListState createState() => _TopicListState();
}

class _TopicListState extends State<TopicList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // ReadJsonData();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const SizedBox(
          height: 50.0,
        ),
        const Center(child:
         Text('List of Topics',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 30,color: Colors.white
            )),),
        Expanded(
            child: Center(
                child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QuizPage()),
            );
          },
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: screenWidth * 0.3, bottom: 10.0),
            children: const <Widget>[
              Text('Maths',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                  )),
              SizedBox(
                height: 15,
              ),
              Text('Science',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                  )),
              SizedBox(
                height: 15,
              ),
              Text('History',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                  )),
              SizedBox(
                height: 15,
              ),
              Text('English',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                  )),
            ],
          ),
        )))
      ],
    );
  }
}
