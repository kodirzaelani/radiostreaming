import 'package:flutter/material.dart';
import 'package:radio_player/radio_player.dart';

class StreamRadioPage extends StatefulWidget {
  const StreamRadioPage({super.key});

  @override
  State<StreamRadioPage> createState() => _StreamRadioPageState();
}

class _StreamRadioPageState extends State<StreamRadioPage> {
  final RadioPlayer _radioPlayer = RadioPlayer();
  bool isPlaying = false;
  List<String>? metadata;

  @override
  void initState() {
    super.initState();
    initRadioPlayer();
  }

  void initRadioPlayer() {
    _radioPlayer.setChannel(
      title: 'Radio Player',
      url: 'https://audiostreamserver.indonesiastreaming.com/islamic_center',
      imagePath: "assets/_vradio.png",
    );

    _radioPlayer.stateStream.listen((value) {
      setState(() {
        isPlaying = value;
      });
    });

    _radioPlayer.metadataStream.listen((value) {
      setState(() {
        metadata = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: const EdgeInsets.only(top: 150),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Radio Streaming',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }

    Widget content() {
      return Column(
        children: [
          FutureBuilder(
            future: _radioPlayer.getArtworkImage(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              Image artwork;
              if (snapshot.hasData) {
                artwork = snapshot.data;
              } else {
                artwork = Image.asset(
                  "assets/_vradio.png",
                  fit: BoxFit.cover,
                );
              }
              return SizedBox(
                height: 180,
                width: 250,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: artwork,
                ),
              );
            },
          ),
        ],
      );
    }

    Widget buttonRadioPlay() {
      return Container(
        margin: const EdgeInsets.only(bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                isPlaying ? _radioPlayer.pause() : _radioPlayer.play();
              },
              child: Icon(
                isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
              ),
            ),
          ],
        ),
      );
    }

    Widget footer() {
      return Container(
        margin: const EdgeInsets.only(bottom: 30),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Version 1.0',
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        // menonaktfikan tombol back
        automaticallyImplyLeading: false,
        title: const Text(
          'Radio Islamic Center Kaltim',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            header(),
            const SizedBox(
              height: 40,
            ),
            content(),
            buttonRadioPlay(),
            const Spacer(),
            footer(),
          ],
        ),
      ),
    );
  }
}
