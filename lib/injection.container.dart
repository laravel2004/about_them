import 'package:get_it/get_it.dart';
import 'package:them/features/auth/data/datasource/auth_remote.dart';
import 'package:them/features/auth/data/repository/auth_repository_impl.dart';
import 'package:them/features/auth/domain/repositories/auth_repository.dart';
import 'package:them/features/auth/domain/usecases/login.dart';
import 'package:them/features/auth/domain/usecases/me.dart';
import 'package:them/features/auth/domain/usecases/register.dart';
import 'package:them/features/consulting/data/datasource/consulting_remote.dart';
import 'package:them/features/consulting/data/repository/consulting_repository_impl.dart';
import 'package:them/features/consulting/domain/repositories/consulting_repository.dart';
import 'package:them/features/consulting/domain/usecases/detail_consulting.dart';
import 'package:them/features/consulting/domain/usecases/get_all_consulting.dart';
import 'package:them/features/consulting/domain/usecases/request_consulting.dart';
import 'package:them/features/journal/data/datasource/journal_remote.dart';
import 'package:them/features/journal/data/repository/journal_repository_impl.dart';
import 'package:them/features/journal/domain/repositories/journal_repository.dart';
import 'package:them/features/journal/domain/usecases/create_journal.dart';
import 'package:them/features/journal/domain/usecases/delete_journal.dart';
import 'package:them/features/journal/domain/usecases/get_all_journal.dart';
import 'package:them/features/journal/domain/usecases/get_detail_journal.dart';
import 'package:them/features/journal/domain/usecases/update_journal.dart';
import 'package:them/features/mood/data/datasource/mood_remote.dart';
import 'package:them/features/mood/data/repository/mood_repository_impl.dart';
import 'package:them/features/mood/domain/repositories/mood_repository.dart';
import 'package:them/features/mood/domain/usecases/get_all_mood.dart';
import 'package:them/features/mood/domain/usecases/get_detail_mood.dart';
import 'package:them/features/mood/domain/usecases/update_mood.dart';

final sl = GetIt.instance;

Future<void> initStateDependencies() async {

  sl.registerLazySingleton<AuthRemote>(() => AuthRemote());
  sl.registerLazySingleton<JournalRemote>(() => JournalRemote());
  sl.registerLazySingleton<ConsultingRemote>(() => ConsultingRemote());
  sl.registerLazySingleton<MoodRemote>(() => MoodRemote());


  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<JournalRepository>(() => JournalRepositoryImpl(sl()));
  sl.registerLazySingleton<ConsultingRepository>(() => ConsultingRepositoryImpl(sl()));
  sl.registerLazySingleton<MoodRepository>(() => MoodRepositoryImpl(sl()));

  sl.registerLazySingleton(() => DetailConsulting(sl()));
  sl.registerLazySingleton(() => GetAllConsulting(sl()));
  sl.registerLazySingleton(() => RequestConsulting(sl()));

  sl.registerLazySingleton(() => Login(sl()));
  sl.registerLazySingleton(() => Me(sl()));
  sl.registerLazySingleton(() => Register(sl()));

  sl.registerLazySingleton(() => CreateJournal(sl()));
  sl.registerLazySingleton(() => UpdateJournal(sl()));
  sl.registerLazySingleton(() => DeleteJournal(sl()));
  sl.registerLazySingleton(() => GetAllJournal(sl()));
  sl.registerLazySingleton(() => GetDetailJournal(sl()));

  sl.registerLazySingleton(() => GetAllMood(sl()));
  sl.registerLazySingleton(() => GetDetailMood(sl()));
  sl.registerLazySingleton(() => UpdateMood(sl()));

}