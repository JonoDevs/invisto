import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Invisto'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
          IconButton(icon: const Icon(Icons.person_outline), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Account Summary Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [Color(0xFF6C63FF), Color(0xFF3F2CAF)],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Account Summary',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.visibility_off, color: Colors.white),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    '€24,632.78',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '+€342.56 (+1.4%)',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Trending Stocks',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 130,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _stockCard(
                    context,
                    'AAPL',
                    'Apple Inc.',
                    '\$187.32',
                    '+1.25 (0.67%)',
                    '32.5M',
                  ),
                  const SizedBox(width: 12),
                  _stockCard(
                    context,
                    'MSFT',
                    'Microsoft Corp.',
                    '\$402.56',
                    '+3.78 (0.95%)',
                    '28.3M',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Market Overview',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _marketCard('S&P 500', '4783.45', '+0.57%'),
                _marketCard('NASDAQ', '16742.39', '+0.83%'),
                _marketCard('DAX', '16918.21', '-0.12%'),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'AI Insights',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _insightCard(Icons.bolt, 'Energy sector rising 3.2% this week'),
            _insightCard(
              Icons.warning_amber_outlined,
              'VIX up 15% — high volatility alert',
            ),
            _insightCard(
              Icons.trending_up,
              'Tech momentum continues post-earnings',
            ),
          ],
        ),
      ),
    );
  }

  static Widget _stockCard(
    BuildContext context,
    String ticker,
    String name,
    String price,
    String change,
    String volume,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/stockDetails',
          arguments: {
            'ticker': ticker,
            'name': name,
            'price': price,
            'change': change,
            'volume': volume,
          },
        );
      },
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.green[50],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(ticker, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(
              name,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const Spacer(),
            const Icon(Icons.show_chart, color: Colors.green),
            Text(price, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(change, style: const TextStyle(color: Colors.green)),
          ],
        ),
      ),
    );
  }

  static Widget _marketCard(String index, String value, String change) {
    final isPositive = !change.contains('-');
    return Container(
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isPositive ? Colors.green[50] : Colors.red[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(index, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(fontSize: 16)),
          Text(
            change,
            style: TextStyle(color: isPositive ? Colors.green : Colors.red),
          ),
        ],
      ),
    );
  }

  static Widget _insightCard(IconData icon, String text) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepPurple),
      title: Text(text),
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
    );
  }
}
