import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../stores/base_store.dart';

class Header extends StatefulWidget {
  const Header({super.key, required this.title});

  final String title;

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  final BaseStore baseStore = GetIt.I<BaseStore>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Inicio',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              )),
          Expanded(flex: 1, child: Container()),
          // Observer(builder: (_) {
          //   return IconButton(
          //       splashRadius: 20,
          //       onPressed: () {
          //         baseStore.setTheme(!baseStore.themeDark);
          //       },
          //       icon: baseStore.themeDark == false
          //           ? const Icon(Icons.dark_mode_outlined)
          //           : const Icon(Icons.light_mode_outlined));
          // })
        ],
      ),
    );
  }
}
