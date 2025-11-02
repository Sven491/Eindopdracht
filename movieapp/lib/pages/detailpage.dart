// ignore_for_file: deprecated_member_use, library_private_types_in_public_api, unused_import, unnecessary_string_interpolations, use_build_context_synchronously

import 'dart:ui';
import 'package:MovieList/model/GET.dart';
import 'package:MovieList/model/GET_watchlist.dart';
import 'package:MovieList/services/remote_service.dart';
import 'package:amicons/amicons.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:MovieList/model/GET_actor.dart';


class Detailpage extends StatefulWidget {
  const Detailpage({super.key});
  @override
  _DetailPageState createState() => _DetailPageState();
  
}

class _DetailPageState extends State<Detailpage> {
  TmdbDiscover? discoverMovies;
  Tmdbactor? actorMovies;
  var isLoaded = false;
  bool isInWatchlist = false;
  late String movieTitle;
  late int movieId;
  late String movieOverview;
  late String? movieImage;
  late String? userId;
  bool _argsInitialized = false;
  late SupabaseClient supabase;

  @override 
  void initState() {
    super.initState();

    supabase = Supabase.instance.client;
    getData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_argsInitialized) {
      final args = ModalRoute.of(context)?.settings.arguments as Map?;
      if (args != null) {
        setState(() {
          movieTitle = args['title'] ?? '';
          movieId = args['id'] ?? 0;
          movieOverview = args['overview'] ?? '';
          movieImage = args['posterPath'] as String?;
        });
        userId = supabase.auth.currentUser?.id;
        checkWatchlist(movieId);
          RemoteActorService().getActor(movieId).then((actors) {
            setState(() {
              actorMovies = actors;
            });
      _argsInitialized = true;
      });

    }
  }
  }

  getData() async{
    final tmdbData = await RemoteDiscoveryService().getDiscovery();
    if(tmdbData != null){
      setState(() {
        discoverMovies = tmdbData;
        isLoaded = true;
      });
    }
  }


  Future<bool> checkWatchlist(int movieId, {bool updateState = true}) async {
    final supabase = Supabase.instance.client;
    final userId = supabase.auth.currentUser?.id;
  if (userId == null)  return false;

  final result = await supabase
      .from('watchlist')
      .select()
      .eq('user_id', userId)
      .eq('movie_id', movieId)
      .maybeSingle();

  final exists = result != null;

  if (updateState) {
    setState(() {
      isInWatchlist = exists;
    });
  }

  return exists;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
       appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [ Stack(
          children: [
            SizedBox(
              child:  Image.network( (movieImage != null)
              ? 'https://image.tmdb.org/t/p/w500$movieImage'
              : 'https://www.content.numetro.co.za/ui_images/no_poster.png', fit: BoxFit.cover,)    
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(color: Colors.black.withOpacity(0.3)),
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black87,
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                  (movieImage != null)
                  ? ('https://image.tmdb.org/t/p/w500$movieImage')
                  : ('https://www.content.numetro.co.za/ui_images/no_poster.png'),
                  fit:BoxFit.cover,
                  height: 400,),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 500),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$movieTitle',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '$movieOverview',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 15,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 20),
                    IconButton(
                      icon: Icon(
                      Amicons.flaticon_heart_rounded_fill
                        , color: isInWatchlist ? Colors.red : Colors.white
                      ),
                        onPressed: () async {
                          final existinwatchlist = await checkWatchlist(movieId);
                          setState(() => isInWatchlist = !isInWatchlist);
                          if (existinwatchlist) {
                            await supabase
                              .from('watchlist')
                              .delete()
                              .eq('user_id', userId!)
                              .eq('movie_id', movieId);
                            
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('Removed from Watchlist'),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 1),
                            ));
                          } else {
                            await supabase
                              .from('watchlist')
                              .insert({'user_id': userId, 'movie_id': movieId});
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('Added to Watchlist'),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 1),

                            ));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow[700],
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(   
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: actorMovies?.cast.length,
                        itemBuilder:(context, index) {
                          final castmember = actorMovies!.cast[index];
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column (
                            children: [
                              ClipRRect(borderRadius: BorderRadiusGeometry.circular(10), child: 
                              SizedBox(height: 200, child: Image.network( castmember.profilePath != null 
                                ? 'https://image.tmdb.org/t/p/w500${castmember.profilePath!}'
                                : 'https://www.content.numetro.co.za/ui_images/no_poster.png',))
                                ), 
                                Text(castmember.name, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: Colors.white, overflow: TextOverflow.ellipsis,),),
                                Text(castmember.character!, style: const TextStyle(fontSize: 15, color: Colors.white, overflow: TextOverflow.ellipsis,),),
                            ]
                            )
                          );
                        }
                           ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        ]
      ),
    );
  }
}