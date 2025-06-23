import 'package:flutter/material.dart';
import 'screens/login.dart';
import 'screens/home.dart';
import 'screens/market.dart';
import 'screens/signup.dart';
import 'screens/stock_details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Invisto',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/home': (context) => HomeScreen(),
        '/market': (context) => MarketScreen(),
      },
      // For dynamic routing to stock details
      onGenerateRoute: (settings) {
        if (settings.name == '/stockDetails') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder:
                (context) => StockDetailsScreen(
                  ticker: args['ticker'],
                  name: args['name'],
                  price: args['price'],
                  change: args['change'],
                  volume: args['volume'],
                ),
          );
        }
        return null;
      },
    );
  }
}
