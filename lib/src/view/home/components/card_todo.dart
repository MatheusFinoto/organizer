import 'package:flutter/material.dart';
import 'package:organizer/src/view/task/task_screen.dart';
import 'package:uuid/uuid.dart';

import '../../../utils/constants.dart';

class CardTodo extends StatelessWidget {
  CardTodo({super.key});

  Color firstColor = randomColor();
  Color secondColor = randomColor();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
              colors: [firstColor, secondColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => TaskScreen(
                    firstColor: firstColor,
                    secondColor: secondColor,
                  )));
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "#${const Uuid().v4().substring(0, 8).toUpperCase()}",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Colors.black87),
                    ),
                  ),
                  Text(
                    '17:30',
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
                    child: const Icon(
                      Icons.timer_outlined,
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
                      'Comprar ração do cachorro',
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
