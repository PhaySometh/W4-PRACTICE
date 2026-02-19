import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Home()),
    ),
  );
}

// ColorService which extends or implements ChangeNotifier
class ColorService extends ChangeNotifier {
  final Map<CardType, int> _tapCounts = {
    for (var type in CardType.values) type: 0,
  };

  int getCount(CardType type) => _tapCounts[type] ?? 0;

  void increment(CardType type) {
    _tapCounts[type] = (_tapCounts[type] ?? 0) + 1;
    notifyListeners();
  }

  Map<CardType, int> get allCounts => _tapCounts;
}

enum CardType { red, blue, green, yellow }

// instantiate color service globally
final ColorService colorService = ColorService();

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 0
          ? ColorTapsScreen()
          : StatisticsScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.tap_and_play),
            label: 'Taps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistics',
          ),
        ],
      ),
    );
  }
}

class ColorTapsScreen extends StatelessWidget {
  const ColorTapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Color Taps')),
      body: ListenableBuilder(
        listenable: colorService, 
        builder: (context, child) {
          return Column(
            children: CardType.values.map((type) {
              return ColorTap(type: type);
            }).toList(),
          );
        })
    );
  }
}

class ColorTap extends StatelessWidget {
  final CardType type;

  const ColorTap({super.key, required this.type});

  Color get backgroundColor {
    switch (type) {
      case CardType.red:
        return Colors.red;
      case CardType.blue:
        return Colors.blue;
      case CardType.yellow:
        return Colors.yellow;
      case CardType.green:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    final tapCount = colorService.getCount(type);


        return GestureDetector(
          onTap: () => colorService.increment(type),
          child: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            width: double.infinity,
            height: 100,
            child: Center(
              child: Text(
                'Taps: $tapCount',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ),
        );
      }
}

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Statistics')),
      body: ListenableBuilder(
        listenable: colorService, 
        builder: (context, child) { 
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: colorService.allCounts.entries.map((entry) {
                return Text(
                  '${entry.key.name} Taps: ${entry.value}',
                  style: const TextStyle(fontSize: 24),
                );
              }).toList(),
            )
          );
        },
      ),
    );
  }
}
