import 'package:flutter/material.dart';
class StatisticPage extends StatefulWidget {
  const StatisticPage({super.key});


  @override
  State<StatisticPage> createState() => _StatisticPage();
}

class _StatisticPage extends State<StatisticPage> {
  DateTime _selectedDate = DateTime.now();
  final List<bool> _selectedButton = <bool>[false, true];
  List<Widget> buttons = [
    const Row(
        children: [Icon(Icons.book, size: 20,), Text('Дневник настроения')]),
    const Row(children: [Icon(Icons.auto_graph, size: 20,), Text('Статистика')])
  ];

  void _calendarPressed() async {
    final dateTime = await showDatePicker(context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(_selectedDate.year + 1),);
    if (dateTime != null) {
      setState(() {
        _selectedDate = dateTime;
      });
    }
  }


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
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ToggleButtons(
                    onPressed: (int index) {
                      setState(() {
                        switch (index) {
                          case 0:
                        Navigator.pushNamed(context, '/MoodDiary');
                          case 1:
                            Navigator.pushNamed(context, '/Statistic');
                        }
                        for (int i = 0; i < _selectedButton.length; i++) {
                          _selectedButton[i] = i == index;
                        }
                      }
                      );
                    },
                    fillColor: Colors.orange.withOpacity(1),
                    borderColor: Colors.orange.withOpacity(1),
                    selectedBorderColor: Colors.orange.withOpacity(1),
                    selectedColor: Colors.white,
                    color: Colors.grey,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    constraints: BoxConstraints(
                      minHeight: MediaQuery
                          .of(context)
                          .size
                          .height * 0.04,
                      minWidth: MediaQuery
                          .of(context)
                          .size
                          .width * 0.4,
                    ),
                    isSelected: _selectedButton,
                    children: buttons,
                  ),
                  Text('Здесь будет график статистики '),
                ]

            )

        )
    );
  }
}
