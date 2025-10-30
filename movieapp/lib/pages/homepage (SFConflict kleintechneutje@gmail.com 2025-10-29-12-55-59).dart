// ignore_for_file: library_private_types_in_public_api

import 'package:MovieList/model/GET.dart';
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
      appBar: AppBar(
        title: const Text('Discover'),
      ),
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: GridView.builder(
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
                children: [
                  InkWell( 
                    onTap: () {Navigator.pushNamed(context, '/detail', 
                      arguments: {
                        'id': movie.id,
                        'title': movie.title,
                        'posterPath': movie.posterPath,
                        'description': movie.overview
                        });}, 
                    splashColor: Colors.white10, 
                    child: ClipRRect(borderRadius: BorderRadiusGeometry.circular(6), child: Image.network('https://image.tmdb.org/t/p/w500${movie.posterPath}'))), 
                    Text( movie.title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis, ),
                ]
                )
              );
            },
          ),
      ),
        );
      }
  }