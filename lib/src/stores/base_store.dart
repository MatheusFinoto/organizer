// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

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
}
