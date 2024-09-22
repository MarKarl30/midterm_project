import 'package:flutter/material.dart';
import 'package:midterm_project/widgets/card.dart';
import 'package:midterm_project/widgets/search_bar.dart';

class ToursTopUpScreen extends StatefulWidget {
  const ToursTopUpScreen({super.key});

  @override
  _ToursTopUpScreenState createState() => _ToursTopUpScreenState();
}

class _ToursTopUpScreenState extends State<ToursTopUpScreen> {
  List<Map<String, dynamic>> tours = [
    {'name': 'Dufan Ancol', 'imagePath': 'assets/icons/tours/dufan.png'},
    {'name': 'Kidzania', 'imagePath': 'assets/icons/tours/kidzania.png'},
    {
      'name': 'Orchid Forest',
      'imagePath': 'assets/icons/tours/orchid.png',
      'isAvailable': false
    },
    {
      'name': 'Wahoo',
      'imagePath': 'assets/icons/tours/wahoo.png',
      'isAvailable': false
    },
  ];

  List<Map<String, dynamic>> filteredTours = [];

  @override
  void initState() {
    super.initState();
    filteredTours = tours; // Initially show all platforms
  }

  void _searchTours(String query) {
    setState(() {
      filteredTours = tours.where((tour) {
        final nameLower = tour['name'].toLowerCase();
        final searchLower = query.toLowerCase();
        return nameLower.contains(searchLower);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        backgroundColor: const Color.fromARGB(183, 16, 16, 16),
        title: const Text("Beli Tiket Wisata",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 17,
            )),
      ),
      backgroundColor: const Color.fromARGB(243, 0, 0, 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const SizedBox(height: 20),
            SearchItem(onSearch: _searchTours), // Add search bar
            const SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 5,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: filteredTours.map((tour) {
                return ItemCard(
                  name: tour['name'],
                  imagePath: tour['imagePath'],
                  isAvailable: tour['isAvailable'] ?? true,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}