import 'dart:io';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:vibe_zo/core/utils/assets.dart';
import 'package:vibe_zo/core/utils/constants.dart';

import '../../../../core/utils/gaps.dart';

class ChatField extends StatefulWidget {
  const ChatField({super.key});

  @override
  State<ChatField> createState() => _ChatFieldState();
}

class _ChatFieldState extends State<ChatField> {
  final AudioRecorder _recorder = AudioRecorder();
  final AudioPlayer _player = AudioPlayer();

  bool _isRecording = false;
  bool _isPlaying = false;
  bool _cancelRecording = false;
  Offset _startOffset = Offset.zero;
  String? _recordedFilePath;

  Future<String> _getTempFilePath() async {
    final dir = await getTemporaryDirectory();
    return '${dir.path}/record_${DateTime.now().millisecondsSinceEpoch}.m4a';
  }

  Future<void> _startRecording() async {
    if (await _recorder.hasPermission()) {
      final path = await _getTempFilePath();
      await _recorder.start(
        const RecordConfig(encoder: AudioEncoder.aacLc),
        path: path,
      );
      _recordedFilePath = path;
      setState(() {
        _isRecording = true;
        _cancelRecording = false;
      });
    }
  }

  Future<void> _stopRecording() async {
    final path = await _recorder.stop();
    setState(() {
      _isRecording = false;
      _recordedFilePath = _cancelRecording ? null : path;
    });
    if (_cancelRecording && path != null) {
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
      }
    }
  }

  Future<void> _togglePlayback() async {
    if (_recordedFilePath == null) return;

    if (_player.playing) {
      await _player.pause();
      setState(() => _isPlaying = false);
    } else {
      await _player.setFilePath(_recordedFilePath!);
      await _player.play();
      setState(() => _isPlaying = true);

      _player.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          setState(() => _isPlaying = false);
        }
      });
    }
  }

  @override
  void dispose() {
    _recorder.dispose();
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            minLines: 1,
            maxLines: 4,
            cursorColor: kPrimaryColor,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: kGreyTextColor, width: 1.0),
                borderRadius: BorderRadius.circular(99999),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: kPrimaryColor, width: 1),
                borderRadius: BorderRadius.circular(99999),
              ),
              suffixIcon: Image.asset(AssetsData.gift),
              contentPadding: const EdgeInsets.all(0),
              prefixIcon: InkWell(
                onTap: () {},
                child: Image.asset(AssetsData.happyFace),
              ),
            ),
          ),
        ),
        Gaps.hGap8,

        /// زر التسجيل بالضغط المستمر
        GestureDetector(
          onLongPressStart: (details) async {
            _startOffset = details.globalPosition;
            await _startRecording();
          },
          onLongPressMoveUpdate: (details) {
            final dy = details.globalPosition.dy;
            if (_startOffset.dy - dy > 100) {
              // المستخدم سحب لأعلى 100px
              setState(() {
                _cancelRecording = true;
              });
            } else {
              setState(() {
                _cancelRecording = false;
              });
            }
          },
          onLongPressEnd: (details) async {
            await _stopRecording();

            if (_cancelRecording) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("تم إلغاء التسجيل")));
            } else {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("تم حفظ التسجيل")));
            }
          },
          child: CircleAvatar(
            radius: 25,
            backgroundColor: _isRecording
                ? (_cancelRecording ? Colors.grey : Colors.red)
                : kLightGreyColor,
            child: Icon(
              _isRecording ? Icons.stop : Icons.mic,
              color: Colors.white,
            ),
          ),
        ),

        Gaps.hGap8,

        /// زر التشغيل
        if (_recordedFilePath != null && !_isRecording)
          InkWell(
            onTap: _togglePlayback,
            child: CircleAvatar(
              backgroundColor: Colors.green[200],
              child: Icon(
                _isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
              ),
            ),
          ),
      ],
    );
  }
}
