import 'dart:math';

import 'package:flutter/material.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:hive_test2/pages/remove_page.dart';
import 'package:hive_test2/pages/save_page.dart';
import 'package:hive_test2/pages/show_page.dart';

class PageManager extends StatelessWidget {
  const PageManager({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container( 
          color: Colors.blue,
          child: ContainedTabBarView(
            initialIndex: 0,
            callOnChangeWhileIndexIsChanging: true,
            tabBarProperties: TabBarProperties(
              padding: const EdgeInsets.all(0),
              background: Container(
                color: Colors.blueGrey,
              ),
              height: 50,
              indicatorWeight: 3,
              unselectedLabelStyle:
                  const TextStyle(fontSize: 14, color: Colors.black),
              labelColor: Colors.yellow,
              unselectedLabelColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Colors.yellow,
            ),
            tabs: const [
              Text('Show'),
              Text('Save'),
              Text('Remove'),
            ],
            views: const [
              ShowNumber(),
              SaveNumber(),
              RemoveNumber(),
            ],
            onChange: (index) => log(index),
          ),
        ),
      ),
    );
  }
}
