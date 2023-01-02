import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../stores/base_store.dart';
import 'side_bar_tile.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  final BaseStore baseStore = GetIt.I<BaseStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return AnimatedContainer(
        margin: const EdgeInsets.all(8),
        duration: const Duration(milliseconds: 300),
        onEnd: () {
          if (baseStore.expand == true) {
            baseStore.setShowContent(true);
          }
        },
        width: baseStore.expand ? 220 : 80,
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // baseStore.showContent
                //     ? SizedBox(
                //         width: 160,
                //         child: Image.asset(
                //           'assets/allthenticLogo.webp',
                //           width: 160,
                //           fit: BoxFit.fitWidth,
                //         ))
                //     : Container(),
                // baseStore.showContent ? const SizedBox(width: 8) : Container(),
                IconButton(
                    splashRadius: 20,
                    onPressed: () {
                      baseStore.setExpand(!baseStore.expand);
                      if (baseStore.expand == false) {
                        baseStore.setShowContent(false);
                      }
                    },
                    icon: baseStore.expand
                        ? const Icon(Icons.close)
                        : const Icon(Icons.menu)),
              ],
            ),
            const SizedBox(height: 36),
            Expanded(
              child: ListView(
                children: [
                  SideBarTile(
                      title: baseStore.showContent ? 'INÍCIO' : '',
                      selected: baseStore.selectedPage == 0,
                      icon: Icons.dashboard_outlined,
                      onTap: () {
                        if (baseStore.selectedPage != 0) {
                          baseStore.setSelectedPage(0);
                        }
                      }),
                  const SizedBox(
                    height: 8,
                  ),
                  SideBarTile(
                      title: baseStore.showContent ? 'PEDIDOS' : '',
                      selected: baseStore.selectedPage == 1,
                      icon: Icons.integration_instructions_outlined,
                      onTap: () {
                        if (baseStore.selectedPage != 1) {
                          baseStore.setSelectedPage(1);
                        }
                      }),
                  const SizedBox(
                    height: 8,
                  ),
                  SideBarTile(
                      title: baseStore.showContent ? 'CLIENTES' : '',
                      selected: baseStore.selectedPage == 2,
                      icon: Icons.group_outlined,
                      onTap: () {
                        if (baseStore.selectedPage != 2) {
                          baseStore.setSelectedPage(2);
                        }
                      }),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
