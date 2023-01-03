import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:mobx/mobx.dart';
import 'package:organizer/src/components/icons/custom_icon_buttom.dart';
import 'package:organizer/src/models/task_model.dart';
import 'package:organizer/src/stores/base_store.dart';
import 'package:organizer/src/utils/theme.dart';
import 'package:organizer/src/view/home/components/card_todo.dart';
import 'package:organizer/src/view/task/task_screen.dart';

import '../../utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  BaseStore baseStore = BaseStore();

  @override
  void initState() {
    super.initState();
    baseStore.getListOfTasks();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: SizedBox(
      height: size.height,
      width: size.width,
      child: SingleChildScrollView(
        child: AnimationLimiter(
          child: Column(
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 600),
              childAnimationBuilder: (widget) => SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(
                  child: widget,
                ),
              ),
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
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(
                                fontWeight: FontWeight.w300,
                                color: blue500,
                                height: 1),
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
                      CustomIconButton(
                          onTap: () {}, iconData: Icons.add_outlined)
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

                Observer(builder: (_) {
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: baseStore.listOfTasks.length,
                      itemBuilder: (_, index) {
                        TaskModel tk = baseStore.listOfTasks[index];
                        Color firstColor = randomColor();
                        Color secondColor = randomColor();

                        while (secondColor == firstColor) {
                          secondColor = randomColor();
                        }

                        return OpenContainer(
                          transitionDuration:
                              const Duration(milliseconds: 1200),
                          transitionType: ContainerTransitionType.fade,
                          closedShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          closedColor: blue800,
                          openColor: green200,
                          middleColor: green100,
                          closedElevation: 0,
                          closedBuilder: (_, openContainer) {
                            return Column(
                              children: [
                                CardTodo(
                                  taskModel: tk,
                                  firstColor: firstColor,
                                  secondColor: secondColor,
                                  openContainer: openContainer,
                                ),
                                const SizedBox(
                                  height: 8,
                                )
                              ],
                            );
                          },
                          openBuilder: (_, closeContainer) {
                            return TaskScreen(
                              taskModel: tk,
                              firstColor: firstColor,
                              secondColor: secondColor,
                              onClose: closeContainer,
                            );
                          },
                          onClosed: (_) {},
                        );
                      },
                    ),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
