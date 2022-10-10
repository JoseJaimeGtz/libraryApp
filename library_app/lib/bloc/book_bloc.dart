import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:library_app/http_request.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  BookBloc() : super(BookInitial()) {
    on<BookEvent>(_searchBook);
  }

  Future<void> _searchBook(event, emit) async {
    emit(BookLoading());

    var request = HttpRequest();

    try {
      final res = await request.getBooks(event.wordKey);
      if (res['totalItems'] != 0) {

        // Books information
        var books = [];
        for (var book in res['items']) {

          // Book title
          var title;
          try {
            title = book['volumeInfo']['title'];
          } catch (e) {
            title = '-';
          }

          // Book date
          var date;
          try {
            date = book['volumeInfo']['publishedDate'];
          } catch (e) {
            date = '-';
          }

          // Book description
          var description;
          try {
            description = book['volumeInfo']['description'];
          } catch (e) {
            description = '-';
          }

          // Book page count
          var pageCount;
          try {
            pageCount = book['volumeInfo']['pageCount'];
          } catch (e) {
            pageCount = null;
          }

          // Book image
          var image;
          try {
            image = book['volumeInfo']['imageLinks']['thumbnail'];
          } catch (e) {
            image = 'http://books.google.com/books/content?id=EApnAAAAMAAJ&printsec=frontcover&img=1&zoom=5&source=gbs_api';
          }

          // Add Book
          books.add(
            {
              'title': title,
              'date': date,
              'description': description,
              'pageCount': pageCount,
              'image': image
            }
          );
        }

        print(res['items']);
        emit(BookLoaded(booksLoaded: books));

      } else {
        emit(BookError(error: 'No se encontraron resultados'));
        return;
      }
    } catch (e) {
      emit(BookError(error: 'Ha ocurrido un error: $e'));
    }
  }
}
