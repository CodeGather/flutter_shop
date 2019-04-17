/*
 * @Author: 21克的爱情
 * @LastEditors: 21克的爱情
 * @Description: 
 * @Date: 2019-04-02 11:15:41
 * @LastEditTime: 2019-04-10 14:09:06
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {

  List<Map> imagelist = [];
  Future<File> _imageFile;

  void _selectedImage(ImageSource source) {
    setState(() {
      _imageFile = ImagePicker.pickImage(source: source);
    });
  }

  Widget _previewImage() {
    return FutureBuilder<File>(
      future: _imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Image.file(snapshot.data);
        } else if (snapshot.error != null) {
          return const Text(
            'Error picking image.',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'You have not yet picked an image.',
            textAlign: TextAlign.center,
          );
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的钱包'),
      ),
      body: Column(
        children: <Widget>[
          CupertinoButton(
            child: Text("选择图片"), 
            onPressed: (){
              _showDialog(context);
            }
          ),
          Center(
            child:  _previewImage(),
          ),
        ],
      )
    );
  }

  void _showDialog(BuildContext cxt){
    showCupertinoModalPopup<int>(context: cxt, builder:(cxt){
      var dialog =CupertinoActionSheet(
        title: Text("请选择上传图片类型"),
        cancelButton: CupertinoActionSheetAction(
          onPressed: (){
            Navigator.pop(cxt,0);
          }, 
          child: Text("取消")
        ),
        actions: <Widget>[
          CupertinoActionSheetAction(
            onPressed: (){
              Navigator.pop(cxt,1);
              _selectedImage(ImageSource.camera);
            }, 
            child: Text('相机选取')
          ),
          CupertinoActionSheetAction(
            onPressed: (){
              Navigator.pop(cxt,2);
              _selectedImage(ImageSource.gallery);
            }, 
            child: Text('相册选取')
          ),
        ],
      );
      return dialog;
    });
  }
}