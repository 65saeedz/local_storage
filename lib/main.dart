import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test2/models/item.dart';

late Box box;
Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ItemAdapter());
  box = await Hive.openBox('myBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ShowNumber());
  }
}

class ShowNumber extends StatefulWidget {
  const ShowNumber({
    Key? key,
  }) : super(key: key);
  @override
  State<ShowNumber> createState() => _ShowNumberState();
}

class _ShowNumberState extends State<ShowNumber> {
  void putToHive() {
    setState(() {
      word = tempWord;
      num = tempNum;
      item = Item(age: num, name: word);
      box.put(0, item);
      FocusScope.of(context).requestFocus(FocusNode());
      const snackBar = SnackBar(
        content: Text('The number updated!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  int? num;
  String? word;
  int? tempNum;
  String? tempWord;
  Item? item;
  @override
  void initState() {
    item = box.get(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('1- Save page'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 16),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'please enter a number then press save button',
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
              IconButton(
                icon: const Icon(
                  Icons.system_update_tv_sharp,
                  color: Colors.blue,
                  size: 45,
                ),
                onPressed: putToHive,
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
        )),
      ),
    );
  }
}
