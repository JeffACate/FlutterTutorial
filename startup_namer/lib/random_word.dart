import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _wordList = <WordPair>[];
  final _starred = <WordPair>{};
  final _biggerFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(' Name Generator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: _pushSaved,
            tooltip: 'Starred Suggestions',
          ),
        ],
      ),
      body: _buildWordList(),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      final tiles = _starred.map(
        (pair) {
          return ListTile(
            title: Text(
              pair.asPascalCase,
              style: _biggerFont,
            ),
          );
        },
      );
      final divided = tiles.isNotEmpty
          ? ListTile.divideTiles(context: context, tiles: tiles).toList()
          : <Widget>[];

      return Scaffold(
        appBar: AppBar(
          title: const Text('Starred Suggestions'),
        ),
        body: ListView(children: divided),
      );
    }));
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
    var isStarred = _starred.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: isStarred
                ? const Icon(Icons.star)
                : const Icon(Icons.star_border),
            color: Colors.teal,
            tooltip: isStarred ? 'Remove from starred' : 'Starred',
            onPressed: () {
              setState(() {
                if (isStarred) {
                  _starred.remove(pair);
                  isStarred = false;
                } else {
                  _starred.add(pair);
                  isStarred = true;
                }
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_sharp),
            color: Colors.redAccent,
            tooltip: 'Delete',
            onPressed: () {
              setState(() {
                if (_starred.contains(pair)) {
                  _starred.remove(pair);
                }
                _wordList.remove(pair);
              });
            },
          ),
        ],
      ),
    );
  }
}
