import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_github_api/model/github.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GitHub _gitHub;
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    _loadingData();
  }

  _loadingData() async {
    try {
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

      var response = await http.get(
        Uri.http('api.github.com', "users/sFisher611"),
        headers: headers,
      );
      if (response.statusCode < 299) {
        setState(() {
          _gitHub = GitHub.fromJson(jsonDecode(response.body));
        });
      } else {}
    } catch (e) {
      var data = {};
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Github user"),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Text(
                _gitHub.name,
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
            ),
    );
  }
}
