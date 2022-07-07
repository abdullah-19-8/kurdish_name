import 'package:flutter/material.dart';
import 'package:flutter_api/src/Names/Models/get_set_data.dart';
import '../Models/models.dart';
import '../services/names_services.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var limit = ["5", "10", "100"].map<DropdownMenuItem<String>>((String limitX) {
    return DropdownMenuItem(value: limitX, child: Text(limitX));
  }).toList();
  var gender = ["M", "F", "O"].map<DropdownMenuItem<String>>((String gen) {
    return DropdownMenuItem(value: gen, child: Text(gen));
  }).toList();
  var sortBy =
      ["positive", "negative"].map<DropdownMenuItem<String>>((String sort) {
    return DropdownMenuItem(value: sort, child: Text(sort));
  }).toList();
  final NamesServices _services = NamesServices();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            const SizedBox(
              height: 20
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownButton(
                      items: limit,
                      value: Values.LimitV,
                      onChanged: (String? newValue) {
                        setState(() {
                          Values.LimitV = newValue!;
                        });
                      }),
                  DropdownButton(
                      items: gender,
                      value: Values.GenderV,
                      onChanged: (String? newValue) {
                        setState(() {
                          Values.GenderV = newValue!;
                        });
                      }),
                  DropdownButton(
                    items: sortBy,
                    value: Values.SortV,
                    onChanged: (String? newValue) {
                      setState(
                        () {
                          Values.SortV = newValue!;
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: FutureBuilder<KurdishName>(
                    future: _services.fetchListNames() as Future<KurdishName>?,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      } else if (snapshot.data == null) {
                        return const Text("No Data Found");
                      }
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return ExpansionTile(
                            leading: Text(snapshot
                                .data!.names[index].positiveVotes
                                .toString()),
                            title: Text(
                                snapshot.data!.names[index].name.toString()),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(snapshot.data!.names[index].desc
                                    .toString()),
                              )
                            ],
                          );
                        },
                        itemCount: snapshot.data!.names.length,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
