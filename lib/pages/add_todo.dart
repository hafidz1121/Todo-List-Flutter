// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/services/shared_preferences.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Add To Do',
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
              'Create New Todo List',
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
                    fontSize: 16,
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
                          .addToDoList(controller.text);

                      Navigator.of(context).pop(true);
                    }
                  },
                  icon: const Icon(
                    Icons.save,
                  ),
                  label: const Text(
                    "Save",
                    style: TextStyle(
                      fontSize: 16,
                    ),
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
