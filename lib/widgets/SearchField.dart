import 'dart:async';
// import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:chamber_of_commerce/pages/user/Company_detail.dart';
import 'package:chamber_of_commerce/widgets/SearchMoreIcon.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchField extends StatefulWidget {
  //  final bool filter;
  const SearchField({Key? key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final TextEditingController _searchController = TextEditingController();
  Stream<List<dynamic>>? _searchResultsStream;
  bool _showListView = false;
  final _history = <String>[]; // List to store search history
  final _maxHistoryLength = 10; 
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    _searchController.addListener(_onSearchChanged);
    _loadSearchHistory();
  }

  void _onSearchChanged() {
    if (_searchController.text.isEmpty) {
      setState(() {
        _searchResultsStream = null;
        _showListView = false;
      });
    } else {
      setState(() {
        final searchText = _searchController.text.toUpperCase();
        _searchResultsStream = FirebaseDatabase.instance
            .ref('Query8')
            
            .orderByChild('Account Name')
             .startAt(searchText)
            .endAt(searchText + '\uffff')
            // .startAt(_searchController.text.toUpperCase())
            // .endAt(_searchController.text.toLowerCase() + '\uffff')
            .limitToFirst(1)
            .onValue
            .asBroadcastStream()
            .map((event) => _mapSnapshotToCompanyList(event.snapshot));
        _showListView = true;
      });
    }
  }

void _updateSearchHistory(String term) async {
    _history.remove(term); // Remove duplicate entries
    _history.insert(0, term); // Add term to the beginning of the list
    _history.takeWhile((t) => t.isNotEmpty); // Remove empty entries
    _history.sublist(0, 5); // Limit history length

    await _saveSearchHistory();
  }

  Future<void> _loadSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList('search_history') ?? [];
    setState(() {
      _history.addAll(history);
    });
  }

  Future<void> _saveSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('search_history', _history);
  }

  List<dynamic> _mapSnapshotToCompanyList(DataSnapshot snapshot) {
    // Handle both Map and List data structures
    if (snapshot.value is Map) {
      final Map<dynamic, dynamic> entries = Map.from(snapshot.value as Map);
      final List<dynamic> companies = [];
      entries.forEach((key, value) {
        companies.add(value);
      });
      return companies;
    } else if (snapshot.value is List) {
      return snapshot.value as List<dynamic>; // Assuming each item in the list represents a company
    } else {
      print('Unexpected data type received: ${snapshot.value}');
      return []; // Empty list if unexpected data type
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _saveSearchHistory();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         if (_history.isNotEmpty) _buildSearchHistory(),
        
        _buildSearchTextField(),
     
        if (_showListView) _buildSearchResults(),
      ],
    );
  }

  // ... remaining widget build methods (unchanged)

Widget _buildSearchHistory() {
    return ListView.builder(
      shrinkWrap: true, // Avoid unnecessary scrolling
      itemCount: _history.length,
      itemBuilder: (context, index) {
        final term = _history[index];
        return ListTile(
          title: Text(term),
          onTap: () {
            _searchController.text = term;
            _onSearchChanged(); // Trigger search on tap
          },
        );
        });
        }

  Widget _buildSearchTextField() {
    return  Container(
      height: 48,
      child: TextField(
        maxLines: 1,
        controller: _searchController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 20.0),
          filled: true,
          fillColor: Color.fromARGB(255, 229, 234, 232),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none,
          ),
          // contentPadding: EdgeInsets.all(1),
          hintText: 'Search companies...',
          suffixIcon: _buildSuffixIcon()
        ),
      ),
    );
  }

  Widget _buildSuffixIcon() {
    return Container(
      width: 200,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(Icons.search),
          SearchFieldMoreIcon(),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return StreamBuilder<List<dynamic>>(
      stream: _searchResultsStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
          print(snapshot.data);
        return Container(
          height: 200.0,
          child: _buildListView(snapshot.data ?? []),
        );
      },
    );
  }

  Widget _buildListView(List<dynamic> companies) {
    if (companies.isEmpty) {
      return Center(child: Text('No companies found.'));
    }
    return ListView.builder(
      itemCount: companies.length,
      itemBuilder: (context, index) {
        final company = companies[index];
        final name = company['Account Name'];
        return ListTile(
          title: Text(name),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CompanyDetail(data: company),
              ),
            );
          },
        );
      },
    );
  }
}
