import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

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
  void _calendarPressed(){}
  void _savePressed(){}
  TextStyle LabelTextStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Color.fromRGBO( 76, 76, 105, 1) );
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
  final List<Map<String, String>> emotions = [
    {'name': 'Радость', 'image': 'assets/emotion-happy.png'}, // замените на ваши изображения
    {'name': 'Страх', 'image': 'assets/emotion-fear.png'},
    {'name': 'Бешенство', 'image': 'assets/emotion-angry.png'},
    {'name': 'Грусть', 'image': 'assets/emotion-sad.png'},
    {'name': 'Спокойствие', 'image': 'assets/emotion-chill.png'},
    {'name': 'Сила', 'image': 'assets/emotion-power.png'},
  ];

  final List<bool> _selectedButton = <bool>[true, false];
  double _firstSliderValue = 0;
  double _secondSliderValue = 0;
  List<Widget> buttons = [
    const Row(children:[Icon(Icons.book, size: 20,),Text('Дневник настроения')]),
    const Row(children:[Icon(Icons.auto_graph, size: 20,),Text('Статистика')])];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text("время"),
          elevation: 0,
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                iconSize: 35,
                onPressed: _calendarPressed,
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
                          const SizedBox(height: 30),
                          Text("Что чувствуешь?",
                            style: LabelTextStyle,
                          ),
                          const SizedBox(height: 20),
                          ListView(
                            children: [
                              Container(
                                child: Column(children: [

                                ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 30),
                          Text("Уровень стресса",
                            style: LabelTextStyle,
                          ),
                          Container(
                            height: 118,
                            width: MediaQuery.of(context).size.width,
                            decoration:BackgroundContainerStyle,
                            child: Column(
                              children: [
                                Slider(
                                    inactiveColor: const Color.fromRGBO(225, 221, 216, 1),
                                    thumbColor: Colors.orange,
                                    overlayColor: MaterialStateProperty.all(Colors.white),
                                    activeColor: Colors.orange,
                                    value: _firstSliderValue,
                                    max: 100,
                                    label: _firstSliderValue.round().toString(),
                                    onChanged: (double value) {
                                      setState(() {
                                        _firstSliderValue = value;
                                      });
                                    }
                                ),
                                const Row(
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
                          Container(
                            height: 118,
                            width: MediaQuery.of(context).size.width,
                            decoration:BackgroundContainerStyle,
                            child: Column(
                              children: [
                                Slider(
                                  inactiveColor: const Color.fromRGBO(225, 221, 216, 1),
                                  thumbColor: Colors.orange,
                                  overlayColor: MaterialStateProperty.all(Colors.white),
                                  activeColor: Colors.orange,
                                  value: _secondSliderValue,
                                  max: 100,
                                  label: _secondSliderValue.round().toString(),
                                  onChanged: (double value) {
                                    setState(() {
                                      _secondSliderValue = value;
                                    });
                                  }
                                  ),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Неуверенность'),
                                    Text('Уверенность'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          Text("Заметки",
                              style: LabelTextStyle
                          ),
                          Container(
                            height: 90,
                            width: MediaQuery.of(context).size.width,
                            decoration: BackgroundContainerStyle,
                            child: const TextField(

                              decoration: InputDecoration(
                                labelText: "Введите заметку",

                                alignLabelWithHint: false,

                                fillColor: Colors.transparent,
                                filled: true,
                                border: InputBorder.none,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                ),
                ElevatedButton(
                  
                  onPressed: _savePressed,
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width*0.8,44)),
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: MaterialStateProperty.all(Colors.orange),
                  ),
                  child: const Text("Сохранить",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ]
          ),
        )
    );
  }
}
