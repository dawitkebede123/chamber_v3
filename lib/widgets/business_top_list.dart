import 'package:chamber_of_commerce/pages/user/Company%20_business.dart';
import 'package:chamber_of_commerce/pages/user/Company.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Business_Top_List extends StatefulWidget {
  final int index;

  const Business_Top_List({super.key, required this.index});

  @override
  State<Business_Top_List> createState() => _Business_Top_ListState();
}

class _Business_Top_ListState extends State<Business_Top_List> {
  List<dynamic> filteredBusinesses = [];
  bool isLoading = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = '';
      });

      // Replace with your actual data fetching logic (using Firebase or other source)
      final ref = FirebaseDatabase.instance.ref('Query8').once();
      final snapshot = await ref;
      final data = snapshot.snapshot.value as List<dynamic>;

      // Define a map for filtering logic by index
      final filters = {
        0: (element) => element['Sector']?.toString().toLowerCase() ?? ''
            .startsWith("export"),
        1: (element) => element['sector']?.toString().toLowerCase() ?? ''
            .startsWith("import"),
        2: (element) => element['sector']?.toString().toLowerCase() ?? ''
            .startsWith("manufacturing"),
        // ... Add logic for other indexes
        13: (element) => element['sector']?.toString().toLowerCase() ?? ''
            .startsWith("real estate"),
      };

      // Apply filter based on widget.index
      filteredBusinesses = data.expand((element) {
        final filterFunction = filters[widget.index];
        if (filterFunction != null) {
          // ignore: unnecessary_type_check
          return filteredBusinesses is Iterable
              ? filteredBusinesses
              : [filteredBusinesses]; // Wrap if not Iterable
        } else {
          print('empty');
          return []; // Handle case where filter returns null
        }
      }).toList();

      setState(() {
        isLoading = false;
      });
    } on FirebaseException catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error: ${e.message}';
      });
      print('Error fetching data: ${e.code} - ${e.message}');
    } catch (e) {
      // Handle other potential errors
      setState(() {
        isLoading = false;
        errorMessage = 'An error occurred.';
      });
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              const CircularProgressIndicator(),
            if (errorMessage.isNotEmpty)
              Text(errorMessage),
            if (!isLoading && errorMessage.isEmpty)
              _buildListView(),
          ],
        ),
      ),
    );
  }

  Widget _buildListView() {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        itemCount: filteredBusinesses.length,
        itemBuilder: (context, index) {
          final businessData = filteredBusinesses[index];
          final String icon = businessData["logo"].toString();
          Future<String> imageUrlFuture = storeImageInFirebase(icon);
          final String name = businessData["Account Name"].toString();
      
          return Container(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CompanyBusiness(detail: businessData)),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: Row(
                  children: [
                    Container(
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black
                    // ... decoration for the container
                        ),
                      ),
                      child: FutureBuilder<String>(
                        future: imageUrlFuture,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Image.network(snapshot.data!);
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
      
                          // Display a loading indicator while waiting
                          return CircularProgressIndicator();
                        },
                      ),),
                    // ),
                    SizedBox(width: 20.0),
                    Expanded(
                      child: Text(
                        name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<String> storeImageInFirebase(String fileName) async {
    try {
      final storage = FirebaseStorage.instance.ref();
      final images = storage.child('media');
      final imageRef = images.child(fileName);

      final networkImageUrl = await imageRef.getDownloadURL();
      print(networkImageUrl);
      return networkImageUrl;
    } on FirebaseException catch (e) {
      // Handle potential errors
      print('Error storing image: ${e.code} - ${e.message}');
      return ''; // Or throw an exception for further handling
    }
  }
}


