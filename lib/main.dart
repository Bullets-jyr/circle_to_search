import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_gallery/photo_gallery.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const GalleryHome(),
    );
  }
}

class GalleryHome extends StatefulWidget {
  const GalleryHome({super.key});

  @override
  State<GalleryHome> createState() => _GalleryHomeState();
}

class _GalleryHomeState extends State<GalleryHome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // loadAllAlbums();
    requestPermissions();
  }

  requestPermissions() async {
    if (Platform.isIOS) {
      if (await Permission.photos.request().isGranted ||
          await Permission.storage.request().isGranted) {
        loadAllAlbums();
      }
    } else if (Platform.isAndroid) {
      if (await Permission.photos.request().isGranted ||
          await Permission.storage.request().isGranted &&
              await Permission.videos.request().isGranted) {
        loadAllAlbums();
      }
    }
  }

  loadAllAlbums() async {
    List<Album> albums = await PhotoGallery.listAlbums();
    albums.forEach(
      (element) {
        print(element.name);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
