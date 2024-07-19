import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int total = 0;

  void incrementNumber(int count, int price) {
    setState(() {
      total += price;
    });
  }

  void resetAll() {
    setState(() {
      total = 0;
    });
    for (var key in _shoppingItemKeys) {
      key.currentState?.resetCount();
    }
  }

  final List<GlobalKey<_ShoppingItemState>> _shoppingItemKeys = [];

  String formatCurrency(int amount) {
    return amount.toString().replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }

  @override
  Widget build(BuildContext context) {
    _shoppingItemKeys.clear();  // Clear the list before adding new keys

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Shopping Cart"),
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
        ),
        body: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  ShoppingItem(
                    key: _addNewKey(),
                    title: "iPad",
                    price: 19000,
                    onIncrement: (int count, int price) {
                      incrementNumber(count, price);
                    },
                  ),
                  ShoppingItem(
                    key: _addNewKey(),
                    title: "iPad mini",
                    price: 23000,
                    onIncrement: (int count, int price) {
                      incrementNumber(count, price);
                    },
                  ),ShoppingItem(
                    key: _addNewKey(),
                    title: "iPad Air",
                    price: 29000,
                    onIncrement: (int count, int price) {
                      incrementNumber(count, price);
                    },
                  ),ShoppingItem(
                    key: _addNewKey(),
                    title: "iPad Pro",
                    price: 32000,
                    onIncrement: (int count, int price) {
                      incrementNumber(count, price);
                    },
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "Total",
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  "${formatCurrency(total)} ฿",
                  style: const TextStyle(fontSize: 30),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: resetAll,
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.deepOrange,
                  ),
                  child: const Text("Clear"),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  GlobalKey<_ShoppingItemState> _addNewKey() {
    final key = GlobalKey<_ShoppingItemState>();
    _shoppingItemKeys.add(key);
    return key;
  }
}

class ShoppingItem extends StatefulWidget {
  final String title;
  final int price;
  final Function(int count, int price) onIncrement;

  ShoppingItem({
    required Key key,
    required this.title,
    required this.price,
    required this.onIncrement,
  }) : super(key: key);

  @override
  State<ShoppingItem> createState() => _ShoppingItemState();
}

class _ShoppingItemState extends State<ShoppingItem> {
  int count = 0;

  void resetCount() {
    setState(() {
      count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: const TextStyle(fontSize: 28),
              ),
              Text("${widget.price.toString()} ฿"),
            ],
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                if (count > 0) {
                  setState(() {
                    count--;
                  });
                  widget.onIncrement(count, -widget.price);
                }
              },
              icon: const Icon(Icons.remove),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              count.toString(),
              style: const TextStyle(fontSize: 28),
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  count++;
                });
                widget.onIncrement(count, widget.price);
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }
}
