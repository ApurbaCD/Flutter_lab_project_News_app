import 'package:flutter/material.dart';

class CategoryNews extends StatefulWidget {
  const CategoryNews({super.key});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Text('News',style: TextStyle(
              color: Colors.blue,
            ),),
            Text('App'),
          ],
        ),
      ),
    );
  }
}