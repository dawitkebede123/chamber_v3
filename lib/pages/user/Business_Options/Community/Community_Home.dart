import 'package:carousel_slider/carousel_slider.dart';
import 'package:chamber_of_commerce/pages/user/Business.dart';
import 'package:chamber_of_commerce/pages/user/Business_Options/Agriculture/Agriculture_Listing.dart';
import 'package:chamber_of_commerce/pages/user/Business_Options/Community/Community_Listing.dart';
import 'package:chamber_of_commerce/pages/user/Business_Options/Export/Export_Listing.dart';
import 'package:chamber_of_commerce/pages/user/Business_listing.dart';
import 'package:chamber_of_commerce/pages/user/Home.dart';
import 'package:chamber_of_commerce/widgets/BottomNavBar.dart';
import 'package:chamber_of_commerce/widgets/CustomBottomNavBar.dart';
import 'package:chamber_of_commerce/widgets/GridScreen.dart';
import 'package:chamber_of_commerce/widgets/GridScreenForBusiness.dart';
import 'package:chamber_of_commerce/widgets/GridSingle.dart';
import 'package:chamber_of_commerce/widgets/SearchField.dart';
import 'package:chamber_of_commerce/widgets/SearchFieldBusiness.dart';
import 'package:chamber_of_commerce/widgets/business_top_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class Community_Home extends StatefulWidget {
  const Community_Home({super.key});
  @override
  State<Community_Home> createState() => _Community_HomeState();
}

