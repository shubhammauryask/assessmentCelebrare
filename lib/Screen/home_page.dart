import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var path;
  var imageFile;
  var imageVisibility = false;
  var imageVisibilityDialogBox = false;

  void pickImageFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      path = image.path;
      imageFile = File(image.path);
      setState(() {
        // imageVisibility = true;
      });
      _cropImage();
    } else {
      // /
    }
  }
  //
  Future<void> _cropImage() async {
    if (imageFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
            presentStyle: CropperPresentStyle.dialog,
            boundary: const CroppieBoundary(
              width: 520,
              height: 520,
            ),
            viewPort:
                const CroppieViewPort(width: 480, height: 480, type: 'circle'),
            enableExif: true,
            enableZoom: true,
            showZoomer: true,
          ),
        ],
      );
      if (croppedFile != null) {
        setState(() {
          path = croppedFile.path;
          imageVisibilityDialogBox = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Icon(
          Icons.keyboard_arrow_left,
          size: 40,
          color: Colors.grey,
        ),
        elevation: 4,
        backgroundColor: Colors.white,
        title: Text(
          'Add Images/Iocn',
          style: GoogleFonts.montserrat(
              fontSize: 21, fontWeight: FontWeight.normal),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, // Specify the border color
                    width: 0.8, // Specify the border width
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Uploading Images',
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                          color: Colors.grey),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.005,
                  ),
                  Center(
                      child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              5), // Set the radius to 0 for a rectangular shape
                        ),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        imageVisibilityDialogBox =false;
                        imageVisibility = false;
                      });
                      pickImageFromGallery();
                    },
                    child: Text(
                      'Choose from Device',
                      style: GoogleFonts.montserrat(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  ))
                ],
              ),
            ),

            // SizedBox(height:MediaQuery.of(context).size.height*0.08),

            Visibility(
              visible: imageVisibilityDialogBox,
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3), // Adjust the border radius as needed
                ),              elevation: 2,
                backgroundColor:Colors.white,
                contentPadding: EdgeInsets.only(left: 5,right: 5,bottom: 5,top: 10),
                title: Row(
                  children: [
                    Text(
                      'Uploading Image',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: (){
                        imageVisibility = true;

                         setState(() {
                           imageVisibilityDialogBox = false;
                         });
                      },
                        child: Icon(Icons.cancel)
                    ),
                  ],
                ),
                content: Column(
                  children: [
                    Container(
                      width:MediaQuery.of(context).size.width*0.6,
                      height: MediaQuery.of(context).size.height*0.3,
                      child: ClipPath(
                        child: path == null
                            ? Image.asset(
                                'assets/images/user_image_frame_1.png',
                                fit: BoxFit.fill,
                              )
                            : Image.file(
                                File(path),
                               fit: BoxFit.fill,
                              ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 6,right: 6,top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        5), // Set the radius to 0 for a rectangular shape
                                  ),
                                ),
                              ),
                              onPressed: () {
                                imageVisibility = true;
                               setState(() {
                                 imageVisibilityDialogBox = false;
                               });
                              },
                              child: Text('Orignal')),
                          Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 2,
                              ),
                                borderRadius: BorderRadius.circular(5),
                            ),
                            child:ClipPath(
                              child: Image.asset(
                                'assets/images/user_image_frame_1.png',
                                height: MediaQuery.of(context).size.width*0.075,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: ClipRect(
                              child: Image.asset(
                                'assets/images/user_image_frame_2.png',
                                height: MediaQuery.of(context).size.width*0.075,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: ClipRect(
                              child: Image.asset(
                                'assets/images/user_image_frame_3.png',
                                height: MediaQuery.of(context).size.width*0.075,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: ClipRect(
                              child: Image.asset(
                                'assets/images/user_image_frame_4.png',
                                height: MediaQuery.of(context).size.width*0.075,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ), // Your custom UI content
                actions: <Widget>[
                  Center(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                5), // Set the radius to 0 for a rectangular shape
                          ),
                        ),
                      ),
                      child: Text('Use this Images'),
                      onPressed: () {
                        imageVisibility = true;

                        setState(() {
                          imageVisibilityDialogBox = false;
                        });
                        // Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ),

            Visibility(
                visible: imageVisibility,
                child: Container(
                  margin:
                      EdgeInsets.all(MediaQuery.of(context).size.height * 0.06),
                  child: path == null
                      ? Image.asset(
                          'assets/images/user_image_frame_1.png',
                          fit: BoxFit.cover,
                        )
                      : Image.file(File(path)),
                )),
          ],
        ),
      ),
    );
  }
}
