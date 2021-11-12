import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../global/globals.dart' as g;
// import '../widgets/todo_form.dart';
// import 'package:useharian/widgets/add_todo_dialog_widget.dart';
// import '../widgets/todolistwidget.dart'

class Todo extends StatefulWidget {
  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  int selectedindex = 0;
  TextEditingController titleController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  String title = '';
  String description = 'No description';
  String completeTitle = '';
  String completeDesc = '';

  // _saveTodo(list) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   prefs.setStringList("key", list);

  //   return true;
  // }

  //  _getSavedList() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   if (prefs.getStringList("key") != null)
  //     todo = prefs.getStringList("key");
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      ListView.builder(
        itemBuilder: (BuildContext ctx, int index) {
          return Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Card(
                  margin: const EdgeInsets.all(15),
                  color: const Color.fromRGBO(49, 38, 62, 1),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${index + 1}.  ${g.todo[index]['title']}'),
                              Text(
                                '     ${g.todo[index]['description']}',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                print('title:  $title');
                                completeTitle =
                                    g.todo[index]['title'].toString();
                                completeDesc =
                                    g.todo[index]['description'].toString();
                                g.completedTodo.add({
                                  'title': completeTitle,
                                  'description': completeDesc,
                                });
                                g.todo.removeAt(index);
                                // print(completedTodo[index]['title']);
                              });
                            },
                            style:
                                ElevatedButton.styleFrom(primary: Colors.green),
                            child: Column(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.done,
                                    color: Colors.white,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: FittedBox(
                                    child: Text(
                                      'Done',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                g.todo.removeAt(index);
                              });
                            },
                            style:
                                ElevatedButton.styleFrom(primary: Colors.red),
                            child: Column(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: FittedBox(
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                // ElevatedButton(
                //     onPressed: _saveTodo(todo), child: Text('Save List'))
              ],
            ),
          );
        },
        itemCount: g.todo.length,
      ),
      // =======================================================================
      ListView.builder(
        itemBuilder: (BuildContext ctx, int index) {
          return Container(
            width: MediaQuery.of(context).size.width,
            child: Card(
                margin: const EdgeInsets.all(15),
                color: const Color.fromRGBO(49, 38, 62, 1),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                '${index + 1}.  ${g.completedTodo[index]['title']}'),
                            Text(
                              '     ${g.completedTodo[index]['description']}',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              g.completedTodo.removeAt(index);
                            });
                          },
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          child: Column(
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: FittedBox(
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          );
        },
        itemCount: g.completedTodo.length,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'To Do List',
              style: Theme.of(context).textTheme.headline2,
            ),
            const FittedBox(
              child: Text(
                'Note: closing the App from background will delete the list',
              ),
            )
          ],
        ),
        backgroundColor: const Color.fromRGBO(34, 30, 34, 1),
        elevation: 0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(34, 30, 34, 1),
        unselectedItemColor: const Color.fromRGBO(68, 53, 91, 1),
        selectedItemColor: const Color.fromRGBO(238, 86, 34, 1),
        currentIndex: selectedindex,
        onTap: (index) => setState(() {
          selectedindex = index;
        }),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fact_check_outlined),
            label: 'To Do',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.done,
              size: 28,
            ),
            label: 'Completed',
          ),
        ],
      ),
      body: Container(
          color: const Color.fromRGBO(34, 30, 34, 1),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: tabs[selectedindex]),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: const Color.fromRGBO(236, 167, 44, 1),
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Container(
              height: MediaQuery.of(context).size.height * 0.35,
              child: Column(
                children: [
                  // Text('Title'),
                  TextFormField(
                    controller: titleController,
                    // onChanged: (value) => title = value,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Title',
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Description',
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: titleController.text == null
                        ? () {}
                        : () {
                            setState(() {
                              title = titleController.text;
                              description = descriptionController.text;
                              titleController.clear();
                              descriptionController.clear();
                              Navigator.of(context).pop();
                              g.todo.add(
                                  {'title': title, 'description': description});
                            });
                          },
                    child: Text('Add'),
                    style: ElevatedButton.styleFrom(primary: Colors.black),
                  ),
                  // Text('data = ${todo[0]['title']}')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
