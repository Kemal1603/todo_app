import 'package:flutter/material.dart';
import 'package:todoey_app/Screens/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'logic/task_data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(Todoey());
}

class Todoey extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Data>(
      create:  (context) => Data(),
      child: MaterialApp(
        home: MainScreen(),
      ),
    );
  }
}



