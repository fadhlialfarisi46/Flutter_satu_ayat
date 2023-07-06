import 'dart:async';
import 'dart:io';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:satu_ayat/common/navigation_route.dart';
import 'package:satu_ayat/data/model/ayat.dart';
import 'package:satu_ayat/provider/detail_ayat_provider.dart';
import 'package:satu_ayat/ui/detail_page.dart';
import 'package:satu_ayat/ui/settings_page.dart';
import 'package:screenshot/screenshot.dart';

import '../extension/state_management.dart';
import '../utils/notification_helper.dart';
import '../widgets/custom_fab.dart';
import '../widgets/custom_snackbar.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NotificationHelper _notificationHelper = NotificationHelper();

  ScreenshotController screenshotController = ScreenshotController();

  bool _showMoreFAB = false;
  bool _isButtonVisible = true;

  Ayat? ayat;

  void setMoreFABVisible(bool value) {
    setState(() {
      _showMoreFAB = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(DetailPage.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: screenshotController,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg-image.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Color(0xFF3D3D3D),
              BlendMode.darken,
            ),
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Consumer<DetailAyatProvider>(
            builder: (context, state, _) {
              if (state.state == ResultState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.state == ResultState.hasData) {
                _isButtonVisible = true;
                ayat = state.result;
                return _buildDetailAyat(state.result);
              } else if (state.state == ResultState.noData) {
                return _handleError(state);
              } else if (state.state == ResultState.error) {
                return _handleError(state);
              } else {
                return const Center(child: Text(''));
              }
            },
          ),
          floatingActionButton: _buildFAB(),
        ),
      ),
    );
  }

  Widget _handleError(DetailAyatProvider state) {
    _isButtonVisible = false;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            state.message,
            style: const TextStyle(color: Colors.white),
          ),
          ElevatedButton(
              onPressed: () async {
                await state.fetchAyat();
              },
              child: const Text("Coba Lagi")
          ),
        ],
      ),
    );
  }

  Widget _buildFAB() {
    return Visibility(
      visible: _isButtonVisible,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (_showMoreFAB) _buildMoreFAB(),
            const SizedBox(
              height: 8,
            ),
            FloatingActionButton(
              onPressed: () {
                setMoreFABVisible(!_showMoreFAB);
              },
              child: Icon(_showMoreFAB ? Icons.close : Icons.add),
            ),
          ]),
    );
  }

  Widget _buildMoreFAB() {
    return IntrinsicWidth(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // FloatingActionButton.extended(
            //   onPressed: () {
            //     Navigation.intentWithData(DetailPage.routeName, ayat as Object);
            //   },
            //   label: const Text('Detail', textAlign: TextAlign.start,),
            //   icon: const Icon(Icons.arrow_circle_right_outlined),
            // ),
            // const SizedBox(
            //   height: 8,
            // ),
            // FloatingActionButton.extended(
            //   onPressed: () {
            //     _handleScreenshotFAB();
            //   },
            //   label: const Text('Screenshot'),
            //   icon: const Icon(Icons.add_a_photo_outlined),
            // ),
            // const SizedBox(
            //   height: 8,
            // ),
            // FloatingActionButton.extended(
            //   onPressed: () {
            //     Navigation.intent(SettingsPage.routeName);
            //   },
            //   label: const Text('Settings'),
            //   icon: const Icon(Icons.settings),
            // ),
            // const SizedBox(
            //   height: 8,
            // ),
            // FloatingActionButton.extended(
            //   onPressed: () {
            //     customSnackbar(context);
            //   },
            //   label: const Text('Add to Favorite'),
            //   icon: const Icon(Icons.favorite),
            // ),
            // const SizedBox(
            //   height: 8,
            // ),
            CustomFAB(
                text: 'Detail',
                onPressed: () {
                  Navigation.intentWithData(DetailPage.routeName, ayat as Object);
                },
                icon: const Icon(Icons.arrow_circle_right_outlined),
            ),
            const SizedBox(
              height: 8,
            ),
            CustomFAB(
              text: 'Screenshot',
              onPressed: () {
                _handleScreenshotFAB();
              },
              icon: const Icon(Icons.add_a_photo_outlined),
            ),
            const SizedBox(
              height: 8,
            ),
            CustomFAB(
              text: 'Settings',
              onPressed: () {
                Navigation.intent(SettingsPage.routeName);
              },
              icon: const Icon(Icons.settings),
            ),
            const SizedBox(
              height: 8,
            ),
            CustomFAB(
              text: 'Add to Favorite',
              onPressed: () {
                customSnackbar(context);
              },
              icon: const Icon(Icons.favorite),
            ),
          ]),
    );
  }

  void _handleScreenshotFAB() {
    setState(() {
      _isButtonVisible = false;
    });
    _takeScreenshotandShare();
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _isButtonVisible = true;
      });
    });
  }

  Widget _buildDetailAyat(Ayat ayat) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(ayat.arab ?? "",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold)),
          Text(ayat.translation ?? "",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  // fontFamily: 'Pacifico',
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 8,
          ),
          Text("Ayat ke-${ayat.number?.inSurah} dalam surah",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  // fontFamily: 'Pacifico',
                  color: Colors.white70,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  _takeScreenshotandShare() async {
    screenshotController
        .capture(delay: const Duration(milliseconds: 10), pixelRatio: 2.0)
        .then((capturedImage) async {
      final directory = (await getApplicationDocumentsDirectory()).path;
      File imgFile = File('$directory/Ayat.png');
      imgFile.writeAsBytes(capturedImage!);
      await Share.file('One Ayat', 'Ayat.png', capturedImage, 'image/png');
    }).catchError((onError) {
      print(onError);
    });
  }
}
