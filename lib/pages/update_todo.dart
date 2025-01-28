// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/services/shared_preferences.dart';

class UpdateTodoPage extends StatefulWidget {
  const UpdateTodoPage({super.key, this.title, this.index});

  final String? title;
  final int? index;

  @override
  State<UpdateTodoPage> createState() => _UpdateTodoPageState();
}

class _UpdateTodoPageState extends State<UpdateTodoPage> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    controller = TextEditingController(text: widget.title);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Update To Do',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 10),
            child: Text(
              'Updating Todo List',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 1,
                ),
              ),
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Go To Work, etc.',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  focusedBorder: InputBorder.none,
                  filled: true,
                  fillColor: Colors.transparent,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 50,
                margin: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                child: ElevatedButton.icon(
                  onPressed: () async {
                    if (controller.text.isEmpty) {
                      // Show validation message
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Validation Error"),
                          content: const Text(
                              "The text field cannot be empty. Please enter a value."),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        ),
                      );
                    } else {
                      // Proceed to save the to-do item
                      final sharedPreferences =
                          await SharedPreferences.getInstance();
                      SharedPreferencesService(sharedPreferences)
                          .updateTodoList(widget.index ?? 0, controller.text);

                      Navigator.of(context).pop(true);
                    }
                  },
                  icon: const Icon(
                    Icons.save,
                  ), // Add icon here
                  label: const Text(
                    "Save",
                    style: TextStyle(fontSize: 18,),
                  ), // Button text
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
