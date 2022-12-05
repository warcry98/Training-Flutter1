import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';

class LoggedUser extends StatefulWidget {
  const LoggedUser({super.key});

  @override
  LoggedUserState createState() => LoggedUserState();
}

class LoggedUserState extends State<LoggedUser> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  bool showDate = true;

  List<PlatformFile> files = [];

  @override
  Widget build(BuildContext context) {
    Future<DateTime> _selectDate(BuildContext context) async {
      final selected = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1990),
        lastDate: DateTime(2025),
      );
      if (selected != null && selected != selectedDate) {
        setState(() {
          selectedDate = selected;
        });
      }
      return selectedDate;
    }

    String getDate() {
      return DateFormat('d MMM, yyyy').format(selectedDate);
    }

    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.only(
            top: 50,
            left: 20,
            right: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                  bottom: 12,
                ),
                child: Text(
                  'Create User',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
              textInput(
                'Name',
                'enter name',
                nameController,
              ),
              textInput(
                'Password',
                'enter password',
                passwordController,
              ),
              Row(
                children: [
                  Text('Tanggal Lahir'),
                  Container(
                    margin: EdgeInsets.only(
                      left: 20,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        _selectDate(context);
                      },
                      child: Text(getDate()),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 20,
                  bottom: 30,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () async {
                      final result = await FilePicker.platform.pickFiles();
                      if (result == null) return;
                      files = result.files;
                      setState(() {});
                    },
                    child: Text('Upload Foto'),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Login'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.only(
                      left: 40,
                      right: 40,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textInput(
    inputName,
    hintText,
    controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(inputName),
        Container(
          alignment: Alignment.center,
          height: 40,
          margin: EdgeInsets.only(
            top: 10,
            bottom: 20,
          ),
          child: TextFormField(
            controller: controller,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
                hintText: hintText,
                contentPadding: EdgeInsets.only(
                  left: 12,
                  top: 0,
                  bottom: 0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                )),
          ),
        ),
      ],
    );
  }

  Future<void> createUser() async {
    var formData = FormData.fromMap({
      'namakaryawan': nameController.text,
      'tanggal': '12/12/2022',
      'nid': '6122132W',
      'password': '123456',
      'level': 'User',
      'foto': await MultipartFile.fromFile(
        files[0].path as String,
        contentType: MediaType('image', 'jpg'),
        filename: files[0].path?.split('/').last,
      ),
    });

    var response = await Dio().post(
      'http://nusantarapowerrembang.com/flutter/simpankaryawan.php',
      data: formData,
    );

    // print(response.data);
    Map<String, dynamic> data =
        jsonDecode(response.data) as Map<String, dynamic>;

    print("data: $data");
  }
}
