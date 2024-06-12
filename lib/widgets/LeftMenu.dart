import 'dart:io';

import 'package:chamber_of_commerce/pages/user/Home.dart';
import 'package:chamber_of_commerce/theme/theme_provider.dart';
import 'package:chamber_of_commerce/widgets/AboutUs.dart';
import 'package:chamber_of_commerce/widgets/CountryProfile.dart';
import 'package:chamber_of_commerce/widgets/CustomBottomNavBar.dart';
import 'package:chamber_of_commerce/widgets/expandedPanel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class LeftMenu extends StatefulWidget {
  const LeftMenu({super.key});

  @override
  State<LeftMenu> createState() => _LeftMenuState();
}

class _LeftMenuState extends State<LeftMenu> {
    bool _isSwitched = false;

  @override
  Widget build(BuildContext context) {
  final List<Map<String,dynamic>> contact =[
       {
      "title":"For Business Related Enquiry",
    "content": "0115519817 \n 0911376543 \n addischamber@gmail.com"


     },
   
    {
      "title":"For Financial Almanac Related Enquiry",
    "content": "   +251 11 515 5221 \n +251 91 196 4500 \n  +251 93 155 9829 \n flijalem@yahoo.com \n lemlem.aaccsa@gmail.com"
    },
    

  ];

    return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
             appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.background,
              leading: IconButton(
          color: Theme.of(context).colorScheme.primary,
          icon: const Icon(Icons.arrow_back),
          onPressed:()=>{
         Navigator.push(
              context,
              TransparentRoute(
               
                page:  Home(),
              ),
            ),
            }
          ),
      
        // padding: const EdgeInsets.all(16.0), // Add padding on all sides
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50.0), // Set border radius
    ),
       
        title:Text(
          'Menu',
          style: TextStyle(
           color: Theme.of(context).colorScheme.primary,
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

      
             body:  Column(
    
      children: [
        // TextButton(onPressed:()=>{
        //   Navigator.push(
        //         context,
        //          TransparentRoute(
               
        //         page: About(),
        //       ),
        //       ),
        //     },child: Text("About Chamber")),
          
      Padding(
        padding: const EdgeInsets.only(left: 50.0),
        child: ElevatedButton(
          onPressed: () {
            // Handle button press event here
            Navigator.push(
                  context,
                   TransparentRoute(
                 
                    page: About()              
                  
                  // , image: "assets/sg.jpg")
                ),
                );
          },
           style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 0, 114, 63), // Set the background color
            textStyle: const TextStyle(color: Colors.white), // Adjust text color for contrast
          ),
          child:  Text('About Chamber', style: TextStyle(color:Colors.white),),
        ),
      ),


          
          //    TextButton(onPressed:()=>{
          // Navigator.push(
          //       context,
          //        TransparentRoute(
               
          //       page: CountryProfile(),
          //     ),
          //     ),
          //   },child: Text("Country Profile")),
           
                      Padding(
                        padding: const EdgeInsets.only(left: 50.0),
                        child: ElevatedButton(
                        
                          onPressed: ()=>{
                            Navigator.push(
                                        context,
                                         TransparentRoute(
                                       
                                        page: const CountryProfile(),
                                      ),
                                      ),
                          } ,
                          
                          // => openFile(
                          //   url:'https://drive.google.com/file/d/1eMkNLTld-geUWg1DkvAS2qYGhBHn6lMI/view',
                          //   fileName:'countryprofile.pdf',
                        
                          // ),
                           style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 0, 114, 63), // Set the background color
                            textStyle: const TextStyle(color: Colors.white), // Adjust text color for contrast
                          ),
                          child:  const Text('Country Profile', style: TextStyle(color:Colors.white),),
                        ),
                      ),
           
  //     Switch(
  //      value:_isSwitched , // Boolean value representing the current state (on/off)
  // onChanged: (value) => setState(() { _isSwitched = !_isSwitched;
  //  Provider.of<ThemeProvider>(context,listen: false).toggleTheme();}
  // ), // Function to update the state
  // activeColor: Theme.of(context).colorScheme.primary, // Color for the active (on) state
  // inactiveThumbColor: Theme.of(context).colorScheme.background, // Color for the inactive (off) thumb
  // inactiveTrackColor: Theme.of(context).colorScheme.primary, // Color for the inactive track

  //       ),  
            // SizedBox(width: ,)   
            
            Padding(
              padding: const EdgeInsets.only(left: 300.0),
              child: TextButton(onPressed:()=>{
              Provider.of<ThemeProvider>(context,listen: false).toggleTheme(),
              },child: 
                Container(
                    decoration: BoxDecoration(
                      color:Colors.grey,
                      borderRadius:BorderRadius.circular(999) ,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.dark_mode),
                    )),
                
              ),
            ),

             Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    height: 300,
                    child: ExpandedPanel(data: contact)),
                ),
              ],
            ),
      ],
    ),  
    // 
    );
  }

//  Future<File?> downloadFile({required String url,String? name}) async{
//  final appStorage = await getApplicationDocumentsDirectory();
//       final file = File('${appStorage.path}/$name');
//       try{
// final response = await Dio().get(
//         url,
//         options: Options(
//           responseType: ResponseType.bytes,
//           followRedirects: false,
//           receiveTimeout: 0,
//         ),
//       );


//   final raf = file.openSync(mode: FileMode.write);
//   raf.writeFromSync(response.data);
//   await raf.close();
//   return file;
//       }
//       catch(e){
//         return null;
//       }
      

//  }


//   Future openFile({required String url,String? fileName})async{
//     final file = await downloadFile(url: url,name: fileName);
//     if(file == null) return;
//     print('Path:${file.path}');
//     OpenFile.open(file.path);
//   }
}