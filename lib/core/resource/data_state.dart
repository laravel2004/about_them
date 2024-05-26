abstract class DataState<T> {
  final String? error;
  final T? data;

  const DataState({this.error, this.data});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(String error) : super(error: error);
}