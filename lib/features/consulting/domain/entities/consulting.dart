// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

class ConsultingStatus extends Equatable {

  final int? id;
  final String? problem;
  final String? status;
  final String? created_at;

  const ConsultingStatus({
    this.id,
    this.problem,
    this.status,
    this.created_at
  });

  @override
  List<Object?> get props => [id!, problem!, status!, created_at!];
}

class ConsultingDetail extends Equatable {

  final int? id;
  final int? user_id;
  final String? problem;
  final String? status;
  final String? appointment_date;
  final String? location;
  final String? created_at;
  final String? updated_at;


  const ConsultingDetail({
    this.id,
    this.user_id,
    this.problem,
    this.status,
    this.appointment_date,
    this.location,
    this.created_at,
    this.updated_at
  });

  @override
  List<Object?> get props => [id!, user_id!, problem!, status!, appointment_date!, location!, created_at!, updated_at!];

}


class ConsultingRequest extends Equatable {
  final String? problem;

  const ConsultingRequest({
    this.problem
  });
  
  @override
  List<Object?> get props => [problem!];
}