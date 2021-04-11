// import 'dart:async';
// import 'package:dio/dio.dart';
// import 'package:palace/palace.dart';

// Future<void> main(List<String> args) async {
//   /// this benchmark is for testing we still on beta
//   /// ! DON'T USE US IN PRODUCTION FOR NOW WE STILL IN BETA !
//   final palace = Palace();
//   palace.all('/', (req, res) => res.send('Live The Queen'));
//   await palace.openGates();
//   final stopWatch = Stopwatch();
//   stopWatch.start();
//   for (var i = 0; i < 10000; i++) {
//     await Dio().get('http://localhost:3000');
//   }
//   stopWatch.stop();
//   print('the tests took ${stopWatch.elapsed.inSeconds} to serve 10k hello world request');
// }
