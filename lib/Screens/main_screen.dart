import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_app/logic/task_data.dart';
import 'package:todoey_app/logic/task_tile.dart';



class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  String task;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.pink,
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  color: Color(0xff757575),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(
                          children: [
                            Text(
                              'ADD TASK',
                              style: TextStyle(
                                  color: Colors.pink,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextField(
                              onChanged: (userInput){
                                task = userInput;
                              },
                              autofocus: true,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.pink))),
                            ),
                            TextButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.pink)),
                                onPressed: (){

                                  setState(() {
                                    Provider.of<Data>(context, listen: false).addTask(Task(name: '$task', isDone: false));
                                    Navigator.pop(context);

                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                                  child: Text('ADD',
                                  style: TextStyle(
                                      color: Colors.white,
                                  fontSize: 20.0),),
                                ))
                          ],
                        ),
                      )),
                );
              },
            );
          },
          child: Icon(Icons.add),
        ),
        backgroundColor: Colors.pink,
        body: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 100.0,
                    ),
                    CircleAvatar(
                        radius: 35.0,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.list,
                          size: 35.0,
                          color: Colors.pink,
                        )),
                    SizedBox(
                      height: 15.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Tasks',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      Provider.of<Data>(context).tasks.length == 1 ?
                      '  ${Provider.of<Data>(context).tasks.length} Task': '    ${Provider.of<Data>(context).tasks.length} Tasks',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                  ],
                )
              ],
            ),
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: ListView.builder(
                      itemCount: Provider.of<Data>(context).tasks.length,
                        itemBuilder: (context, index){
                          final item = Provider.of<Data>(context).tasks[index].name;

                          return Dismissible(
                            secondaryBackground: Container(
                                color: Colors.pink,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(Icons.delete_forever,size: 40.0,),
                                  ],
                                )),
                            direction: Provider.of<Data>(context).tasks[index].isDone ? DismissDirection.endToStart : DismissDirection.none,
                            key: UniqueKey(),
                            onDismissed: (direction) {

                              setState(() {
                                Provider.of<Data>(context, listen: false).deleteTask(index);
                              });

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text("$item dismissed")));
                            },

                            background: Container(color: Colors.red),
                            child: NewTask(
                              taskTitle: Provider.of<Data>(context).tasks[index].name,
                              isChecked: Provider.of<Data>(context).tasks[index].isDone,
                              checkBoxPushed: (bool checkState){

                                  setState(() {
                                    Provider.of<Data>(context, listen: false).tasks[index].isDone = checkState;
                                  });

                              },),
                          );
                        })
                  )),
            ),
          ],
        ));
  }
}



