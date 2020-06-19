import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
// title section widget from Material app

    return MaterialApp(
      title: 'First Page',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
// home: FirstRoute());
      initialRoute: '/',
      routes: {
        '/': (context) => FirstRoute(), //initial page
// '/second': (context) => SecondRoute(), // navigated page
        SecondRoute.routeName: (context) => SecondRoute(),
      },
    );
  }
}

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
/*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
/*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Oeschinen Lake Campground',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Kandersteg, Switzerland',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          FavoriteWidget(),
        ],
      ),
    );
    Color color = Theme.of(context).primaryColor;

// button section widget from Material app START
    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(color, Icons.call, 'CALL'),
          _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
          _buildButtonColumn(color, Icons.share, 'SHARE'),
        ],
      ),
    );
// button section widget from Material app END

// text section widget from Material app START
    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese'
        'Alps. Situated 1,578 meters above sea level, it is one of the'
        'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a'
        'half-hour walk through pastures and pine forest, leads you to the'
        'lake, which warms to 20 degrees Celsius in the summer. Activities'
        'enjoyed here include rowing, and riding the summer toboggan run.',
        softWrap: true,
      ),
    );
// text section widget from Material app END
    Widget navButton = Container(
      padding: const EdgeInsets.all(32),
      child: RaisedButton(
        child: Text('Open Second Page'),
        onPressed: () {
          Navigator.pushNamed(
            context,
// MaterialPageRoute(builder: (context) => SecondRoute()),
            SecondRoute.routeName,
            arguments:
                NavigationArgs('Second Page', 'This is the passed message'),
          );
        },
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: ListView(
        children: [
          Image.asset('images/lake.jpeg',
              width: 600, height: 240, fit: BoxFit.cover),
          titleSection,
          buttonSection,
          textSection,
          navButton
        ],
      ),
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

class SecondRoute extends StatelessWidget {
  static const routeName = '/extractArguments';
  @override
  Widget build(BuildContext context) {
    final NavigationArgs args = ModalRoute.of(context).settings.arguments;
    debugPrint('args:$args');
    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
      ),
      body: ListView(children: [
        Center(
          child: RaisedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Go back!'),
          ),
        ),
        Center(
          child: Text(args.message),
        ),
      ]),
    );
  }
}

class FavoriteWidget extends StatefulWidget {
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = true;
  int _favoriteCount = 41;
// ···
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            icon: Icon((_isFavorited ? Icons.star : Icons.star_border)),
            color: Colors.red[500],
            onPressed: _toggleFavorite,
          ),
        ),
        SizedBox(
          width: 18,
          child: Container(
            child: Text('$_favoriteCount'),
          ),
        ),
      ],
    );
  }

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
      }
    });
  }
}

// Navigation arguments
class NavigationArgs {
  final String title;
  final String message;
  NavigationArgs(this.title, this.message);
}
