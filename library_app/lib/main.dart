import 'package:flutter/material.dart';
import 'package:library_app/book_info.dart';
import 'package:library_app/home_page.dart';
import 'package:library_app/bloc/book_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(BlocProvider(
  create: (context) => BookBloc(),
  child: const MyApp(),
));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Librería',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(primary: Color.fromARGB(255, 50, 50, 50))),
      home: HomePage(),
      routes: {
        '/book_info': (context) => BookInfo(),
      },
    );
  }
}