class _Community_HomeState extends State<Community_Home> {
  String _query = '';
   List <String> title = [
  'ACTIVITIES OF PROFESSIONAL ORGANIZATIONS',
  'ACTIVITIES OF SPORTS,BODY ENRICHMENT SPORTS AND OTHER ENTERTAINTMENT AND RELATED ACTIVITIES',
  'ARTS FESTIVAL( MUSIC,FILM, THEATRE,GALLERY AND OTHER)',
  'ARTS STUDIO',
  'BEAUTY TREATMENT/BATH AND MASSAGE',
  'BOOKS AND STATIONARY MATERIALS',
  'BROAD CAST EQUIPMENTS TELEVISION AND RADIO RECEIVERS, SOUND OR VIDEO RECORDING OR REPRODUCING APPARATUS AND ASSOCIATED GOODS',
  'BUSINESS AND MANAGEMENT CONSULTANCY ACTIVITIES',
  'CHILD DAY CARE SERVICE',
  'CHILDREN CLOTHING',
  'CINEMA HALL',
  'CLINICS AND RELATED HEALTH CARE SERVICES',
  'COMMISSION/BROKERS BUSINESS ACTIVITIES',
  'CONSULTANCY ACTIVITY ON ADVERTISING',
  'CONSULTANCY SERVICE FOR ECONOMIC DEVELOPMENT',
  'CUSTOMS CLEARANCE',
  'DECORATING ACTIVITIES',
  'DIFFERENT EVENTS DECORATING ACTIVITIES',
  'DIAGNOSTIC LABORATORY',
  'DRIVING EDUCATION',
  'DRIVING EDUCATION BOTH IN REGULAR AND BY SPECIAL MACHINERIES',
  'EDUCATION BY TECHNICAL COLLEGES AND TECHNICAL INSTITUTIONS',
  'EDUCATION BY TECHNIQUES AND TRANING',
  'EDUCATION RELATED SERVICES',
  'FILM PRODUCTION',
  'FILM PRODUCTION, CINEMA HAL, FILM STUDIO AND FILM CAPTURING',
  'FUNERAL AND RELATED ACTIVITIES',
  'GENERAL HOSPITAL',
  'GRAIN MILL SERVICE',
  'HISTORIC CITES AND BUILDINGS FOR RECREATION AND CARE SERVICES',
  'INTERNET CAFÉ',
  'LABORATORY TESTING SERVICE',
  'LADIES HAIR DRESSING SERVICE',
  'LAUNDRY SERVICE',
  'LOAD AND UNLOAD SERVICE',
  'MANAGEMENT CONSULTANCY SERVICES',
  'MEDIA CONSULTANCY SERVICE',
  'MEDIA ENTERTAINMENT PRODUCTION AND DISTRIBUTION',
  'MEDIA PROGRAM PREPARATION BY AIR TIME RENT',
  'Men hairdressing service',
  'MENS AND LADIES HAIRDRESSING',
  'MOTION PICTURE, THEATRE AND VIDEO PRODUCTION AND DISTRIBUTION',
  'MUSIC AND BAND ACTIVITIES',
  'NEWS AGENCY ACTIVITIES',
  'NEWSPAPERS, JOURNALS AND PERIODICALS DISTRIBUTER',
  'NURSING SERVICES',
  'OTHER MEDICAL AND HEALTH SERVICES',
  'PARKING SERVICE',
  'PICTURE, SCULPTURE,GALLERY/ STUDIO SERVICE',
  'PLAY OF MUSICAL INSTRUMENTS (DJ)',
  'PRINTING',
  'PRINTING AND RELATED ACTIVITIES',
  'QUALITY MANAGEMENT SYSTEM CONSULTANCY',
  'RESTAURANTS',
  'RETAIL TRADE OF FOOT WEAR, LEATHER AND RELATED PRODUCTS',
  'SANITARYWARE AND COSMETICS',
  'SECURITY AND CLEANING SERVICE',
  'SEWAGE AND REFUSE DISPOSAL SANITATION AND SIMILAR ACTIVITIES',
  'SERVICE OF PRIMARY AND SECONDARY EDUCATION',
  'SERVICE OF PRE-PRIMARY EDUCATION AND AFTER SCHOOL',
  'SERVICE OF REGULAR HIGHER EDUCATION',
  'SHORT TERM TCHNICAL EDUCATION AND TRAINING',
  'SPINNING, WEAVING AND FINISHING OF TEXTILES',
  'SPORTING AND RECREATIONAL ACTIVITIES',
  'SPRAYING OF PESTICIDES FOR HOUSHOLD PURPOSES',
  'STUDIO RECORDING SERVICE',
  'SUPPLEMENTARY HEALTH SERVICES OR PARAMEDICAL STAFF',
  'TAILORING',
  'TOPOGRAPHIC BEAUTY',
  'TRANSLATION & SECRETARIAL SERVICES',
  'TRAINING SERVICE INFORMATION AND COMMUNICATION TECHNOLOGY',
  'TRADITIONAL MEDICAL SERVICE',
  'Unknown',]; // Untranslated string remains unchanged
  // '' // Empty string remains unchanged
 final slideImages = [
   "assets/images/business_lists/adv_logo/1.jpg",
   "assets/images/business_lists/adv_logo/2.jpg",
   "assets/images/business_lists/adv_logo/3.jpg",
   "assets/images/business_lists/adv_logo/4.jpg",
   "assets/images/business_lists/adv_logo/5.jpg",
   "assets/images/business_lists/adv_logo/7.jpg",
   "assets/images/business_lists/adv_logo/8.jpg",
   "assets/images/business_lists/adv_logo/9.jpg",
   "assets/images/business_lists/adv_logo/10.jpg",
   "assets/images/business_lists/adv_logo/11.jpg",
     "assets/images/business_lists/adv_logo/12.jpg",
     "assets/images/business_lists/adv_logo/13.jpg",
     "assets/images/business_lists/adv_logo/14.jpg",
     "assets/images/business_lists/adv_logo/15.jpg",
     "assets/images/business_lists/adv_logo/16.jpg",
     "assets/images/business_lists/adv_logo/17.jpg",
     "assets/images/business_lists/adv_logo/18.jpg",
     "assets/images/business_lists/adv_logo/19.jpg",
     "assets/images/business_lists/adv_logo/20.jpg",
     "assets/images/business_lists/adv_logo/21.jpg",
     "assets/images/business_lists/adv_logo/22.jpg",
     "assets/images/business_lists/adv_logo/23.jpg",
     "assets/images/business_lists/adv_logo/24.jpg",
     "assets/images/business_lists/adv_logo/25.jpg",
     "assets/images/business_lists/adv_logo/26.jpg",
     "assets/images/business_lists/adv_logo/27.jpg",
     "assets/images/business_lists/adv_logo/28.jpg",
     "assets/images/business_lists/adv_logo/29.jpg",
     "assets/images/business_lists/adv_logo/30.jpg",
     "assets/images/business_lists/adv_logo/31.jpg",
     "assets/images/business_lists/adv_logo/32.jpg",
     "assets/images/business_lists/adv_logo/33.jpg",
     "assets/images/business_lists/adv_logo/34.jpg",
     "assets/images/business_lists/adv_logo/35.jpg",
     "assets/images/business_lists/adv_logo/36.jpg",
     "assets/images/business_lists/adv_logo/37.jpg",
     "assets/images/business_lists/adv_logo/38.jpg",
     "assets/images/business_lists/adv_logo/39.jpg",
     "assets/images/business_lists/adv_logo/40.jpg",
     "assets/images/business_lists/adv_logo/41.jpg",
     "assets/images/business_lists/adv_logo/42.jpg",
     "assets/images/business_lists/adv_logo/43.jpg",
  ];
   final _searchController = TextEditingController();
  String _searchTerm = '';
  Stream<DatabaseEvent>? _userStream;

