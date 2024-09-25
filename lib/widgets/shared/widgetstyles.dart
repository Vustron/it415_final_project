import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class Widgetstyles extends StatefulWidget {
  const Widgetstyles({super.key});

  TextStyle get fontstyle =>
      const TextStyle(fontSize: 20, fontFamily: 'Quicksand_Bold');

  @override
  State<Widgetstyles> createState() => _WidgetstylesState();
}

class _WidgetstylesState extends State<Widgetstyles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'STYLES',
          style: TextStyle(fontFamily: 'Quicksand_Bold', fontSize: 20),
        ),
      ),
      body: const Center(
        child: Column(
          children: <Widget>[
            //BUTTON PRIMARY
            GFButton(
              onPressed: null,
              text: 'primary',
              textStyle: TextStyle(fontFamily: 'Quicksand_Bold', fontSize: 15),
              shape: GFButtonShape.pills,
              color: Colors.lightBlue,
            ),

            //BUTTON SECONDARY
            GFButton(
              onPressed: null,
              text: 'secondary',
              textStyle: TextStyle(fontFamily: 'Quicksand_Bold', fontSize: 15),
              shape: GFButtonShape.pills,
              color: Color.fromARGB(255, 248, 193, 211),
            ),

            Text(
              'Quicksand_Bold HEADER size20',
              style: TextStyle(fontFamily: 'Quicksand_Bold', fontSize: 20),
            ),

            Text(
              'Quicksan_Book NORMAL size 15',
              style: TextStyle(fontFamily: 'Quicksan_Book', fontSize: 15),
            ),

            Text(
              'Quicksand_Dash',
              style: TextStyle(fontFamily: 'Quicksand_Dash', fontSize: 15),
            ),

            Text(
              'Quicksan_Light',
              style: TextStyle(fontFamily: 'Quicksan_Light', fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
