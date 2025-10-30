// ignore_for_file: avoid_unnecessary_containers, unused_import, unused_local_variable

import 'package:flutter/material.dart';
import 'package:MovieList/model/GET.dart';
import 'package:MovieList/services/remote_service.dart';
import 'package:amicons/amicons.dart';

class Searchpage extends StatefulWidget {
  const Searchpage({super.key});
  
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<Searchpage> {
  TmdbDiscover? discoverMovies;
  var isLoaded = false;

    @override 
  void initState() {
    super.initState();

    getData();
  }

  getData() async{
    discoverMovies =  await RemoteDiscoveryService().getDiscovery();
    if(discoverMovies != null){
      setState(() {
        isLoaded = true;
      });
    }
  }
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
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF737373)),),
            filled: true,
            fillColor: Color(0xFF2E2E2E),
          ),
          onSubmitted: (String query) {
           GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 30.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 0.6
            ),
            itemCount: discoverMovies?.results.length,
            itemBuilder: (context, index) {
              final movie = discoverMovies!.results[index];
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[200],
                ),
                child: Column (
                )
              );
          },
        );
      }
      ),
      )
    );
  }
}
