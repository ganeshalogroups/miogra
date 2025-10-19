// ignore_for_file: prefer_final_fields, library_private_types_in_public_api, unnecessary_string_interpolations, avoid_print

import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'dart:async';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Speech Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Recognized words:',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Text(
                  // If listening is active show the recognized words
                  _speechToText.isListening
                      ? '$_lastWords'
                      // If listening isn't active but could be tell the user
                      // how to start it, otherwise indicate that speech
                      // recognition is not yet ready or not supported on
                      // the target device
                      : _speechEnabled
                          ? 'Tap the microphone to start listening...'
                          : 'Speech not available',
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            // If not yet listening for speech start, otherwise stop
            _speechToText.isNotListening ? _startListening : _stopListening,
        tooltip: 'Listen',
        child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
      ),
    );
  }
}



class SpeechToTextPage extends StatefulWidget {
  @override
  SpeechToTextPageState createState() => SpeechToTextPageState();
}

class SpeechToTextPageState extends State<SpeechToTextPage> {
  late SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press and hold to start speaking';
  double _confidence = 1.0;

  @override
  void initState() {
    super.initState();
    _speech =SpeechToText();
  }

  Future<void> _startListening() async {
    bool available = await _speech.initialize(
      onStatus: (status) => print('Status: $status'),
      onError: (errorNotification) => print('Error: $errorNotification'),
    );
    if (available) {
      setState(() => _isListening = true);
      _speech.listen(
        onResult: (result) => setState(() {
          _text = result.recognizedWords;
          _confidence = result.confidence;
        }),
      );
    }
  }

