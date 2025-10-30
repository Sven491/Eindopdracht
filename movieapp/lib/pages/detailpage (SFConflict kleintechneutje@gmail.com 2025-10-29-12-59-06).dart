// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:MovieList/model/GET.dart';
import 'package:MovieList/services/remote_service.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:amicons/amicons.dart';

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

    final int movieId = args['id'];
    final String movieTitle = args['title'];
    final String movieImage = args['posterPath'];
    final String movieDescription = args['description'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Page'),
      ),
      body: Column(
        children: [
          Center ( child:
          Text('$movieTitle', style: const TextStyle(fontSize: 40, color: Colors.white)),
          ),
          Row (
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network('https://image.tmdb.org/t/p/w500$movieImage', height: 400,),
              const SizedBox(width: 20,),
              Container(
                width: 200,
                child: Text('$movieDescription', style: const TextStyle(fontSize: 20, color: Colors.white),),
              ),
            ],
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {}, 
                child: Text('Add to watchlist', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red,),
                ),
              GButton(icon: Amicons.flaticon_share_rounded_fill, 
                text: 'Share', 
                onPressed: () {},
                ),
            ],
          ),
        ],
      ),
    );
  }
}