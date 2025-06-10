import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/Services.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController todocontroller = TextEditingController();

  void showeditdialogue(BuildContext context, String id, String currenttext) {
    TextEditingController editingController = TextEditingController(
      text: currenttext,
    );
    showDialog(
      context: context,
      builder: (context) {
        return Container(
          child: AlertDialog(
            title: Text(
              "EditTodo",
              style: GoogleFonts.timmana(
                color: const Color.fromARGB(255, 12, 12, 12),
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            content: TextField(
              controller: editingController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  updatetodo(id, editingController.text);
                  Navigator.pop(context);
                },
                child: Text(
                  "Update",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 54, 194, 241),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [Color(0xFFE1F4F2), Color(0xFFB8E4DC)],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              width: double.infinity,
              height: 650,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Todo List ",
                        style: GoogleFonts.radley(
                          color: const Color.fromARGB(255, 10, 10, 10),
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                      Icon(Icons.list_alt_sharp),
                    ],
                  ),

                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: todocontroller,
                          decoration: InputDecoration(
                            hintText: "Enter Task",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (todocontroller.text != "") {
                              addtodo(
                                text: todocontroller.text,
                                context: context,
                              );
                              todocontroller.clear();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFB8E4DC),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),

                          child: Text(
                            "Add",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 0),

                  Expanded(
                    child: StreamBuilder(
                      stream: fetchtodo(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<Map<String, dynamic>> todos = snapshot.data!;
                          return ListView.builder(
                            itemCount: todos.length,
                            itemBuilder: (context, Index) {
                              return ListTile(
                                title: Text(todos[Index]["Todo"]),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        showeditdialogue(
                                          context,
                                          todos[Index]["id"],
                                          todos[Index]["Todo"],
                                        );
                                      },
                                      icon: Icon(Icons.edit),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        deletetodo(todos[Index]["id"]);
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: const Color.fromARGB(
                                          255,
                                          191,
                                          37,
                                          37,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Text("Error Loading data");
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.blueGrey,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
