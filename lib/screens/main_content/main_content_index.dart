import 'package:flutter/material.dart';

// styles | screen
import 'package:app/screens/main_content/styles/screenStyles.dart';

// screens
import 'package:app/screens/videos_listing/videos_listing_index.dart';

class MainContentScreen extends StatefulWidget {
  const MainContentScreen({Key? key}) : super(key: key);

  @override
  State<MainContentScreen> createState() => _MainContentScreenState();
}

class _MainContentScreenState extends State<MainContentScreen> {
  int currentIndex = 0;
  final List<Widget> screens= [
    const VideosListingScreen(),
    const VideosListingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        unselectedLabelStyle: labelStylesUnselected,
        selectedLabelStyle: labelStylesSelected,
        iconSize: 20,
        unselectedItemColor: Colors.black38,
        selectedItemColor: Colors.black,
        
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home)
          ),

          BottomNavigationBarItem(
            label: "Downloads",
            icon: Icon(Icons.download)
          ),
        ],
      ),
    );
  }
}
