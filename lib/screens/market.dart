import 'package:flutter/material.dart';

class MarketScreen extends StatefulWidget {
  @override
  _MarketScreenState createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  String selectedCategory = 'All';
  String selectedTimeRange = '1D';
  bool isListView = true;

  final List<String> categories = ['All', 'US', 'Europe', 'Asia', 'Crypto'];
  final List<String> timeRanges = ['1D', '1W', '1M', '3M', '1Y', '5Y'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Market Overview')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Category filters
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children:
                    categories.map((cat) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: ChoiceChip(
                          label: Text(cat),
                          selected: selectedCategory == cat,
                          onSelected:
                              (_) => setState(() => selectedCategory = cat),
                        ),
                      );
                    }).toList(),
              ),
            ),
            const SizedBox(height: 16),

            // Highlight card
            _highlightCard(),

            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _indexCard('S&P 500', '4783.45', '+0.57%'),
                _indexCard('NASDAQ', '16742.39', '+0.83%'),
                _indexCard('DAX', '16918.21', '-0.12%'),
              ],
            ),
            const SizedBox(height: 16),

            // Toggle view
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Stocks',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(isListView ? Icons.grid_view : Icons.list),
                  onPressed: () => setState(() => isListView = !isListView),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(child: isListView ? _stockListView() : _stockGridView()),
          ],
        ),
      ),
    );
  }

  Widget _highlightCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.deepPurple[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'AAPL - Apple Inc.',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Text(
            '\$187.32  +1.25 (0.67%)',
            style: TextStyle(color: Colors.green),
          ),
          const SizedBox(height: 12),
          Container(
            height: 100,
            color: Colors.deepPurple[100],
            alignment: Alignment.center,
            child: const Text('Line chart here'),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:
                timeRanges.map((range) {
                  return ChoiceChip(
                    label: Text(range),
                    selected: selectedTimeRange == range,
                    onSelected:
                        (_) => setState(() => selectedTimeRange = range),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _indexCard(String name, String value, String change) {
    final isPositive = !change.contains('-');
    return Container(
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isPositive ? Colors.green[50] : Colors.red[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
          Text(
            change,
            style: TextStyle(color: isPositive ? Colors.green : Colors.red),
          ),
        ],
      ),
    );
  }

  Widget _stockListView() {
    final stocks = _getMockStocks();
    return ListView.separated(
      itemCount: stocks.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (_, index) {
        final stock = stocks[index];
        return ListTile(
          title: Text('${stock['ticker']} - ${stock['name']}'),
          subtitle: Text('Volume: ${stock['volume']}'),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                stock['price']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                stock['change']!,
                style: TextStyle(
                  color:
                      stock['change']!.contains('-')
                          ? Colors.red
                          : Colors.green,
                ),
              ),
            ],
          ),
          onTap: () {
            Navigator.pushNamed(context, '/stockDetails', arguments: stock);
          },
        );
      },
    );
  }

  Widget _stockGridView() {
    final stocks = _getMockStocks();
    return GridView.builder(
      itemCount: stocks.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 100,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (_, index) {
        final stock = stocks[index];
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/stockDetails', arguments: stock);
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stock['ticker']!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(stock['name']!, style: const TextStyle(fontSize: 12)),
                const Spacer(),
                Text(
                  stock['price']!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  stock['change']!,
                  style: TextStyle(
                    color:
                        stock['change']!.contains('-')
                            ? Colors.red
                            : Colors.green,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Map<String, String>> _getMockStocks() {
    return [
      {
        'ticker': 'AAPL',
        'name': 'Apple Inc.',
        'price': '\$187.32',
        'change': '+1.25 (0.67%)',
        'volume': '32.5M',
      },
      {
        'ticker': 'MSFT',
        'name': 'Microsoft Corp.',
        'price': '\$402.56',
        'change': '+3.78 (0.95%)',
        'volume': '28.3M',
      },
      {
        'ticker': 'TSLA',
        'name': 'Tesla Inc.',
        'price': '\$612.43',
        'change': '-4.22 (-0.68%)',
        'volume': '45.7M',
      },
    ];
  }
}
