import 'dart:async';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:vibe_zo/core/utils/assets.dart';
import 'package:vibe_zo/core/utils/constants.dart';

import '../../../../core/utils/gaps.dart';
import '../../data/models/get_chat_messages_model/message.dart';
import '../../data/models/get_chat_messages_model/sender.dart';
import '../manager/chat_messages_manager_cubit/chat_messages_manager_cubit_cubit.dart';
import '../manager/send_message/send_message_cubit.dart';

class ChatField extends StatefulWidget {
  final Message? repliedTo;
  final VoidCallback? onCancelReply;
  final String chatId;

  const ChatField({
    super.key,
    this.repliedTo,
    this.onCancelReply,
    required this.chatId,
  });

  @override
  State<ChatField> createState() => _ChatFieldState();
}

class _ChatFieldState extends State<ChatField> {
  final userToken = Hive.box(kLoginTokenBox).get(kLoginTokenBox);
  final AudioRecorder _recorder = AudioRecorder();
  final AudioPlayer _player = AudioPlayer();
  final TextEditingController _textController = TextEditingController();
  late final RecorderController _waveformController;

  bool _isRecording = false;
  bool _isPlaying = false;
  bool _cancelRecording = false;
  bool _showSendButton = false;
  Offset _startOffset = Offset.zero;
  String? _recordedFilePath;
  double _micScale = 1.0;

  Duration _currentDuration = Duration.zero;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _waveformController = RecorderController()
      ..updateFrequency = const Duration(milliseconds: 100)
      ..refresh();

    _textController.addListener(_handleTextChange);
  }

  void _handleTextChange() {
    setState(() {
      _showSendButton = _textController.text.trim().isNotEmpty;
    });
  }

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
      _waveformController.reset();
      _waveformController.record();

      _currentDuration = Duration.zero;
      _timer?.cancel();
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (mounted) {
          setState(() {
            _currentDuration += const Duration(seconds: 1);
          });
        }
      });

      setState(() {
        _isRecording = true;
        _cancelRecording = false;
      });
    }
  }

  Future<void> _stopRecording() async {
    _timer?.cancel();
    final path = await _recorder.stop();
    await _waveformController.stop();

    setState(() {
      _isRecording = false;
      _micScale = 1.0;
      _recordedFilePath = _cancelRecording ? null : path;
      _currentDuration = Duration.zero;
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

  Widget _buildRecordingStatus() {
    final minutes = _currentDuration.inMinutes
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    final seconds = _currentDuration.inSeconds
        .remainder(60)
        .toString()
        .padLeft(2, '0');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: AudioWaveforms(
            size: const Size(double.infinity, 40),
            recorderController: _waveformController,
            enableGesture: false,
            waveStyle: const WaveStyle(
              spacing: 4,
              showMiddleLine: false,
              extendWaveform: true,
              waveColor: kPrimaryColor,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: kGreyTextColor),
            borderRadius: BorderRadius.circular(99999),
            color: Colors.grey.shade100,
          ),
          child: Row(
            children: [
              Icon(
                Icons.fiber_manual_record,
                color: _cancelRecording ? Colors.grey : Colors.red,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                '$minutes:$seconds',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                "اسحب لليسار للإلغاء",
                style: TextStyle(
                  fontSize: 14,
                  color: _cancelRecording ? Colors.grey : kGreyTextColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReplyHeader() {
    if (widget.repliedTo == null) return const SizedBox();
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(.3),
        borderRadius: BorderRadius.circular(99999),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              widget.repliedTo!.text ?? "",
              style: const TextStyle(fontSize: 14, height: 1.29),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: widget.onCancelReply,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _recorder.dispose();
    _player.dispose();
    _waveformController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.repliedTo != null) _buildReplyHeader(),
        Row(
          children: [
            Expanded(
              child: _isRecording
                  ? _buildRecordingStatus()
                  : TextField(
                      controller: _textController,
                      minLines: 1,
                      maxLines: 3,
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: kGreyTextColor),
                          borderRadius: BorderRadius.circular(99999),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: kPrimaryColor),
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
            if (_showSendButton)
              GestureDetector(
                onTap: () {
                  final text = _textController.text.trim();
                  if (text.isNotEmpty) {
                    // TODO: Call API or WebSocket to send message here
                    final tempMessage = Message(
                      id: DateTime.now().millisecondsSinceEpoch,
                      text: text,
                      isFromMe: true,
                      sender: Sender(id: 45),
                      createdAt: DateTime.now(),
                      isLocal: true,
                    );

                    context.read<ChatMessagesManagerCubit>().addLocalMessage(
                      tempMessage,
                    );

                    // بعدين ابعتها للسيرفر عبر API أو WebSocket

                    BlocProvider.of<SendMessageCubit>(context).sendMessage(
                      token: userToken,
                      chatId: widget.chatId,
                      type: "text",
                      message: text,
                    );
                    _textController.clear();

                    context
                        .read<ChatMessagesManagerCubit>()
                        .messages
                        .removeWhere((message) => message.id == tempMessage.id);
                  }
                },
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: kPrimaryColor,
                  child: Image.asset(AssetsData.sendMsg, width: 28, height: 28),
                ),
              )
            else
              GestureDetector(
                onLongPressStart: (details) async {
                  _startOffset = details.globalPosition;
                  setState(() => _micScale = 1.0);
                  await _startRecording();
                },
                onLongPressMoveUpdate: (details) {
                  final dx = details.globalPosition.dx;
                  setState(() {
                    _cancelRecording = _startOffset.dx - dx > 100;
                  });
                },
                onLongPressEnd: (_) async {
                  setState(() => _micScale = 1.0);
                  await _stopRecording();
                },
                child: CircleAvatar(
                  radius: 25 * _micScale,
                  backgroundColor: _isRecording
                      ? (_cancelRecording ? Colors.red : kPrimaryColor)
                      : kLightGreyColor,
                  child: Image.asset(
                    (_isRecording && _cancelRecording)
                        ? AssetsData.trash
                        : AssetsData.mic,
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
