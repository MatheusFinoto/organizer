import 'package:flutter/material.dart';

class SideBarTile extends StatelessWidget {
  const SideBarTile(
      {Key? key,
      required this.title,
      required this.selected,
      required this.icon,
      required this.onTap})
      : super(key: key);

  final String title;
  final bool selected;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color:
              selected ? Theme.of(context).primaryColor.withOpacity(0.4) : null,
          borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.only(right: 12, left: 12),
      child: InkWell(
        onTap: onTap,
        hoverColor: Theme.of(context).primaryColor.withOpacity(0.6),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon,
                  color: selected
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).iconTheme.color),
              title == ''
                  ? Container()
                  : Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          title,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: selected
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white70
                                      : Colors.black45),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
