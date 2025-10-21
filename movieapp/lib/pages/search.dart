// ignore_for_file: avoid_unnecessary_containers, unused_import

import 'package:flutter/material.dart';
import 'package:MovieList/model/GET.dart';
import 'package:MovieList/services/remote_service.dart';
import 'package:amicons/amicons.dart';


class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Container(
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search for movies...',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Amicons.iconly_search_fill),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF737373)),
            ),
            filled: true,
            fillColor: Color(0xFF2E2E2E),
          ),
        ),
      ),
    );
  }
}
