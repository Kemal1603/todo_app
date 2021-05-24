import 'package:flutter/material.dart';




class NewTask extends StatelessWidget {

  final bool isChecked;
  final String taskTitle;
  final Function checkBoxPushed;


  NewTask({this.isChecked, this.taskTitle, this.checkBoxPushed});


  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('$taskTitle',
          style: TextStyle(
            fontSize: 20.0,
              color: isChecked ? Colors.red : null,
              decoration: isChecked ? TextDecoration.lineThrough : null)),
      trailing: Checkbox(
          activeColor: Colors.pink,
          value: isChecked,
          onChanged: (value){
            checkBoxPushed(value);
          } )
    );
  }
}







