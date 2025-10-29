import 'package:amicons/amicons.dart';
import 'package:flutter/material.dart';
import 'package:MovieList/model/GET.dart';
import 'package:MovieList/services/remote_service.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
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
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    final String movieTitle = args['title'];
    final String movieImage = args['posterPath'];
    final String movieOverview = args['overview'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Page'),
      ),
      body: Column(
        children: [
          Center ( child:
          Text('$movieTitle', style: const TextStyle(fontSize: 40, color: Colors.white)),
          ),
          Image.network('https://image.tmdb.org/t/p/w500$movieImage', height: 200,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
              Text('$movieOverview', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
          Row(
            children: [
              TextButton(
                onPressed: () {}, 
                child: Text('Hello', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red,),
                ),
              ElevatedButton(onPressed: () {}, child: Icon( Amicons.iconly_heart_fill, color: Colors.white,),)
            ],
          ),
        ],
      ),
    );
  }
}