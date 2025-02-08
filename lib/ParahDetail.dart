import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;
import 'package:just_audio/just_audio.dart';

class ParahDetail extends StatefulWidget {
  final int parahNumber;

  const ParahDetail(this.parahNumber, {super.key});

  @override
  State<ParahDetail> createState() => _ParahDetailState();
}

class _ParahDetailState extends State<ParahDetail> {
  final AudioPlayer audioPlayer = AudioPlayer();
  final ScrollController _scrollController = ScrollController();
  IconData playPauseButton = Icons.play_circle_fill_rounded;
  bool isPlaying = false;
  int currentVerseIndex = 0;
  List<Map<String, dynamic>> juzVerses = [];
  bool isAudioPlaying = false;

  @override
  void initState() {
    super.initState();
    juzVerses = getJuzVerses(widget.parahNumber);
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  /// Scrolls to the currently playing verse
  void scrollToCurrentVerse() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        currentVerseIndex * 60.0, // Adjust based on list item height
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  /// Play a specific verse
  Future<void> playVerse(int verseIndex) async {
    if (juzVerses.isEmpty || isAudioPlaying || verseIndex >= juzVerses.length) return;

    try {
      isAudioPlaying = true;
      final verse = juzVerses[verseIndex];
      final audioUrl =
          await quran.getAudioURLByVerse(verse['surah'], verse['verse']);

      await audioPlayer.setUrl(audioUrl);
      await audioPlayer.play();

      setState(() {
        currentVerseIndex = verseIndex;
        playPauseButton = Icons.pause_circle_rounded;
        isPlaying = true;
      });

      scrollToCurrentVerse(); // Auto-scroll to the playing verse

      // Wait for playback to complete before playing next
      audioPlayer.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          isAudioPlaying = false;
          playNextVerse();
        }
      });

    } catch (e) {
      print("Error playing verse: $e");
      isAudioPlaying = false;
    }
  }

  /// Play the next verse in sequence
  void playNextVerse() {
    if (currentVerseIndex < juzVerses.length - 1) {
      playVerse(currentVerseIndex + 1);
    } else {
      setState(() {
        playPauseButton = Icons.play_circle_fill_rounded;
        isPlaying = false;
      });
    }
  }

  /// Toggle audio playback
  void toggleAudio() {
    if (isPlaying) {
      audioPlayer.pause();
      setState(() {
        playPauseButton = Icons.play_circle_fill_rounded;
        isPlaying = false;
      });
    } else {
      playVerse(currentVerseIndex);
    }
  }

  /// Get all verses from a specific Juz (Parah)
  List<Map<String, dynamic>> getJuzVerses(int juzNumber) {
    List<Map<String, dynamic>> verses = [];

    for (int surah = 1; surah <= 114; surah++) {
      int totalVerses = quran.getVerseCount(surah);

      for (int verse = 1; verse <= totalVerses; verse++) {
        if (quran.getJuzNumber(surah, verse) == juzNumber) {
          verses.add({
            'surah': surah,
            'verse': verse,
            'text': quran.getVerse(surah, verse),
          });
        }
      }
    }
    return verses;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "پارہ ${widget.parahNumber}",
          style: TextStyle(fontFamily: 'mushaf', color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.brown[900],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController, // Attach scroll controller
              itemCount: juzVerses.length,
              itemBuilder: (context, index) {
                final verse = juzVerses[index];
                return ListTile(
                  title: Text(
                    verse['text'],
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'mushaf', fontSize: 20),
                  ),
                  subtitle: Text(
                    "(${verse['surah']} : ${verse['verse']})",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.grey),
                  ),
                  tileColor: index == currentVerseIndex
                      ? Colors.brown[300]
                      : Colors.transparent,
                );
              },
            ),
          ),
          Card(
            elevation: 6,
            shadowColor: Colors.brown[900],
            child: Center(
              child: IconButton(
                icon: Icon(playPauseButton, color: Colors.brown[900], size: 50),
                onPressed: toggleAudio,
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
