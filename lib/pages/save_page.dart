import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:hive_test2/models/item.dart';
import 'package:hive_test2/utils/dependcy_injection.dart';
import 'package:hive_test2/utils/hive_storage.dart';

class SaveNumber extends StatefulWidget {
  const SaveNumber({
    Key? key,
  }) : super(key: key);
  @override
  State<SaveNumber> createState() => _SaveNumberState();
}

class _SaveNumberState extends State<SaveNumber> {
  final HiveStorage hiveStorage = dependencyLocator.get<HiveStorage>();
  void putToHive() {
    word = tempWord;
    num = tempNum;
    if (num != '' && num != null) {
      setState(() {
        item = Item(age: num, name: word);

        hiveStorage.box.put(0, item);
        FocusScope.of(context).requestFocus(FocusNode());
        const snackBar = SnackBar(
          content: Text('The number updated!'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    } else {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: "Enter Ccorrect number!",
      );
    }
  }

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
                    'please enter a number',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: TextFormField(
                      onEditingComplete: putToHive,
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                      onChanged: (value) => tempNum = int.tryParse(value)),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    'Then press save button',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  height: 70,
                  width: 70,
                  child: IconButton(
                    icon: Image.asset(
                      'assets/images/inbox.png',
                    ),
                    onPressed: putToHive,
                  ),
                ),
                const SizedBox(
                  height: 44,
                ),
                item?.age != null
                    ? Column(
                        children: [
                          const Text('Your last saved number is : ',
                              style: TextStyle(
                                  color: Colors.redAccent, fontSize: 22)),
                          Text(
                            item!.age!.toString(),
                            style: const TextStyle(
                                color: Colors.redAccent, fontSize: 44),
                          )
                        ],
                      )
                    : const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'You have not saved any number yet!',
                          style: TextStyle(fontSize: 22),
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
