import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const MoodDiary(title: 'Flutter Demo Home Page'),
    );
  }
}

class MoodDiary extends StatefulWidget {
  const MoodDiary({super.key, required this.title});
  final String title;

  @override
  State<MoodDiary> createState() => _MoodDiaryState();
}

class _MoodDiaryState extends State<MoodDiary> {
  TextStyle LabelTextStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Color.fromARGB(256, 76, 76, 105));

  BoxDecoration BackgroundContainerStyle =  const BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(13)),
    boxShadow: [
      BoxShadow(
        color: Color.fromARGB(30, 182, 161, 192),
        blurRadius: 10,
        spreadRadius: 0,
        offset: Offset(2, 4),
      )
    ],
  );

  void calendarPressed(){}

  final List<bool> _selectedButton = <bool>[true, false];

  List<Widget> buttons = [
    const Row(children:[Icon(Icons.book, size: 20,),Text('Дневник настроения')]),
    const Row(children:[Icon(Icons.auto_graph, size: 20,),Text('Статистика')])];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text("время"),
          elevation: 2,
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                iconSize: 35,
                onPressed: calendarPressed,
                icon: const Icon(Icons.calendar_month))
          ],
        ),


        body: Center(
          child:Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children:<Widget>[
                ToggleButtons(
                  onPressed: (int index){
                    setState(() {
                      for (int i=0; i<_selectedButton.length;i++){
                        _selectedButton[i] = i == index;
                      }
                    });
                  },
                  fillColor: Colors.orange.withOpacity(1),
                  borderColor: Colors.orange.withOpacity(1),
                  selectedBorderColor: Colors.orange.withOpacity(1),
                  selectedColor: Colors.white,
                  color: Colors.grey,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height*0.04,
                    minWidth: MediaQuery.of(context).size.width*0.4,
                  ),
                  isSelected: _selectedButton,
                  children: buttons,
                ),
                Expanded(
                    child:
                    Padding(padding:const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child :ListView(
                        children: <Widget>[
                          Text("Что чувствуешь?",
                            style: LabelTextStyle,
                          ),

                          const SizedBox(height: 30),
                          const Text("Уровень стресса",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            height: 118,
                            width: MediaQuery.of(context).size.width,
                            decoration:BackgroundContainerStyle,
                            child:const  Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Низкий'),
                                    Text('Высокий'),
                                  ],
                                ),

                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          Text("Самооценка",
                            style: LabelTextStyle,
                          ),
                          const SizedBox(height: 30),
                          Text("Заметки",
                              style: LabelTextStyle
                          ),
                        ],
                      ),
                    )
                )
              ]
          ),
        )
    );
  }
}
