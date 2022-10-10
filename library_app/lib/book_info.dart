import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class BookInfo extends StatefulWidget {
  const BookInfo({super.key});

  @override
  State<BookInfo> createState() => _BookInfoState();
}

class _BookInfoState extends State<BookInfo> {
  
  bool fullDescription = false;

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments;
    args as Map<String, dynamic>;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del libro'),
        actions: [
          IconButton(
            icon: Icon(Icons.public),
            onPressed: () {}, 
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () async {
              await Share.share('Titulo: ${args['title']}\nNúmero de páginas: ${args['pageCount']}');
            }, 
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Container(
                  child: Image.network(args['image']),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  args['title'],
                  style: TextStyle(fontWeight: FontWeight.w200, fontSize: 20),
                  textAlign: TextAlign.center,
                )
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, top: 20, right: 10, bottom: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        Text('${args['date']}',
                          style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    Text('Paginas: ${args['pageCount']}',
                      style: TextStyle(fontWeight: FontWeight.w200, fontSize: 15)
                    )
                  ]
                ),
                Container(
                  child: GestureDetector(
                    onTap: () {
                      fullDescription = !fullDescription;
                      setState(() {});
                    },
                    child: _getFullDescription(args['description'], fullDescription),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _getFullDescription(String description, bool fullDescription) {
    if (fullDescription) {
      return Text(description,
        textAlign: TextAlign.justify,
        style: TextStyle(fontWeight: FontWeight.w200, fontStyle: FontStyle.italic)
      );
    } else if (description.length > 300) {
      return Text('${description.substring(0, 300)}...',
        textAlign: TextAlign.justify, 
        style: TextStyle(fontWeight: FontWeight.w200, fontStyle: FontStyle.italic)
      );
    } else {
      return Text(description, 
        textAlign: TextAlign.justify,
        style: TextStyle(fontWeight: FontWeight.w200, fontStyle: FontStyle.italic)
      );
    }
  }
}
