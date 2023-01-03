// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:organizer/src/models/task_model.dart';
import 'package:organizer/src/utils/constants.dart';
import 'package:uuid/uuid.dart';

part 'base_store.g.dart';

class BaseStore = _BaseStore with _$BaseStore;

abstract class _BaseStore with Store {
  @observable
  int selectedPage = 1;

  @action
  void setSelectedPage(int page) => selectedPage = page;

  @observable
  bool expand = false;

  @action
  void setExpand(v) => expand = v;

  @observable
  bool showContent = false;

  @action
  void setShowContent(v) => showContent = v;

  @observable
  PageController? pageController;

  @observable
  bool themeDark = false;

  @action
  void setTheme(value) => themeDark = value;

  var task = {
    "id": "",
    "title": "",
    "description": "",
    "created_at": "",
    "done_at": "",
    "done": true,
  };

  @observable
  ObservableList<TaskModel> listOfTasks = ObservableList();

  @observable
  HttpStatus getTasksStatus = HttpStatus.none;

  final now = DateTime.now();

  @action
  Future<void> getListOfTasks() async {
    try {
      getTasksStatus = HttpStatus.loading;

      listOfTasks.add(TaskModel(
          id: const Uuid().v4(),
          title: 'Comprar Ração',
          description:
              'Passar na loja do Gim e comprar ração pro gato e pro Cachorro',
          done: false,
          createdAt: now.toUtc().toString(),
          doneAt: now.add(const Duration(hours: 2)).toUtc().toString()));
    } catch (e) {
      getTasksStatus = HttpStatus.fail;
    }
  }

  @observable
  TaskModel? selectedTaskModel;

  @action
  void setSelectedTaskModel(value) {
    selectedTaskModel = value;
  }
}
