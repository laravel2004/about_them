// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

class JournalCreate extends Equatable {
  final int? id;
  final String? title;
  final String? note;

  const JournalCreate({
    this.id,
    this.title,
    this.note
  });
  
  @override
  List<Object?> get props => [id!,title!, note!];
}

class JournalDetail extends Equatable {
  final int? id;
  final int? user_id;
  final String? title;
  final String? note;
  final String? created_at;
  final String? updated_at;

  const JournalDetail({
    this.id,
    this.user_id,
    this.title,
    this.note,
    this.created_at,
    this.updated_at
  });
  
  @override
  List<Object?> get props => [id!, user_id!, title!, note!, created_at!, updated_at!];
}

class JournalAll extends Equatable {
  final int? id;
  final String? title;
  final String? updated_at;

  const JournalAll({
    this.id,
    this.title,
    this.updated_at
  });
  
  @override
  List<Object?> get props => [id!, title!, updated_at!];
}