  @override
  void initState() {
    super.initState();
    try {
    _userStream = FirebaseDatabase.instance.ref('Query7').onValue;
  } on FirebaseException catch (e) {
    print('Firebase error: ${e.code} - ${e.message}');
    // Handle the error appropriately, potentially display a user-friendly message
  }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchCompany(String searchTerm) {
    setState(() {
      _searchTerm = searchTerm.toLowerCase();
    });
  }
  @override
  
  Widget build(BuildContext context) {
  
  //    [
  //      "assets/images/business_lists/5.svg",
  // ];
  

        title.sort((a,b)=>a.compareTo(b));
    List <String> categories = List .generate(title.length, (index) => 
    "assets/images/business_lists/3.svg"
    );

  final List<Map<String, String>> businessCompanyProfile = [
 
   
   ];
     var scaffold = Scaffold(
      //  drawer:const BackButton(
      //   //  backgroundColor: Colors.white,
      //  ),
      
       





   

     appBar: 
     
     AppBar(
        backgroundColor:Colors.white,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed:()=>{
           Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>Business() ),

            ),
            }
          ),
      
        // padding: const EdgeInsets.all(16.0), // Add padding on all sides
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50.0), // Set border radius
    ),
       
        title:const Text(
          'Community',
          style: TextStyle(
           color: Colors.black,
           fontWeight: FontWeight.bold,
           fontSize: 18,
          ),
        ),
       //should be replace by botton
         actions: [
          Padding(padding: EdgeInsets.only(right: 20),
         child:  SvgPicture.asset('assets/images/chamber_icon.svg')
          ,),
         
    ],
        elevation: 0.0,//remove shadow
        centerTitle: true,
      ),
      body:  
              
    
            // SvgPicture.asset('assets/images/Adv_slider.svg'),
            // Slider(value: value, onChanged: onChanged),
           NestedScrollView(
            headerSliverBuilder:(context, innerChildOverscrollIndicator)=> [
           const SliverAppBar(
            automaticallyImplyLeading: false,
            collapsedHeight: 300,
            expandedHeight: 300,
            flexibleSpace: Padding(
              padding: EdgeInsets.only(left: 20.0,right: 20,bottom: 16),
              child: Business_Top_List(index: 7),
            ),
          )
      ],
             body: Column(
              children: [
                
             
             
             Padding(
              padding: const EdgeInsets.only(left: 20.0,right: 20,bottom: 16),
              child:TextField(
             onChanged: (value) {
                                          setState(() {
                                            _query = value.toLowerCase();
                                          });},
        maxLines: 1,
        // controller: _searchController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 20.0),
          filled: true,
          fillColor: Color.fromARGB(255, 229, 234, 232),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none,
          ),
          // contentPadding: EdgeInsets.all(1),
          hintText: 'Search Business',
          // suffixIcon: widget.filter? _buildSuffixIcon():null,
        ),
      ),
            ),
             
                //  const Padding(
                //         padding: EdgeInsets.only(left: 20.0,right: 20,bottom: 16),
                //         child: SearchFieldBusiness(),
                //       ),
                 Expanded(
                   child: Padding(
                     padding: const EdgeInsets.only(left: 20.0,right: 20,bottom: 16),
                     child: GridView.builder(
                             itemCount: _filteredItems.length,
                             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                               crossAxisCount: 3, // Number of columns
                               crossAxisSpacing: 20.0, // Spacing between columns
                               mainAxisSpacing: 10.0, 
                               childAspectRatio: 120/160 // Spacing between rows
                             ),
                             itemBuilder: (context, index) {
                              //  final item = _filteredItems[index];
                               return GestureDetector(
                                 child: Column(
                                   children: [
                                     Container(
                                      decoration: BoxDecoration(
                                                   color:Color.fromARGB(255, 229, 234, 232) ,
                                                   border: Border.all(
                                                     color: Colors.white,
                                                     width: 1.0,
                                                   ),
                                                   borderRadius: BorderRadius.circular(20.0),
                                                 ),
                                      height: 94,
                                      width: 94,
                                       child: Center(
                                         child:SvgPicture.asset(categories[index])
                                       ),
                                     ),
                                     Text(_filteredItems[index],
                                      style: TextStyle(fontSize: 12,),
                                      textAlign: TextAlign.center,
                                     maxLines: 2,
                    overflow: TextOverflow.ellipsis,)
                                   ],
                                 ),
                              
                              onTap: () {
                                                       
                                    
                                          Navigator.push(
                                    context,
                                    TransparentRoute(
                        page:  Community_listing(index: index,title:title[index],businessCompanyProfile: businessCompanyProfile),
                              ),
                                  );
                                     }                 
                               
                                                        
                                 
                               );
                             },
                           ),
                   ),
             
             
             
             
                 ),
              
             
             
             
               ]
             ),
           ), 
           // Define scrollable grid
          
                                
  
         
       
          bottomNavigationBar:const CustomeButtomNavBar(index: 2,),


     
    );
    return scaffold;
  }
List<String> get _filteredItems => title
      .where((item) => item.toLowerCase().contains(_query))
      .toList();
 Widget buildImage(String urlImage,int index)=>
          Container(
                 margin: EdgeInsets.symmetric(horizontal:5),
                 child:Image.asset(urlImage,fit: BoxFit.cover,),
          ); 
}