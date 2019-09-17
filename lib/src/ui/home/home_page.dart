import 'package:flutter/material.dart';

import './home_bloc.dart';

class HomePage extends StatelessWidget {
  final appName = 'HackTrack';
  @override
  Widget build(BuildContext context) {
    final bloc = HomeBloc();
    return Scaffold(
      appBar: AppBar(
        title: Text(appName),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            StreamBuilder(
              initialData: 0,
              stream: bloc.counterValue,
              builder: (context, snapshot) => Text(
                '${snapshot.data}',
                style: Theme.of(context).textTheme.display1,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: bloc.increment,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
