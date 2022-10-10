part of 'book_bloc.dart';

@immutable
abstract class BookState {
  const BookState();

  @override
  String get props => '';
}

class BookInitial extends BookState {}

class BookLoading extends BookState {}

class BookLoaded extends BookState {
  final List<dynamic> booksLoaded;
  BookLoaded({required this.booksLoaded});
}

class BookError extends BookState {
  final String error;
  BookError({required this.error});
}
