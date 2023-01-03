import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:organizer/src/models/task_model.dart';
import 'package:organizer/src/stores/base_store.dart';
import 'package:organizer/src/utils/constants.dart';
import 'package:organizer/src/utils/theme.dart';
import 'package:slide_action/slide_action.dart';

import '../../components/icons/custom_icon_buttom.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen(
      {super.key,
      required this.firstColor,
      required this.secondColor,
      required this.onClose,
      this.taskModel});

  final Color firstColor;
  final Color secondColor;
  final Function onClose;
  final TaskModel? taskModel;

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  BaseStore baseStore = BaseStore();
  late ConfettiController _controllerCenter;

  @override
  void initState() {
    super.initState();
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 2));
    if (widget.taskModel != null) {
      baseStore.setSelectedTaskModel(widget.taskModel);
    }
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [widget.firstColor, widget.secondColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)),
          ),
          Observer(builder: (_) {
            return SizedBox(
                height: size.height,
                width: size.width,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 16, vertical: appBarHeight),
                  child: AnimationLimiter(
                    child: SingleChildScrollView(
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
                            Row(
                              children: [
                                CustomIconButton(
                                  iconData: Icons.keyboard_arrow_down_outlined,
                                  onTap: () {
                                    setState(() {
                                      if (baseStore.selectedTaskModel!.done!) {
                                        baseStore.selectedTaskModel!.done =
                                            false;
                                      }
                                    });
                                    widget.onClose();
                                  },
                                ),
                                Expanded(child: Container()),
                                const SizedBox(width: 4),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Chip(
                                    backgroundColor: widget.firstColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        side: const BorderSide(
                                            color: Colors.black45)),
                                    label: Text(
                                      '#${baseStore.selectedTaskModel!.id!.substring(0, 8)}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(color: Colors.black54),
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  baseStore.selectedTaskModel!.title!,
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
                            const SizedBox(
                              height: 32,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Tempo restante',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(color: Colors.black54),
                                    ),
                                    Text(
                                      durationToString(daysBetween(
                                          DateTime.now(),
                                          DateTime.parse(
                                            baseStore
                                                .selectedTaskModel!.doneAt!,
                                          ).toLocal())),
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(color: Colors.black45),
                                    ),
                                    Text(
                                      dateFormatBrlDate(
                                          date: baseStore
                                              .selectedTaskModel!.doneAt!),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                )),
                              ],
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Descrição',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(color: Colors.black54),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      baseStore.selectedTaskModel!.description!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )),
                              ],
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Criado em',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(color: Colors.black54),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      dateFormatBrlComplete(
                                          date: baseStore
                                              .selectedTaskModel!.createdAt!),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )),
                              ],
                            ),
                            const SizedBox(
                              height: 64,
                            ),
                            baseStore.selectedTaskModel!.done!
                                ? Container(
                                    key: const ValueKey<String>('Checked'),
                                    margin: const EdgeInsets.all(6),
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )
                                : SlideAction(
                                    //key: const ValueKey<String>('notChecked'),
                                    trackHeight: 80,
                                    stretchThumb: true,
                                    trackBuilder: (context, state) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: blue800),
                                        child: Center(
                                          child: Text(
                                            'Finalizar',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          ),
                                        ),
                                      );
                                    },
                                    thumbBuilder: (context, state) {
                                      return AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 400),
                                        margin: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: const Icon(
                                          Icons.check,
                                          color: Colors.black,
                                        ),
                                      );
                                    },
                                    action: () async {
                                      setState(() {
                                        baseStore.selectedTaskModel!.done =
                                            true;
                                      });
                                      _controllerCenter.play();
                                      await Future.delayed(
                                          const Duration(seconds: 5));
                                      widget.onClose();
                                    },
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ));
          }),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              numberOfParticles: 100,
              gravity: 0.3,
              confettiController: _controllerCenter,
              blastDirectionality: BlastDirectionality
                  .explosive, // don't specify a direction, blast randomly
              shouldLoop:
                  false, // start again as soon as the animation is finished
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple
              ], // manually specify the colors to be used
              // createParticlePath: drawStar, // define a custom shape/path.
            ),
          ),
        ],
      ),
    );
  }
}
