import 'package:flutter/material.dart';
import 'package:organizer/src/models/task_model.dart';
import 'package:organizer/src/utils/theme.dart';
import 'package:uuid/uuid.dart';

import '../../../utils/constants.dart';

class CardTodo extends StatelessWidget {
  const CardTodo(
      {super.key,
      required this.firstColor,
      required this.secondColor,
      required this.openContainer,
      required this.taskModel});

  final Color firstColor;
  final Color secondColor;
  final VoidCallback openContainer;
  final TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
              colors: [firstColor, secondColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)),
      child: InkWell(
        onTap: openContainer,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "#${taskModel.id!.substring(0, 8)}",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Colors.black87),
                    ),
                  ),
                  Text(
                    dateFormatBrlTime(date: taskModel.doneAt!),
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.black),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.black.withOpacity(0.1),
                    child: Icon(
                      taskModel.done!
                          ? Icons.check_outlined
                          : Icons.timer_outlined,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
              const Divider(
                color: Colors.black26,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      taskModel.title!,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: Colors.black87),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
