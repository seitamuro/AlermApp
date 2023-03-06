import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import 'alerm.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Alerm App'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Alerm> alermList = [
    Alerm(alermTime: DateTime.now()),
    Alerm(alermTime: DateTime.now()),
    Alerm(alermTime: DateTime.now()),
  ];
  SlidableController controller = SlidableController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(
              backgroundColor: Colors.black,
              largeTitle: Text("アラーム", style: TextStyle(color: Colors.white)),
              trailing: GestureDetector(
                child: Icon(Icons.add, color: Colors.orange),
                onTap: () {

                },
              )
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    Alerm alerm = alermList[index];
                    return Column(
                      children: [
                        if(index == 0) const Divider(color: Colors.grey, height: 1),
                        Slidable(
                          controller: controller,
                          actionPane: const SlidableScrollActionPane(),
                          child: ListTile(
                            title: Text(
                              DateFormat('H:mm').format(alerm.alermTime),
                              style: TextStyle(color: Colors.white, fontSize: 50)
                            ),
                            trailing: CupertinoSwitch(
                              value: alerm.isActive,
                              onChanged: (newValue) {
                                setState(() {
                                  alerm.isActive = newValue;
                                });
                              },
                            ),
                          ),
                          secondaryActions: [
                            IconSlideAction(
                              icon: Icons.delete,
                              caption: "削除",
                              color: Colors.red,
                              onTap: (){},
                            )
                          ],
                        ),
                        const Divider(),
                      ],
                    );
                  },
                  childCount: alermList.length
                )
            )
          ],
        )
      ),
    );
  }
}
