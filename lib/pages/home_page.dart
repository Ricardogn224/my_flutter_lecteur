import 'package:flutter/material.dart';
import 'package:my_flutter_lecteur/components/my_drawer.dart';
import 'package:my_flutter_lecteur/models/playlist_provider.dart';
import 'package:my_flutter_lecteur/pages/song_page.dart';
import 'package:provider/provider.dart';

import '../models/song.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // get the playlist provider

  late final PlaylistProvider playlistProvider;

  @override
  void initState() {
    super.initState();

    // get the playlist provider
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
  }

  // go to song

  void goTosSong(int songIndex) {
    // update current song index
    playlistProvider.currentSongIndex = songIndex;

    //navigate to song page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SongPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(title: const Text('P L A Y L I S T')),
      drawer: const MyDrawer(),
      body: Consumer<PlaylistProvider>(
        builder: (context, value, child) {
          // get the playlist
          final List<Song> playlist = value.playlist;

          // return the list view UI
          return ListView.builder(
              itemCount: playlist.length,
              itemBuilder: (context, index) {
                // get individual song
                final Song song = playlist[index];

                // return list tile UI
                return ListTile(
                  title: Text(song.songName),
                  subtitle: Text(song.artistName),
                  leading: Image.asset(song.albumArtImagePath),
                  onTap: () => goTosSong(index),
                );
              }); // ListView.builder
        }, // builder
      ),
    );
  }
}
