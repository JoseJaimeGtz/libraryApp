part of 'book_bloc.dart';

@immutable
abstract class BookEvent {
  const BookEvent();

  @override
  String get props => '';
}

class SearchBook extends BookEvent {
  final String wordKey;
  SearchBook({required this.wordKey});
}
