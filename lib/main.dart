import 'dart:ui';
import 'package:test_mood_diary/pages/StatisticPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home:  MoodDiary(),
      title: 'MoodDiary',
      initialRoute: '/MoodDiary', ///заменить навигацию в приложении
      routes: {
        '/MoodDiary': (context) =>MoodDiary(),
        '/Statistic': (context) =>StatisticPage(),
      }

    );
  }
}

class MoodDiary extends StatefulWidget {
  const MoodDiary({super.key});


  @override
  State<MoodDiary> createState() => _MoodDiaryState();
}

class _MoodDiaryState extends State<MoodDiary> {
  ///переместить в отдельные файлы
  void _emotionsPressed(int index) {
    setState(() {
      for (int i = 0; i < selectedEmotion.length; i++) {
        selectedEmotion[i] = false;
      }
      selectedEmotion[index] = !selectedEmotion[index];
    });
    }///переместить в отдельные файлы
  void _calendarPressed()async{
    final dateTime = await showDatePicker(context: context, firstDate: DateTime(2000), lastDate: DateTime(_selectedDate.year+1),);
    if ( dateTime!= null){
      setState(() {
        _selectedDate = dateTime;
      });
    }
  }///переместить в отдельные файлы
  void _saveDay(){}
  _concretlyEmotionPressed(index){
    setState(() {
    });
  }
  final GlobalKey tooltipKey = GlobalKey();

  void toggleTooltip() {
    final dynamic tooltip = tooltipKey.currentState;
    tooltip.ensureTooltipVisible();
  }

  void _savePressed(){ ///переместить в отдельные файлы
    if(selectedEmotion.contains(true)){
      _saveDay();
    }
    else{
      toggleTooltip();
    }
  }


  TextStyle LabelTextStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Color.fromRGBO( 76, 76, 105, 1) );
  TextStyle notLabelTextStyle = const TextStyle(fontSize: 11,color: Color.fromRGBO( 188,188,191, 1) );///переместить в отдельные файлы
  BoxDecoration BackgroundContainerStyle =  const BoxDecoration(///переместить в отдельные файлы
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

  final List<String> emotions = [
    'Радость', 'Страх', 'Бешенство', 'Грусть', 'Спокойствие', 'Сила'
  ];///переместить в отдельные файлы

  final List concretlyEmotion =
    ['Возбуждение', 'Восторг', 'Игривость', 'Наслаждение', 'Очарование', 'Осознанность', 'Смелость', 'Удовольствие', 'Чувственность', 'Энергичность', 'Экстравагантность'];

  final List<String> emotionsImages =[
    'lib/assets/emotion-happy.png',
    'lib/assets/emotion-fear.png',
    'lib/assets/emotion-angry.png',
    'lib/assets/emotion-sad.png',
    'lib/assets/emotion-chill.png',
    'lib/assets/emotion-power.png'];///переместить в отдельные файлы
  final List<bool> selectedEmotion = [false,false,false,false,false,false];
  final List<bool> concretlySelectedEmotion = [false,false,false,false,false,false,false,false,false,false,false];
  final List<bool> _selectedButton = [true, false];
  List<Widget> buttons = [
    const Row(children:[Icon(Icons.book, size: 20,),Text('Дневник настроения')]),
    const Row(children:[Icon(Icons.auto_graph, size: 20,),Text('Статистика')])];///переместить в отдельные файлы



  double _firstSliderValue = 0;
  double _secondSliderValue = 0;

  DateTime _selectedDate = DateTime.now();
  String _dateTimeString='';
  @override
  void initState() {
    super.initState();
    _dateTimeString = _getDateTimeString();
    Timer.periodic(Duration(seconds: 1), (Timer t) => _updateDateTime());
  }

  String _getDateTimeString() {
    final now = DateTime.now();
    final day = now.day.toString().padLeft(2, '0');
    final month = _getMonthName(now.month);
    final hour = now.hour.toString().padLeft(2, '0');
    final minute = now.minute.toString().padLeft(2, '0');

    return "$day $month $hour:$minute";
  }

  String _getMonthName(int month) {
    const monthNames = [
      "Января", "Февраля", "Марта", "Апреля", "Мая", "Июня",
      "Июля", "Августа", "Сентября", "Октября", "Ноября", "Декабря"
    ];
    return monthNames[month - 1];
  }

  void _updateDateTime() {
    setState(() {
      _dateTimeString = _getDateTimeString();
    });
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("$_dateTimeString",style: TextStyle(fontSize: 18,color:Color.fromRGBO(188, 188, 191, 1) )),
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
                      switch(index){
                        case 0:
                          Navigator.pushNamed(context, '/MoodDiary');

                        case 1:
                          Navigator.pushNamed(context, '/Statistic'); ///Изменить способ навигации
                      }
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
                           SizedBox(
                             height: 100,
                             child: ListView.builder(
                               scrollDirection: Axis.horizontal,
                               itemCount: emotions.length,

                               itemBuilder: (context, index){
                                 return ElevatedButton(

                                   style: ButtonStyle(
                                     side: MaterialStateProperty.all(BorderSide(color: selectedEmotion[index] ? Colors.orange : Colors.transparent)),
                                     elevation: MaterialStateProperty.all(0.3),
                                     fixedSize: MaterialStateProperty.all(Size(83, 118))

                                   ),
                                     onPressed:(){
                                     _emotionsPressed(index);
                                     },

                                      child: Flex(
                                        direction: Axis.vertical,
                                        mainAxisAlignment: MainAxisAlignment.start,

                                        children: [
                                        const SizedBox(height :12),
                                          Container(
                                            width: 83,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.contain,
                                                  image: AssetImage(emotionsImages[index])),),),
                                         SizedBox(width: 83,
                                          child :Text(emotions[index], ///поправить текст
                                            maxLines: 1,
                                            softWrap: false,
                                            overflow: TextOverflow.fade,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 11,
                                              color: Color.fromRGBO(76, 76, 105, 1)

                                          ),))
                                        ],
                                      )





                                 );
                               }

                             ),
                           ),
                          const SizedBox(height: 30),
                          Wrap(
                            children: List.generate(concretlyEmotion.length, (index){
                              return TextButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all( concretlySelectedEmotion[index] ? Colors.orange : Colors.transparent),

                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
                                  fixedSize: MaterialStateProperty.all(const Size(89,21)),
                                ),

                                onPressed: _concretlyEmotionPressed(index),
                                child: Text(concretlyEmotion[index],style: const TextStyle(fontSize: 11,color: Color.fromRGBO(76, 76, 105, 1)),));
                            }

                            ),
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
                                 Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Низкий',style: notLabelTextStyle),
                                    Text('Высокий',style: notLabelTextStyle),
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Неуверенность',style: notLabelTextStyle),
                                    Text('Уверенность',style: notLabelTextStyle),
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
                Tooltip(
                  key: tooltipKey,
                  message: 'Вы должны заполнить все, прежде чем сохранить',
                  preferBelow: true,
                  child: ElevatedButton(
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
                ),
                const SizedBox(height: 20),
              ]
          ),
        )
    );
  }
}
