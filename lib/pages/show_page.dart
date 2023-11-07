import 'package:flutter/material.dart';
import 'package:hive_test2/models/item.dart';
import 'package:hive_test2/utils/dependcy_injection.dart';
import 'package:hive_test2/utils/hive_storage.dart';

class ShowNumber extends StatefulWidget {
  const ShowNumber({
    Key? key,
  }) : super(key: key);
  @override
  State<ShowNumber> createState() => _ShowNumberState();
}

class _ShowNumberState extends State<ShowNumber> {
  final HiveStorage hiveStorage = dependencyLocator.get<HiveStorage>();

  Item? item;
  @override
  void initState() {
    item = hiveStorage.box.get(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: item?.age != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Your last saved number is : ',
                      style: TextStyle(color: Colors.redAccent, fontSize: 22)),
                  const SizedBox(
                    height: 48,
                  ),
                  Text(
                    item!.age!.toString(),
                    style:
                        const TextStyle(color: Colors.redAccent, fontSize: 44),
                  )
                ],
              )
            : const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'You have not saved any number yet !',
                  style: TextStyle(fontSize: 20),
                ),
              ),
      ),
    );
  }
}
