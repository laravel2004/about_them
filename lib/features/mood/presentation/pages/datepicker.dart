// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:them/config/themes/theme.dart';
import 'package:them/core/resource/data_state.dart';
import 'package:them/features/mood/domain/entities/mood.dart';
import 'package:them/features/mood/domain/repositories/mood_repository.dart';
import 'package:them/features/mood/domain/usecases/get_all_mood.dart';
import 'package:them/features/mood/domain/usecases/get_detail_mood.dart';
import 'package:them/features/mood/domain/usecases/update_mood.dart';
import 'package:them/injection.container.dart';
import 'package:them/main.dart';

class DatepickerPage extends StatefulWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const DatepickerPage({
    super.key,
    this.animationController,
    this.animation,
  });

  @override
  State<DatepickerPage> createState() => _DatepickerPageState();
}

class _DatepickerPageState extends State<DatepickerPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<MoodlGet> _moodData = [];

  final List<Map<String, dynamic>> moods = [
    {'icon': FontAwesomeIcons.faceSmileBeam, 'label': 'Sangat Senang', 'value': 1},
    {'icon': FontAwesomeIcons.faceGrinWide, 'label': 'Senang', 'value': 2},
    {'icon': FontAwesomeIcons.faceMehBlank, 'label': 'Biasa', 'value': 3},
    {'icon': FontAwesomeIcons.faceFrownOpen, 'label': 'Sedih', 'value': 4},
    {'icon': FontAwesomeIcons.faceSadTear, 'label': 'Sangat Sedih', 'value': 5},
  ];

  @override
  void initState() {
    _fetchMoodData();
    super.initState();
  }

  Future<void> _fetchMoodData() async {
    final startDate = DateTime(_focusedDay.year, _focusedDay.month, 1);
    final endDate = DateTime(_focusedDay.year, _focusedDay.month + 1, 0);

    final formatter = DateFormat('yyyy-MM-dd');

    final query = DateMoodQuery(
      dateStart: formatter.format(startDate),
      dateEnd: formatter.format(endDate),
    );

    final result = await GetAllMood(sl.get<MoodRepository>()).call(params: query);
    if (result is DataSuccess<List<MoodlGet>>) {
    print("Data fetched successfully: ${result.data}");
    setState(() {
      _moodData = result.data!;
    });
  } else {
    print("Data fetch failed: ${result.error}");
  }
  }

  MoodlGet? _getMoodForDay(DateTime day) {
    for (var mood in _moodData) {
      if (DateTime.parse(mood.date!).isAtSameMomentAs(day)) {
        return mood;
      }
    }
    return null;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    });
    _showMoodDialog(selectedDay);
  }

  void _onMonthChanged(DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
    });
    _fetchMoodData();
  }

  void _selectMood(int mood, String note) async {
    if (_selectedDay != null) {
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final formattedDate = formatter.format(_selectedDay!);

      final moodParams = Mood(
        date: formattedDate,
        mood: mood.toString(),
        note: note,
      );

      final result = await UpdateMood(sl.get<MoodRepository>()).call(params: moodParams);
      if (result is DataSuccess) {
        await _fetchMoodData();
        Navigator.of(context).pop();
      } else {
        _showErrorDialog(result.error!);
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap a button
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showMoodDialog(DateTime selectedDay) async {
    final existingMood = _getMoodForDay(selectedDay);
    if (existingMood != null) {
      final result = await GetDetailMood(sl.get<MoodRepository>()).call(params: selectedDay.toIso8601String());
      if (result is DataSuccess<Mood>) {
        final mood = result.data!;
        final TextEditingController noteController = TextEditingController(text: mood.note);
        int? selectedMoodValue = int.parse(mood.mood!);
        showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: const Text('Mood Detail'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: moods.map((mood) {
                          return IconButton(
                            icon: FaIcon(
                              mood['icon'],
                              color: selectedMoodValue == mood['value'] ? Colors.blue : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                selectedMoodValue = mood['value'];
                              });
                            },
                          );
                        }).toList(),
                      ),
                      TextField(
                        controller: noteController,
                        decoration: const InputDecoration(labelText: 'Add a note'),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        if (selectedMoodValue != null) {
                          _selectMood(selectedMoodValue!, noteController.text);
                        }
                      },
                      child: const Text('Save'),
                    ),
                  ],
                );
              },
            );
          },
        );
      } else {
        _showErrorDialog(result.error!);
      }
    } else {
      final TextEditingController noteController = TextEditingController();
      int? selectedMoodValue;
      showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: const Text('Select your mood'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: moods.map((mood) {
                        return IconButton(
                          icon: FaIcon(
                            mood['icon'],
                            color: selectedMoodValue == mood['value'] ? Colors.blue : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              selectedMoodValue = mood['value'];
                            });
                          },
                        );
                      }).toList(),
                    ),
                    TextField(
                      controller: noteController,
                      decoration: const InputDecoration(labelText: 'Add a note'),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () async {
                      if (selectedMoodValue != null) {
                        _selectMood(selectedMoodValue!, noteController.text);
                      }
                    },
                    child: const Text('Save'),
                  ),
                ],
              );
            },
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 16, bottom: 18),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.nearlyDarkBlue,
                      HexColor("#CCA01D")
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                    topRight: Radius.circular(68.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: AppTheme.grey.withOpacity(0.6),
                      offset: const Offset(1.1, 1.1),
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 20),
                    const Text(
                      'Select Date and Mood',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    TableCalendar(
                      firstDay: DateTime(2000),
                      lastDay: DateTime(2101),
                      focusedDay: _focusedDay,
                      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                      onDaySelected: _onDaySelected,
                      onPageChanged: _onMonthChanged,
                      calendarBuilders: CalendarBuilders(
                        defaultBuilder: (context, day, focusedDay) {
                          final mood = _getMoodForDay(day);
                          if (mood != null) {
                            final moodValue = int.parse(mood.mood!);
                            IconData iconData;
                            switch (moodValue) {
                              case 1:
                                iconData = FontAwesomeIcons.faceSmileBeam;
                                break;
                              case 2:
                                iconData = FontAwesomeIcons.faceGrinWide;
                                break;
                              case 3:
                                iconData = FontAwesomeIcons.faceMehBlank;
                                break;
                              case 4:
                                iconData = FontAwesomeIcons.faceFrownOpen;
                                break;
                              case 5:
                                iconData = FontAwesomeIcons.faceSadTear;
                                break;
                              default:
                                iconData = FontAwesomeIcons.questionCircle;
                                break;
                            }
                            return Center(
                              child: FaIcon(iconData, color: Colors.blue),
                            );
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
