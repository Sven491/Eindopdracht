import 'package:MovieList/model/GET_discover.dart';
import 'package:MovieList/services/remote_service.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Homepage> {
  TmdbDiscover? discoverMovies;
  var isLoaded = false;

    @override 
  void initState() {
    super.initState();

    getData();
  }

  getData() async{
    discoverMovies =  await RemoteService().getDiscovery();
    if(discoverMovies != null){
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover'),
      ),
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.builder(
            itemCount: discoverMovies?.results.length,
            itemBuilder: (context, index) {
              final movie = discoverMovies!.results[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Text(
                  movie.title,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
      ),
        );
      }
  }