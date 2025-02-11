import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view_models/task_view_model.dart';
import 'views/task_list_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TaskListScreen(),
      ),
    ),
  );
}
