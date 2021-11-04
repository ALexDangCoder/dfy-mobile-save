import 'dart:io';

import 'package:Dfy/config/resources/styles.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NFTItem extends StatefulWidget {
  const NFTItem({
    Key? key,
    required this.name,
    required this.price,
    required this.react,
  }) : super(key: key);
  final String name;
  final String price;
  final String react;

  @override
  _NFTItemState createState() => _NFTItemState();
}

class _NFTItemState extends State<NFTItem> {
  File? _imageFile;
  final _picker = ImagePicker();
  late bool check;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(33),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 8),
            height: 408,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xFF282C37),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () async {
                      check = await _pickImageFromGallery();
                      if (check) {
                        //nothing
                      } else {
                        final snackBar = SnackBar(
                          content: Text(
                            'your image file size to large',
                            style: textNormal(Colors.white, 14),
                          ),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }, //child: Image.file(_imageFile!),
                    child: (_imageFile != null && check == true)
                        ? Container(
                            height: 276,
                            width: 276,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: Image.file(_imageFile!).image,
                                fit: BoxFit.fill,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white30),
                            ),
                          )
                        : Container(
                            height: 276,
                            width: 276,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage(
                                    'assets/images/img_defi_test.png',),
                                fit: BoxFit.fill,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white30),
                            ),
                          ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    height: 25,
                    child: Text(
                      widget.name,
                      style: textNormal(Colors.white, 16),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                    height: 12,
                    child: Text(
                      'Evaluator Price',
                      style: textNormal(Colors.white, 10),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 27,
                    child: Row(
                      children: [
                        Text(
                          widget.price,
                          style: const TextStyle(
                            color: Colors.yellow,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Image(
                          image: AssetImage('assets/images/img_coin.png'),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  SizedBox(
                    height: 18,
                    child: Row(
                      children: [
                        SizedBox(
                          height: 18,
                          width: 153,
                          child: Text(
                            '1 of 1',
                            style: textNormal(Colors.white, 14),
                          ),
                        ),
                        const SizedBox(
                          width: 77,
                        ),
                        const Image(
                          image: AssetImage('assets/images/heart.png'),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.react,
                          style: textNormal(Colors.white, 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 28,
            width: 81,
            margin: const EdgeInsets.only(
              top: 15,
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(300),
                bottomLeft: Radius.circular(10),
                topRight: Radius.circular(30),
              ),
              gradient: LinearGradient(
                colors: [
                  Color(0xFFF4D289),
                  Color(0xFFF9C65B),
                  Color(0xFFEDB53F),
                  Color(0xFFE9AD30),
                  Color(0xFFEBB23A),
                  Color(0xFFDBA83D),
                ],
              ),
            ),
            child: const Image(
              image: AssetImage('assets/images/hard_nft.png'),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    print(File(pickedFile!.path).readAsBytesSync().lengthInBytes / 1048576);
    if (checkSizeImage(
      File(pickedFile.path).readAsBytesSync().lengthInBytes / 1048576,
    )) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      return true;
    } else {
      return false;
    }
  }

  bool checkSizeImage(double sizeFileImage) {
    if (sizeFileImage > 10000) {
      return false;
    } else {
      return true;
    }
  }
}
