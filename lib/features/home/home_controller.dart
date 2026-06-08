import 'package:flutter/material.dart';
import 'package:tasky3/core/constants/storage_key.dart';
import 'package:tasky3/core/services/prefrence-manager.dart';
import 'package:tasky3/models/task_model.dart';

class HomeController with ChangeNotifier {
  List<TaskModel> tasksList = [];
  String? username;
  String? userImage;

  void init() {
    loadUserData();
  }

  void loadUserData() async {
    username = PrefrenceManager().getString(StorageKey.username);
    userImage = PrefrenceManager().getString(StorageKey.userImage);

    notifyListeners();
  }
}
