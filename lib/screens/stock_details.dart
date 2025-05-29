import 'package:flutter/material.dart';

class StockDetailsScreen extends StatelessWidget {
  final String ticker;
  final String name;
  final String price;
  final String change;
  final String volume;

  const StockDetailsScreen({
    Key? key,
    required this.ticker,
    required this.name,
    required this.price,
    required this.change,
    required this.volume,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isPositive = !change.contains('-');

    return Scaffold(
      appBar: AppBar(title: Text(ticker), leading: BackButton()),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Text(
              price,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Text(
              change,
              style: TextStyle(color: isPositive ? Colors.green : Colors.red),
            ),
            const SizedBox(height: 24),

            Container(
              height: 150,
              color: Colors.green[100],
              alignment: Alignment.center,
              child: const Text('Chart goes here'),
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:
                  ['1D', '1W', '1M', '3M', '6M', '1Y', '5Y'].map((label) {
                    return OutlinedButton(onPressed: () {}, child: Text(label));
                  }).toList(),
            ),
            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _statCard('Open', '\$186.07'),
                _statCard('High', '\$188.45'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _statCard('Low', '\$185.92'),
                _statCard('Volume', volume),
              ],
            ),
            const SizedBox(height: 24),

            const Text(
              'Key Statistics',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _statCard('Market Cap', '2.94T'),
                _statCard('P/E Ratio', '31.2'),
                _statCard('Dividend', '\$0.92'),
                _statCard('Dividend Yield', '0.49%'),
                _statCard('52-Week High', '\$198.23'),
                _statCard('52-Week Low', '\$124.17'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget _statCard(String label, String value) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