  void _stopListening() {
    setState(() => _isListening = false);
    _speech.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Long Press Speech-to-Text')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Confidence: ${(_confidence * 100.0).toStringAsFixed(1)}%',
              style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              _text,
              style: const TextStyle(fontSize: 24.0),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onLongPressStart: (details) async {
                if (!_isListening) {
                  print("Started Listening");
                  await _startListening();
                }
              },
              onLongPressEnd: (details) {
                if (_isListening) {
                  print("Stopped Listening");
                  _stopListening();
                }
              },
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Text(
                  'Press and Hold',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class SpeechToTextPage extends StatefulWidget {
//   @override
//   _SpeechToTextPageState createState() => _SpeechToTextPageState();
// }

// class _SpeechToTextPageState extends State<SpeechToTextPage> {
//   late SpeechToText _speech;
//   bool _isListening = false;
//   String _text = 'Press the button and start speaking';
//   double _confidence = 1.0;

//   @override
//   void initState() {
//     super.initState();
//     _speech = SpeechToText();
//   }

//   void _listen() async {
//     if (!_isListening) {
//       bool available = await _speech.initialize(
//         onStatus: (status) => print('Status: $status'),
//         onError: (errorNotification) => print('Error: $errorNotification'),
//       );
//       if (available) {
//         setState(() => _isListening = true);
//         _speech.listen(
//           onResult: (result) => setState(() {
//             _text = result.recognizedWords;
//             _confidence = result.confidence;
//           }),
//         );
//       }
//     } else {
//       setState(() => _isListening = false);
//       _speech.stop();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Speech to Text Demo'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Confidence: ${(_confidence * 100.0).toStringAsFixed(1)}%',
//               style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 16),
//             Text(
//               _text,
//               style: TextStyle(fontSize: 24.0),
//             ),
//             Text(
//               _text,
//               style: TextStyle(fontSize: 24.0),
//             ),
//             InkWell(
//               onLongPress: () async {
//                 // Action to perform on long press
//                 print("Long Pressed with InkWell!");
//                 if (!_isListening) {
//                   bool available = await _speech.initialize(
//                     onStatus: (status) => print('Status: $status'),
//                     onError: (errorNotification) =>
//                         print('Error: $errorNotification'),
//                   );
//                   if (available) {
//                     setState(() => _isListening = true);
//                     _speech.listen(
//                       onResult: (result) => setState(() {
//                         _text = result.recognizedWords;
//                         _confidence = result.confidence;
//                       }),
//                     );
//                   }
//                 } else {
//                   setState(() => _isListening = false);
//                   _speech.stop();
//                 }
//               },
//               borderRadius: BorderRadius.circular(12.0),
//               splashColor: Colors.red,
//               child: Container(
//                 padding: EdgeInsets.all(20.0),
//                 decoration: BoxDecoration(
//                   color: Colors.blue,
//                   borderRadius: BorderRadius.circular(12.0),
//                 ),
//                 child: Text(
//                   'Long Press Me',
//                   style: TextStyle(color: Colors.white, fontSize: 20),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _listen,
//         child: Icon(_isListening ? Icons.mic : Icons.mic_none),
//       ),
//     );
//   }
// }



// class VoiceSearchBottomSheet extends StatefulWidget {
//  bool isSearching;
//    VoiceSearchBottomSheet({super.key,this.isSearching= true,});

//   @override
//   _VoiceSearchBottomSheetState createState() => _VoiceSearchBottomSheetState();
// }

// class _VoiceSearchBottomSheetState extends State<VoiceSearchBottomSheet> {
// RecentSearchController recentSearchController = Get.put(RecentSearchController());
//  late SpeechToText _speech;
//   bool _isListening = false;
//   String _text = 'Press and hold to start speaking';
//   double _confidence = 1.0;


//   @override
//     void initState() {
//     super.initState();
//     _speech =SpeechToText();
//   }

//   // Function to start listening to the voice
//  Future<void> _startListening() async {
//     bool available = await _speech.initialize(
//       onStatus: (status) => print('Status: $status'),
//       onError: (errorNotification) => print('Error: $errorNotification'),
//     );
//     if (available) {
//       setState(() => _isListening = true);
//       _speech.listen(
//         onResult: (result) => setState(() {
//           _text = result.recognizedWords;
//           _confidence = result.confidence;
//            recentSearchController.updateSearchText(_text); 
//         }),
//       );
//     }
//   }

//   void _stopListening() {
//     setState(() => _isListening = false);
//     _speech.stop();
//   }

//   @override
//   Widget build(BuildContext context) {
//      return Stack(
//       clipBehavior: Clip.none, 
//       children: [
//         Container(
//           padding: EdgeInsets.all(20.0),
//           height: MediaQuery.of(context).size.height / 2.5,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Confidence: ${(_confidence * 100.0).toStringAsFixed(1)}%',
//                 style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 16),
//               Text(
//                 _text,
//                 style: TextStyle(fontSize: 24.0),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 30),
//               GestureDetector(
//                 onLongPressStart: (details) async {
//                   if (!_isListening) {
//                     await _startListening();
//                   }
//                 },
//                 onLongPressEnd: (details) {
//                   if (_isListening) {
//                     _stopListening();
//                   }
//                 },
//                 child: Container(
//                   padding: EdgeInsets.all(20.0),
//                   decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.circular(12.0),
//                   ),
//                   child: Text(
//                     'Press and Hold',
//                     style: TextStyle(color: Colors.white, fontSize: 20),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Positioned(
//           top: -60, // Position it floating above the sheet
//           right: 0, // Align it towards the right
//           left: 0,
//           child: InkWell(
//             onTap: () {
//               Navigator.pop(context); // Close the bottom sheet
//             },
//             child: Container(
//               width: 40, // Size of the container
//               height: 40,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Color.fromARGB(180, 19, 1, 1),
//               ),
//               child: const Icon(
//                 Icons.close,
//                 color: Colors.white, // Adjust to your color
//                 size: 30.0, // Icon size
//               ),
//             ),
//           ),
//         ),
//       ],
//     );}
// }


// class VoiceSearchBottomSheet extends StatefulWidget {
//    VoiceSearchBottomSheet({super.key,});

//   @override
//   State<VoiceSearchBottomSheet> createState() => _VoiceSearchBottomSheetState();
// }

// class _VoiceSearchBottomSheetState extends State<VoiceSearchBottomSheet> {
//  RecentSearchController recentSearchController = Get.find<RecentSearchController>();

//   SpeechToText speechToText = SpeechToText();
//   bool _speechEnabled = false;
//   String _lastWords = '';
//    @override
//   void initState() {
//     super.initState();
//     _initSpeech();
//   }

//   /// This has to happen only once per app
//   void _initSpeech() async {
//     _speechEnabled = await speechToText.initialize();
//     setState(() {});
//   }

//   /// Each time to start a speech recognition session
//   void _startListening() async {
//     await speechToText.listen(onResult: _onSpeechResult);
//     setState(() {});
//   }

//   /// Manually stop the active speech recognition session
//   /// Note that there are also timeouts that each platform enforces
//   /// and the SpeechToText plugin supports setting timeouts on the
//   /// listen method.
//   void _stopListening() async {
//     await speechToText.stop();
//     setState(() {});
//   }

//   /// This is the callback that the SpeechToText plugin calls when
//   /// the platform returns recognized words.
//   void _onSpeechResult(SpeechRecognitionResult result) {
//     setState(() {
//       _lastWords = result.recognizedWords;
//     });
//      recentSearchController.updateSearchText(_lastWords);
//       if (_lastWords.isNotEmpty) {
//         Future.delayed(const Duration(seconds: 1),
//                                       () {
//                                      Get.back();
//                                   }); // Use Get.back() to close the bottom sheet instead of Navigator.pop
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: MediaQuery.of(context).size.height / 2.5,
//       width:MediaQuery.of(context).size.width ,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           Container(
//             padding: EdgeInsets.all(16),
//             child: Text(
//               'Recognized words:',
//               style: TextStyle(fontSize: 20.0),
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.all(16),
//             child: Text(
//               // If listening is active show the recognized words
//               speechToText.isListening
//                   ? '$_lastWords'
//                   // If listening isn't active but could be tell the user
//                   // how to start it, otherwise indicate that speech
//                   // recognition is not yet ready or not supported on
//                   // the target device
//                   : _speechEnabled
//                       ? 'Tap the microphone to start listening...'
//                       : 'Speech not available',
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 24.0),
//             ),
//           ),
//           FloatingActionButton(
//             onPressed: speechToText.isNotListening ? _startListening : _stopListening,
//             tooltip: 'Listen',
//             child:_lastWords.isNotEmpty
//                 ? Image.asset(fastxdummyImg, width: 24, height: 15) // Replace with your image path
//                 :  Icon(speechToText.isNotListening ? Icons.mic_off : Icons.mic),
//           ),
//         ],
//       ),
//     );
//   }
// }

class VoiceSearchBottomSheet extends StatefulWidget {
  const VoiceSearchBottomSheet({super.key});

  @override
  State<VoiceSearchBottomSheet> createState() => _VoiceSearchBottomSheetState();
}

class _VoiceSearchBottomSheetState extends State<VoiceSearchBottomSheet> {
  final RecentSearchController recentSearchController = Get.find<RecentSearchController>();
  final SpeechToText speechToText = SpeechToText();

  bool _speechEnabled = false;
  bool _isListening = false;
  String _lastWords = '';
  String _statusMessage = 'Tap the microphone to start listening...';
  Timer? _inactivityTimer;

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    setState(() {
      _isListening = true;
      _statusMessage = 'Listening...';
    });
    _inactivityTimer?.cancel(); // Cancel any existing timers
    await speechToText.listen(
      onResult: _onSpeechResult,
    );
    // Start a timer to stop listening after 5 seconds of inactivity
    _inactivityTimer = Timer(const Duration(seconds: 5), () {
      if (_lastWords.isEmpty && _isListening) {
        _stopListening();
        setState(() {
          _statusMessage = 'Try again';
        });
      }
    });
  }

  void _stopListening() async {
    await speechToText.stop();
    _inactivityTimer?.cancel(); // Cancel the timer if listening is stopped manually
    setState(() {
      _isListening = false;
    });
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    _inactivityTimer?.cancel(); // Cancel the timer if speech is detected
    setState(() {
      _lastWords = result.recognizedWords;
      _statusMessage = _lastWords.isEmpty ? 'Sorry! Didnt hear that \n Try saying restaurant name or dish' : 'Recognized words: $_lastWords';
    });
    if (_lastWords.isNotEmpty) {
      recentSearchController.updateSearchText(_lastWords);
      Future.delayed(const Duration(seconds: 1), () {
        Get.back(); // Close the bottom sheet
      });
    }
  }

  @override
  void dispose() {
    _inactivityTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2.8,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16),
            child: Text(
              _statusMessage,
              textAlign: TextAlign.center,
              style: CustomTextStyle.Locationtext
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Text(
             speechToText.isListening
                  ? '$_lastWords':'',
                  // ? (_isListening ? _lastWords : _statusMessage)
                  // : 'Speech not available',
              textAlign: TextAlign.center,
              style: CustomTextStyle.splashpermissionTitle
            ),
          ),
          Container(
            decoration:CustomContainerDecoration.voicerecorderdecoration(),
            child: FloatingActionButton(
               backgroundColor: Colors.transparent, // Make FAB background transparent
    elevation: 0, // Remove shadow to blend with the gradient
              onPressed: _isListening ? _stopListening : _startListening,
              tooltip: 'Listen',
              child: _isListening
                  ? const Icon(Icons.mic,color: Customcolors.DECORATION_WHITE,)
                  : const Icon(Icons.mic_off,color: Customcolors.DECORATION_WHITE,),
            ),
          ),
        ],
      ),
    );
  }
}


class RecentSearchController extends GetxController {
  var recentSearchText = ''.obs; // Reactive variable to store the recent search text

  // Method to update the search text
  void updateSearchText(String text) {
    recentSearchText.value = text;
    print("value${text}");
  }

  // Method to fetch the search text
  String getSearchText() {
    return recentSearchText.value;
  }
}
