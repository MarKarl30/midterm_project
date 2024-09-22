import 'package:flutter/material.dart';
import 'package:midterm_project/widgets/banner.dart';
import 'package:midterm_project/widgets/card.dart';
import 'package:midterm_project/widgets/search_bar.dart';

class StreamingsTopUpScreen extends StatefulWidget {
  const StreamingsTopUpScreen({super.key});

  @override
  _StreamingsTopUpScreenState createState() => _StreamingsTopUpScreenState();
}

class _StreamingsTopUpScreenState extends State<StreamingsTopUpScreen> {
  List<Map<String, dynamic>> streamings = [
    {'name': 'Netflix', 'imagePath': 'assets/icons/streamings/netflix.png'},
    {'name': 'VIU', 'imagePath': 'assets/icons/streamings/viu.png'},
    {
      'name': 'Prime Video',
      'imagePath': 'assets/icons/streamings/prime.png',
      'isAvailable': false
    },
    {
      'name': 'Disney +',
      'imagePath': 'assets/icons/streamings/disney.png',
      'isAvailable': false
    },
  ];

  List<Map<String, dynamic>> filteredStreamings = [];

  @override
  void initState() {
    super.initState();
    filteredStreamings = streamings; // Initially show all platforms
  }

  void _searchStreamings(String query) {
    setState(() {
      filteredStreamings = streamings.where((streaming) {
        final nameLower = streaming['name'].toLowerCase();
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
        title: const Text("Top Up Platform Streaming",
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
            BannerSlideShow(
              imagePaths: [
                "assets/images/banner/streamings/netflix.png",
                "assets/images/banner/streamings/viu.png",
                "assets/images/banner/streamings/disney.png",
              ],
            ),
            const SizedBox(height: 20),
            SearchItem(onSearch: _searchStreamings), // Add search bar
            const SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 5,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: filteredStreamings.map((streaming) {
                return ItemCard(
                  name: streaming['name'],
                  imagePath: streaming['imagePath'],
                  isAvailable: streaming['isAvailable'] ?? true,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}