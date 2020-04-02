import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';

  Future<void> shareText({String titulo = '',@required String texto}) async {
    try {
      Share.text(titulo,texto, 'text/plain');
    } catch (e) {
      print('error: $e');
    }
  }

  Future<void> shareImage() async {
    try {
      final ByteData bytes = await rootBundle.load('assets/image1.png');
      await Share.file(
          'esys image', 'esys.png', bytes.buffer.asUint8List(), 'image/png',
          text: 'My optional text.');
    } catch (e) {
      print('error: $e');
    }
  }

  Future<void> sharePDF() async {
    try {
      final ByteData bytes = await rootBundle.load('assets/hello.pdf');

    } catch (e) {
      print('error asd: $e');
    }
  }
  Future<void> shareImages() async {
    try {
      final ByteData bytes1 = await rootBundle.load('assets/image1.png');
      final ByteData bytes2 = await rootBundle.load('assets/image2.png');

      await Share.files(
          'esys images',
          {
            'esys.png': bytes1.buffer.asUint8List(),
            'bluedan.png': bytes2.buffer.asUint8List(),
          },
          'image/png');
    } catch (e) {
      print('error: $e');
    }
  }

  Future<void> shareCSV() async {
    try {
      final ByteData bytes = await rootBundle.load('assets/addresses.csv');
      await Share.file(
          'addresses', 'addresses.csv', bytes.buffer.asUint8List(), 'text/csv');
    } catch (e) {
      print('error: $e');
    }
  }

  Future<void> shareMixed() async {
    try {
      final ByteData bytes1 = await rootBundle.load('assets/image1.png');
      final ByteData bytes2 = await rootBundle.load('assets/image2.png');
      final ByteData bytes3 = await rootBundle.load('assets/addresses.csv');

      await Share.files(
          'esys images',
          {
            'esys.png': bytes1.buffer.asUint8List(),
            'bluedan.png': bytes2.buffer.asUint8List(),
            'addresses.csv': bytes3.buffer.asUint8List(),

          },
          '*/*',
          text: 'My optional text.');
    } catch (e) {
      print('error: $e');
    }
  }

  Future<void> shareImageFromUrl() async {
    try {
      var request = await HttpClient().getUrl(Uri.parse(
          'https://shop.esys.eu/media/image/6f/8f/af/amlogtransport-berwachung.jpg'));
      var response = await request.close();
      Uint8List bytes = await consolidateHttpClientResponseBytes(response);
      await Share.file('ESYS AMLOG', 'amlog.jpg', bytes, 'image/jpg');
    } catch (e) {
      print('error: $e');
    }
  }

  Future<void> shareSound() async {
    try {
      final ByteData bytes = await rootBundle.load('assets/cat.mp3');
      await Share.file(
          'Sound', 'cat.mp3', bytes.buffer.asUint8List(), 'audio/*');
    } catch (e) {
      print('error: $e');
    }
  }
