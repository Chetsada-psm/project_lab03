import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int total = 0;
  final List<Item> items = [
    Item(title: "iPad", price: 19000),
    Item(title: "iPad mini", price: 23000),
    Item(title: "iPad Air", price: 29000),
    Item(title: "iPad Pro", price: 32000),
  ];

  void incrementNumber(Item item, int delta) {
    setState(() {
      total += delta;
    });
  }

  void resetAll() {
    setState(() {
      total = 0;
      for (var item in items) {
        item.resetCount();
      }
    });
  }

  String formatCurrency(int amount) {
    return amount.toString().replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }

  @override
  Widget build(BuildContext context) {
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
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ShoppingItem(
                    item: item,
                    onIncrement: (item, delta) {
                      incrementNumber(item, delta);
                    },
                  );
                },
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
}

class Item {
  final String title;
  final int price;
  int count = 0;

  Item({required this.title, required this.price});

  void resetCount() {
    count = 0;
  }
}

class ShoppingItem extends StatefulWidget {
  final Item item;
  final Function(Item item, int delta) onIncrement;

  ShoppingItem({
    required this.item,
    required this.onIncrement,
  });

  @override
  State<ShoppingItem> createState() => _ShoppingItemState();
}

class _ShoppingItemState extends State<ShoppingItem> {
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
                widget.item.title,
                style: const TextStyle(fontSize: 28),
              ),
              Text("${widget.item.price.toString()} ฿"),
            ],
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                if (widget.item.count > 0) {
                  setState(() {
                    widget.item.count--;
                  });
                  widget.onIncrement(widget.item, -widget.item.price);
                }
              },
              icon: const Icon(Icons.remove),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              widget.item.count.toString(),
              style: const TextStyle(fontSize: 28),
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  widget.item.count++;
                });
                widget.onIncrement(widget.item, widget.item.price);
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }
}
