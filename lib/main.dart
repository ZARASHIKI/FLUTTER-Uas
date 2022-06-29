import 'package:flutter/material.dart';
import 'package:uas/zodiac.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Zodiac>> futureZodiac;
  int _selectedindex = 0;
  void _changeSelectedNavBar(int index) {
    setState(() {
      _selectedindex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    futureZodiac = fetchZodiac();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FutureBuilder<List<Zodiac>>(
            future: futureZodiac,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final zodiacs = snapshot.data!;
                return ListView.builder(
                  itemCount: zodiacs.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      // onTap: () => _navigateAndDisplayEditForm(context, index),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image.network(
                              zodiacs[index].photo,
                              width: 75.0,
                              height: 75.0,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      zodiacs[index].name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(zodiacs[index].date),
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(
                                      zodiacs[index].description,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.3)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.arrow_circle_right_outlined,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // _navigateAndDisplayAddForm(context);
          },
          child: Icon(Icons.add),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'HOME',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'SETTING'),
          ],
          currentIndex: _selectedindex,
          onTap: _changeSelectedNavBar,
        ));
  }

  @override
  void dispose() {}

  Future<List<Zodiac>> fetchZodiac() async {
    final response =
        await http.get(Uri.parse('http://localhost/flutteruas/lib/get.php'));

    final decoded = jsonDecode(response.body);
    final List<Zodiac> zodiacs = [];
    for (final z in decoded) {
      zodiacs.add(Zodiac.fromJson(z));
    }
    return zodiacs;
  }
}
