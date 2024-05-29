import 'package:equatable/equatable.dart';

class Mood extends Equatable{
  final String? mood;
  final String? note;
  final String? date;

  const Mood({
    this.mood,
    this.note,
    this.date
  });

  @override
  List<Object?> get props => [mood!, note!, date!];
}

class MoodlGet extends Equatable {
  final String? date;
  final String? mood;

  const MoodlGet({
    this.date,
    this.mood
  });
  
  @override
  List<Object?> get props => [date!, mood!];
}

class DateMoodQuery {
  final String dateStart;
  final String dateEnd;

  const DateMoodQuery({
    required this.dateStart,
    required this.dateEnd
  });
}