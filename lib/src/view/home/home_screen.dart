import 'package:flutter/material.dart';
import 'package:organizer/src/components/icons/custom_icon_buttom.dart';
import 'package:organizer/src/utils/theme.dart';
import 'package:organizer/src/view/home/components/card_todo.dart';

import '../../utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: appBarHeight,
          ),
          //! HEADER IMAGE PROFILE
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const CircleAvatar(
                  maxRadius: 24,
                  backgroundColor: green200,
                ),
                Expanded(child: Container()),
                CustomIconButton(
                    iconData: Icons.notifications_outlined, onTap: () {}),
                const SizedBox(width: 4),
                // CustomIconButton(iconData: Icons.add_outlined, onTap: () {}),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  'Boa Tarde',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.w300, color: blue500, height: 1),
                )),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Segunda-feira',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      '02/01/2023',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: Colors.white70),
                    ),
                  ],
                )),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '70% Finalizadas',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      'Atividades Completas',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: Colors.white70),
                    ),
                  ],
                )),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              color: Colors.white,
              height: 16,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  'Tarefas',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.w300, height: 1),
                  // style: TextStyle(
                  //     fontSize: 84,
                  //     fontWeight: FontWeight.w500,
                  //     color: Colors.white),
                )),
                CustomIconButton(onTap: () {}, iconData: Icons.add_outlined)
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Chip(
                  label: const Text('Ativas'),
                  backgroundColor: blue500,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: blue500)),
                ),
                const SizedBox(
                  width: 4,
                ),
                Chip(
                  label: const Text('Finalizadas'),
                  backgroundColor: blue800,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Colors.white)),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 10,
              itemBuilder: (_, index) {
                return CardTodo();
              },
            ),
          )
        ],
      ),
    );
  }
}
