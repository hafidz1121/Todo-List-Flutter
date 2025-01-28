import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/pages/add_todo.dart';
import 'package:todo_list/pages/update_todo.dart';
import 'package:todo_list/services/shared_preferences.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'theme/theme.dart';
import 'theme/theme_provider.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController searchBarTxt = TextEditingController();
  SharedPreferencesService? service;
  List<Map<String, dynamic>> listData = [];
  List<Map<String, dynamic>> filteredData = [];

  @override
  void initState() {
    super.initState();
    initializationSplashScreen();
    initSharedPreferences();
  }

  void initializationSplashScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    FlutterNativeSplash.remove();
  }

  Future<void> initSharedPreferences() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    service = SharedPreferencesService(sharedPreferences);
    await _refreshData();
  }

  Future<void> _refreshData() async {
    if (service != null) {
      listData = await service!.getTodo();
      _filterTasks(); // Apply filter to update `filteredData`
    }
  }

  void _filterTasks() {
    final query = searchBarTxt.text.toLowerCase();
    setState(() {
      filteredData = listData
          .where((task) => task['name'].toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'To Do List',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(Icons.search, size: 22),
                  ),
                  Expanded(
                    child: TextField(
                      textInputAction: TextInputAction.search,
                      controller: searchBarTxt,
                      keyboardType: TextInputType.text,
                      textAlignVertical: TextAlignVertical.center,
                      onChanged: (value) => _filterTasks(),
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          contentPadding: EdgeInsets.only(left: 0),
                          focusedBorder: InputBorder.none,
                          filled: true,
                          isDense: true,
                          fillColor: Colors.transparent),
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                      obscureText: false,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) => IconButton(
              icon: Icon(
                themeProvider.themeData == lightMode
                    ? Icons.dark_mode
                    : Icons.light_mode,
              ),
              onPressed: () {
                themeProvider.toggleTheme();
              },
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filteredData.length,
        itemBuilder: (context, index) {
          final task = filteredData[index];
          final isDone = task['isDone'] as bool;

          return GestureDetector(
            onLongPress: () async {
              final result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UpdateTodoPage(
                    title: task['name'] as String,
                    index: index,
                  ),
                ),
              );
              if (result == true) {
                await _refreshData();
              }
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
                  )),
              margin: const EdgeInsets.only(
                top: 10,
                left: 17,
                right: 17,
              ),
              height: 55,
              child: Row(
                children: [
                  const SizedBox(width: 15),
                  GestureDetector(
                    onTap: () async {
                      await service?.toggleTaskCompletion(index);
                      await _refreshData();
                    },
                    child: Icon(
                      isDone ? Icons.check_circle : Icons.check_circle_outline,
                      color: isDone ? Colors.green : Colors.grey,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      task['name'] as String,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: GestureDetector(
                      onTap: () async {
                        await service?.removeTodoList(index);
                        await _refreshData();
                      },
                      child: const Icon(Icons.delete, color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AddTodoPage()),
          );
          if (result == true) {
            await _refreshData();
          }
        },
        label: const Text(
          'Add Todo',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        icon: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
