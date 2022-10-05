import 'package:flutter/material.dart';
import 'package:flutter_mapp/firebase/chat_screen.dart';
import 'package:flutter_mapp/firebase/sign_up_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness:Brightness.dark,
      fontFamily: GoogleFonts.poppins().fontFamily
    ),
    home: const ChatScreen(),
  ));
}

class ImagePickerLearn extends StatefulWidget {
  const ImagePickerLearn({Key? key}) : super(key: key);

  @override
  State<ImagePickerLearn> createState() => _ImagePickerLearnState();
}

class _ImagePickerLearnState extends State<ImagePickerLearn> {
  List<XFile>? image;
  XFile? video;
  bool isVideo = false;
  final ImagePicker picker = ImagePicker();
  late VideoPlayerController _controller;

  void pickImageOrVideo() async {
    try {
      if (isVideo) {
        final pickedVideo = await picker.pickVideo(source: ImageSource.gallery);
        video = pickedVideo;
        if (video != null) {
          _controller = VideoPlayerController.file(File(video!.path))
            ..initialize()..setLooping(true).then((value) => _controller.play());
          setState(() {});
          debugPrint("video : ${video!.path.toString()}");
        }
      } else {
        final pickedImage = await picker.pickMultiImage();
        setState(() {
          image = pickedImage;
          debugPrint("path : ${pickedImage.toString()}");
        });
      }
    } catch (e) {
      debugPrint("error : ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Picker"),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              isVideo = false;
              pickImageOrVideo();
            },
            child: const Icon(Icons.image),
          ),
          FloatingActionButton(
            onPressed: () {
              isVideo = true;
              pickImageOrVideo();
            },
            child: const Icon(Icons.video_call_sharp),
          ),
        ],
      ),
      body: setImagesOrVideo(),
    );
  }

  Widget setImagesOrVideo() {
    if (isVideo) {
      if (video != null) {
        debugPrint("video not null");
        return AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        );
      } else {
        debugPrint("video null");
        return const Text("NA");
      }
    } else {
      if (image != null) {
        return ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: image!.length,
          itemBuilder: (context, index) {
            return Image.file(File(image![index].path));
          },
        );
      } else {
        return const Text("NA");
      }
    }
  }
}
