import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/bloc/book_bloc.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';

class HomePage extends StatelessWidget {
  
  HomePage({
    Key? key,
  }) : super(key: key);

  final _title = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Libreria free to play'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              controller: _title,
              decoration: InputDecoration(
                labelText: 'Ingresa titulo',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    BlocProvider.of<BookBloc>(context).add(SearchBook(wordKey: _title.text));
                  },
                )
              ),
            ),
          ),
          _showBooks()
        ],
      ),
    );
  }

  BlocConsumer<BookBloc, BookState> _showBooks() {
    return BlocConsumer<BookBloc, BookState>(
      listener: (context, BookState state) {},
      builder: (context, state) {
        if (state.runtimeType == BookInitial) {
          return Expanded(
            child: Center(
              child: Text('Ingresa un título para buscar'),
            )
          );
        } else if (state.runtimeType == BookLoading) {
          return Column(
            children: [
              VideoShimmer(),
              VideoShimmer(),
              VideoShimmer(),
            ],
          );
        } else if (state.runtimeType == BookLoaded) {
          final books = (state as BookLoaded).booksLoaded;
          return Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(books.length, (index) {
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/book_info', arguments: books[index]),
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Expanded(child: Image.network(books[index]['image'])),
                        SizedBox(height: 5),
                        Text(books[index]['title'], textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                );
              })
            ),
          );
        } else {
          final error = (state as BookError).error;
          return Expanded(
            child: Center(
              child: Text(error),
            ),
          );
        }
      }
    );
  }
}
