import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    title: "Belajar Form Flutter",
    home: create(),
  ));
}

class create extends StatefulWidget {
  @override
  State<create> createState() => _create();
}

class _create extends State<create> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController image = TextEditingController();
  String get imageadd => image.text;

  TextEditingController name = TextEditingController();
  String get nameadd => name.text;

  TextEditingController date = TextEditingController();
  String get dateadd => date.text;

  TextEditingController description = TextEditingController();
  String get descriptonadd => description.text;

  Future postData() async {
    try {
      final post = await http.post(
          Uri.parse("http://localhost/flutteruas/lib/insert.php"),
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
          body: {"name": nameadd, "date": dateadd, "desc": descriptonadd});
      if (post.statusCode == 200) {
        print("status : ${post.body}");
      }
    } catch (error) {
      return error.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BelajarFlutter.com"),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              // TextField(),
              TextFormField(
                controller: name,
                decoration: new InputDecoration(
                  hintText: "contoh: Scorpio",
                  labelText: "Nama",
                  icon: Icon(Icons.people),
                  border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5.0)),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.blue),
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    postData();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
