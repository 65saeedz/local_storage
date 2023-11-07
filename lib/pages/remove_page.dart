import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:hive_test2/models/item.dart';
import 'package:hive_test2/utils/dependcy_injection.dart';
import 'package:hive_test2/utils/hive_storage.dart';

class RemoveNumber extends StatefulWidget {
  const RemoveNumber({
    Key? key,
  }) : super(key: key);
  @override
  State<RemoveNumber> createState() => _RemoveNumberState();
}

class _RemoveNumberState extends State<RemoveNumber> {
  final HiveStorage hiveStorage = dependencyLocator.get<HiveStorage>();
  int? num;
  String? word;
  int? tempNum;
  String? tempWord;
  Item? item;
  @override
  void initState() {
    item = hiveStorage.box.get(0);
    super.initState();
  }

  void putToHive() {
    if (item != null) {
      setState(() {
        hiveStorage.box.delete(
          0,
        );
        FocusScope.of(context).requestFocus(FocusNode());

        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          text: "The number removed successfully!",
        );
      });
    } else {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: "No number set !",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 16),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    'Here you can remove the number',
                    style: TextStyle(fontSize: 36),
                  ),
                ),
                const SizedBox(
                  height: 44,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 64, bottom: 32),
                  child: Text(
                    'Remove',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                SizedBox(
                  height: 70,
                  width: 70,
                  child: IconButton(
                    icon: Image.asset(
                      'assets/images/outbox.png',
                    ),
                    onPressed: putToHive,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
