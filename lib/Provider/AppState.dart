import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todoprovider_dart/Post.dart';

class AppState extends ChangeNotifier {
  List _list = [];
  bool _error = false;
  String _errormessage = '';

  //get api calling =================================================================get api calling.
  Future<void> get fetchdata async {
    final response =
        await http.get(Uri.parse("https://etodoapi.herokuapp.com/task/"));
    // print(response);
    if (response.statusCode == 200) {
      _list = jsonDecode(response.body);
    } else {
      _error = true;
      _errormessage = "Error : maybe your internet is bad";
      _list = [];
    }
    notifyListeners();
  }

  //Post api calling ================================================================= Post api calling.
  postdata(String title, String description) async {
    var response = await http.post(
        Uri.parse("https://etodoapi.herokuapp.com/task/"),
        body: {"title": title, "description": description});
    if (response.statusCode == 201) {
      print(response.body);
      String responseString = response.body;
      Post.fromJson(jsonDecode(responseString));
      // print(responseString);
    } else {
      print("exception");
      throw Exception("failed to get an exception");
    }
    notifyListeners();
  }

  //update api calling =================================================================update api calling.
  updatedata(int id, String title, String description) async {
    var response = await http.put(
        Uri.parse("https://etodoapi.herokuapp.com/task/$id/"),
        body: {"title": title, "description": description});
    if (response.statusCode == 200) {
      print(response.body);
      String responseString = response.body;
      Post.fromJson(jsonDecode(responseString));
    } else {
      throw Exception("failed to get an exception");
    }
    notifyListeners();
  }

  //delete api calling =================================================================delete api calling.
  deletedata(int id, String title, String description) async {
    var response = await http.delete(
        Uri.parse("https://etodoapi.herokuapp.com/task/$id/"),
        body: {"title": title, "description": description});
    if (response.statusCode == 204) {
      print(response.body);
      String responseString = response.body;
      Post.fromJson(jsonDecode(responseString));
    } else {
      print("hello");
      throw Exception("failed to get an exception");
    }
    notifyListeners();
  }

  //patch api calling ================================================================= patch api calling.
  patchdata(int id, String title, String description) async {
    var response = await http.patch(
        Uri.parse("https://etodoapi.herokuapp.com/task/$id/"),
        body: {"title": title, "description": description});
    if (response.statusCode == 200) {
      print(response.body);
      String responseString = response.body;
      Post.fromJson(jsonDecode(responseString));
      // print(responseString);
    } else {
      throw Exception("failed to get an exception");
    }
    notifyListeners();
  }

  void addInput(input) {
    _list.add(input);
    notifyListeners();
  }

  List get list => _list;

  bool get error => _error;

  String get errormessage => _errormessage;
}
