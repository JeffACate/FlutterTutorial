import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // final wordPair = WordPair.random();
    return const MaterialApp(
      title: 'Welcome to Flutter',
      home: RandomWords(),
      // home: Scaffold(
      //   appBar: AppBar(
      //     centerTitle: true,
      //     title: const Text('Welcome to Flutter'),
      //   ),
      //   body: const Center(
      //     // child: Text('Hello, the new word is: ${wordPair.asPascalCase}.'),
      //     child: RandomWords(),
      //   ),
      // ),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _wordList = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    // final wordPair = WordPair.random();
    // return Text('Hello, the new word is: ${wordPair.asPascalCase}');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Random Name Generator'),
      ),
      body: _buildWordList(),
    );
  }

  Widget _buildWordList() {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemBuilder: (BuildContext _context, int i) {
          if (i.isOdd) {
            return const Divider();
          }

          final int index = i ~/ 2;

          if (index >= _wordList.length) {
            _wordList.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_wordList[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }
}
