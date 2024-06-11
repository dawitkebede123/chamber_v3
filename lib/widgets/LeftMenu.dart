import 'dart:io';

import 'package:chamber_of_commerce/pages/user/Home.dart';
import 'package:chamber_of_commerce/theme/theme_provider.dart';
import 'package:chamber_of_commerce/widgets/AboutUs.dart';
import 'package:chamber_of_commerce/widgets/CountryProfile.dart';
import 'package:chamber_of_commerce/widgets/CustomBottomNavBar.dart';
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
  @override
  Widget build(BuildContext context) {
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
              MaterialPageRoute(builder: (context) =>Home() ),

            ),
            }
          ),
      
        // padding: const EdgeInsets.all(16.0), // Add padding on all sides
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50.0), // Set border radius
    ),
       
        title:Text(
          'Addis Chamber',
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
          
      ElevatedButton(
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
    backgroundColor: Colors.blue, // Set the background color
    textStyle: const TextStyle(color: Colors.white), // Adjust text color for contrast
  ),
  child:  Text('About Chamber', style: TextStyle(color:Theme.of(context).colorScheme.primary),),
),


          
          //    TextButton(onPressed:()=>{
          // Navigator.push(
          //       context,
          //        TransparentRoute(
               
          //       page: CountryProfile(),
          //     ),
          //     ),
          //   },child: Text("Country Profile")),
           
                      ElevatedButton(

  onPressed: () => openFile(
    url:'https://drive.google.com/file/d/1eMkNLTld-geUWg1DkvAS2qYGhBHn6lMI/view',
    fileName:'countryprofile.pdf',

  ),
   style: ElevatedButton.styleFrom(
    backgroundColor: Colors.blue, // Set the background color
    textStyle: const TextStyle(color: Colors.white), // Adjust text color for contrast
  ),
  child:  Text('Country Profile', style: TextStyle(color:Theme.of(context).colorScheme.primary),),
),
           
           
            TextButton(onPressed:()=>{
            Provider.of<ThemeProvider>(context,listen: false).toggleTheme(),
            },child: const Row(
              children: [
                Spacer(),
                Icon(Icons.dark_mode),
              ],
            )),
      ],
    ),  
    // 
    );
  }

 Future<File?> downloadFile({required String url,String? name})async{
 final appStorage = await getApplicationDocumentsDirectory();
      final file = File('${appStorage.path}/$name');

      final response = await Dio().get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: 0,
        )
      );


  final raf = file.openSync(mode: FileMode.write);
  raf.writeFromSync(response.data);
  await raf.close();
  return file;

 }


  Future openFile({required String url,String? fileName})async{
    final file = await downloadFile(url: url,name: fileName);
    if(file == null) return;
    print('Path:${file.path}');
    OpenFile.open(file.path);
  }
}