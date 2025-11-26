// ignore_for_file: deprecated_member_use, library_private_types_in_public_api, unused_import, unnecessary_string_interpolations, use_build_context_synchronously

import 'dart:ui';
import 'package:MovieList/model/GET.dart';
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
  late String movieRelease;
  late String? movieImage;
  late String? userId;
  bool _argsInitialized = false;
  bool isExpanded = false;
  late SupabaseClient supabase;
  List<Genre> genres = [];

  @override 
  void initState() {
    super.initState();

    supabase = Supabase.instance.client;
    getData();
  }
  // Ophalen van info film via route argumenten
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

        final rawRelease = args['releaseDate'];
        if (rawRelease is DateTime) {
          movieRelease = rawRelease.toIso8601String().split('T').first;
        } else if (rawRelease != null && rawRelease.toString().trim().isNotEmpty) {
          movieRelease = rawRelease.toString();
        } else {
          movieRelease = 'Unknown';
        }
      });

      userId = supabase.auth.currentUser?.id;
      checkWatchlist(movieId);
      RemoteActorService().getActor(movieId).then((actors) {
        setState(() {
          actorMovies = actors;
        });
      });

      RemoteGenreService().getGenres(movieId).then((genreList) {
        setState(() {
          genres = genreList;
        });
      });

      _argsInitialized = true;
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

  // Check of hij in watchlist staat
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
                    Row(
                      children: [
                        Text('$movieRelease  ', style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey[500])), 
                        Text('·', style: TextStyle(fontSize: 40, color: Colors.grey[500], fontWeight: FontWeight.bold)),
                        Text(genres.map((g) => g.name).join(', '), style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey[500]),),
                      ]
                    ),
                    GestureDetector(
                       onTap: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                      child: Text(
                          movieOverview,
                          maxLines: isExpanded ? null : 4,
                          overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 15,
                          ),
                        ),
                      )                    ,
                    const SizedBox(height: 20),
                    // Kleur afhankelijk van in watchlist of niet
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
                    // Acteurs horizontale lijst
                    const Text('Cast', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                    SizedBox(   
                      height: 250,
                      child: actorMovies == null
                        ? const Center(child: CircularProgressIndicator())
                        :ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: actorMovies?.cast.length,
                        itemBuilder:(context, index) {
                          final castmember = actorMovies!.cast[index];
                          return Padding(
                            padding: const EdgeInsets.only(left: 4.5, right: 4.5),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column (
                              children: [
                                ClipRRect(borderRadius: BorderRadiusGeometry.circular(10), child: 
                                SizedBox(height: 200, child: Image.network( castmember.profilePath != null 
                                  ? 'https://image.tmdb.org/t/p/w500${castmember.profilePath}'
                                  : 'https://www.content.numetro.co.za/ui_images/no_poster.png',
                                  fit: BoxFit.cover,
                                  height: 140,
                                  width: 200,))
                                  ), 
                                  Text(castmember.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white), overflow: TextOverflow.ellipsis),
                                  Text(castmember.character!, style: const TextStyle(fontSize: 10, color: Colors.white), overflow: TextOverflow.ellipsis),
                              ]
                              )
                            ),
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