import 'package:chamber_of_commerce/pages/user/Company%20_business.dart';
import 'package:chamber_of_commerce/pages/user/Company.dart';
import 'package:chamber_of_commerce/widgets/CompanyDescription.dart';
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
  List<Map<dynamic, dynamic>> uniqueBusinesses = [];
   List<dynamic> data = [];
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
       data = snapshot.snapshot.value as List<dynamic>;
      //  print(snapshot.snapshot.value);
      //  print(data);
       data = data.where((element) => element["Is_adv"]=="True").toList();
      // Define a map for filtering logic by index
      filteredBusinesses = data;

      print(widget.index);
      if(widget.index == 0){
     filteredBusinesses = data
     .expand((element) {
    // ... filtering logic using entry.value as Map<String, dynamic>
    final companyName = element['Sector']?.toString().toLowerCase() ?? '';
    return companyName.startsWith("export") ? [element] : [];
  })
  .toList();
  // print(filteredBusinesses);

  }
  if(widget.index == 5){
     filteredBusinesses = data.expand((element) {
    // ... filtering logic using entry.value as Map<String, dynamic>
    final companyName = element['Sector']?.toString().toLowerCase() ?? '';
    return companyName.startsWith("agriculture") ? [element] : [];
  }).toList();

  }
  if(widget.index == 2){
     filteredBusinesses = data.expand((element) {
    // ... filtering logic using entry.value as Map<String, dynamic>
    final companyName = element['Sector']?.toString().toLowerCase() ?? '';
    return companyName.startsWith("manufacturing") ? [element] : [];
  }).toList();

  }
  if(widget.index == 3){
     filteredBusinesses = data.expand((element) {
    // ... filtering logic using entry.value as Map<String, dynamic>
    final companyName = element['Sector']?.toString().toLowerCase() ?? '';
    return companyName.startsWith("construction") ? [element] : [];
  }).toList();

  }
  if(widget.index == 4){
     filteredBusinesses = data.expand((element) {
    // ... filtering logic using entry.value as Map<String, dynamic>
    final companyName = element['Sector']?.toString().toLowerCase() ?? '';
    return companyName.startsWith("transport") ? [element] : [];
  }).toList();

  }
  if(widget.index == 1){
     filteredBusinesses = data.expand((element) {
    // ... filtering logic using entry.value as Map<String, dynamic>
    final companyName = element['Sector']?.toString().toLowerCase() ?? '';
    return companyName.startsWith("import") ? [element] : [];
  }).toList();

  }
  if(widget.index == 6){
     filteredBusinesses = data.expand((element) {
    // ... filtering logic using entry.value as Map<String, dynamic>
    final companyName = element['Sector']?.toString().toLowerCase() ?? '';
    return companyName.startsWith("financial inter") ? [element] : [];
  }).toList();

  }
  if(widget.index == 7){
     filteredBusinesses = data.expand((element) {
    // ... filtering logic using entry.value as Map<String, dynamic>
    final companyName = element['Sector']?.toString().toLowerCase() ?? '';
    return companyName.startsWith("community") ? [element] : [];
  }).toList();

  }
  if(widget.index == 8){
     filteredBusinesses = data.expand((element) {
    // ... filtering logic using entry.value as Map<String, dynamic>
    final companyName = element['Sector']?.toString().toLowerCase() ?? '';
    return companyName.startsWith("electric") ? [element] : [];
  }).toList();

  }
  if(widget.index == 9){
     filteredBusinesses = data.expand((element) {
    // ... filtering logic using entry.value as Map<String, dynamic>
    final companyName = element['Sector']?.toString().toLowerCase() ?? '';
    return companyName.startsWith("hotel") ? [element] : [];
  }).toList();

  }
  if(widget.index == 10){
     filteredBusinesses = data.expand((element) {
    // ... filtering logic using entry.value as Map<String, dynamic>
    final companyName = element['Sector']?.toString().toLowerCase() ?? '';
    return companyName.startsWith("wholesale") ? [element] : [];
  }).toList();

  }
  if(widget.index == 11){
     filteredBusinesses = data.expand((element) {
    // ... filtering logic using entry.value as Map<String, dynamic>
    final companyName = element['Sector']?.toString().toLowerCase() ?? '';
    return companyName.startsWith("maintennance") ? [element] : [];
  }).toList();

  }
  if(widget.index == 12){
     filteredBusinesses = data.expand((element) {
    // ... filtering logic using entry.value as Map<String, dynamic>
    final companyName = element['Sector']?.toString().toLowerCase() ?? '';
    return companyName.startsWith("mining") ? [element] : [];
  }).toList();

  }
  if(widget.index == 13){
     filteredBusinesses = data.expand((element) {
    // ... filtering logic using entry.value as Map<String, dynamic>
    final companyName = element['Sector']?.toString().toLowerCase() ?? '';
  
    return companyName.startsWith("real estate") ? [element] : [];
  }).toList();

  }


   //avoiding duplicated adv from the list based on Account Name column
    // Set<dynamic> uniqueBusinesses = filteredBusinesses.toSet();
  //  filteredBusinesses = uniqueBusinesses.toList();

Set<String> seenKeys = {}; // Set to store unique combinations of relevant keys

for (final element in filteredBusinesses) {
  // Define the key(s) to compare for uniqueness (e.g., "name" and "age")
  final keyCombination = "${element["Account Name"]}"; 

  if (!seenKeys.contains(keyCombination)) {
    seenKeys.add(keyCombination);
    uniqueBusinesses.add(element);
  }
}
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
      height: 300,
      child: ListView.builder(
        itemCount: uniqueBusinesses.length,
        itemBuilder: (context, index) {
          final Map<dynamic, dynamic> businessData = uniqueBusinesses[index];
          final String icon = businessData['logo'].toString();
          Future<String> imageUrlFuture = storeImageInFirebase(icon);
          final String name = businessData["Account Name"].toString();
      
          return Container(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CompanyDescription(detail: businessData)),
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
      final images = storage.child('logo');
      final imageRef = images.child(fileName);

      final networkImageUrl = await imageRef.getDownloadURL();
      // print(networkImageUrl);
      return networkImageUrl;
    } on FirebaseException catch (e) {
      // Handle potential errors
      print('Error storing image: ${e.code} - ${e.message}');
      return ''; // Or throw an exception for further handling
    }
  }
}

