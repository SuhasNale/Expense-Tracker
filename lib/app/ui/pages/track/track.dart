import 'package:flutter/material.dart';

class Track extends StatefulWidget {
  const Track({Key? key}) : super(key: key);

  @override
  State<Track> createState() => _TrackState();
}

class _TrackState extends State<Track> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text(
          'T R A C K   E X P E N C E S',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[300],
        elevation: 0,
      ),
      body: Center(
        child: Text('E X P E N C E S'),
      ),
    );
  }
}
