import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoprovider_dart/Provider/AppState.dart';
import 'package:todoprovider_dart/Todoclass.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AppState(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Api using provider',
          theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red)
                  .copyWith(secondary: Colors.purpleAccent)),
          home: const TodoClass(),
        ));
  }
}
