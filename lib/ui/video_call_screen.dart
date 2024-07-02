import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agora_helper/ui/no_video_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../gen/assets.gen.dart';
import '../src/agora_rtc_engine.dart';
import '../src/video_call_controller/video_call_controller.dart';
import 'buttons.dart';

import 'package:proximity_screen_lock/proximity_screen_lock.dart';
import 'package:proximity_sensor/proximity_sensor.dart';

import '../theme/colors.dart' as colors;

class VideoCallScreen extends ConsumerStatefulWidget {
  const VideoCallScreen(
    this.redIcon,
    this.whiteIcon, {
    super.key,
    required this.token,
    required this.channelName,
    required this.audioOnly,
    required this.uid,
    this.onPop,
    required this.role,
    required this.bgColor,
    required this.avatarUrl,
    required this.name,
  });

  final String channelName;
  final String token;
  final bool audioOnly;
  final int uid;
  final ValueChanged<int>? onPop;
  final ClientRoleType role;
  final Color bgColor;
  final String avatarUrl;

  final SvgGenImage redIcon;
  final SvgGenImage whiteIcon;
  final String name;

  @override
  ConsumerState<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends ConsumerState<VideoCallScreen> {
  late Timer _timer;
  int _callDuration = 0;

  late StreamSubscription<dynamic> _streamSubscription;
  bool _isNear = false;

  String selectedAudioSource = '';

  @override
  void initState() {
    super.initState();

    if (widget.audioOnly) {
      _listenSensor();
    }

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ref.read(localAudioMuted.notifier).state = false;
        ref.read(remoteAudioMuted.notifier).state = false;
        ref.read(localVideoStopped.notifier).state = false;
        startCall();
      },
    );
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _callDuration++;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
    _streamSubscription.cancel();
  }

  Future<void> _listenSensor() async {
    _streamSubscription = ProximitySensor.events.listen((int event) {
      setState(() {
        _isNear = (event > 0) ? true : false;
      });
      _screenLock(_isNear);
    });
  }

  Future<void> _screenLock(bool value) async {
    if (await ProximityScreenLock.isProximityLockSupported()) {
      ProximityScreenLock.setActive(value);
    }
  }

  Future<void> startCall() async {
    await ref
        .read(videoCallController.notifier)
        .setupVideoSDKEngine(widget.audioOnly);
    await ref.read(videoCallController.notifier).joinRTCCall(
          channelName: widget.channelName,
          uid: widget.uid,
          audioOnly: widget.audioOnly,
          token: widget.token,
          role: widget.role,
        );
  }

  String _formatDuration(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<bool>(joinedInChannel, (previous, next) {
      if (!next) {
        if (widget.onPop != null) {
          widget.onPop!(1);
        }
      }
    });
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Center(child: _renderRemoteVideo()),
            if (!widget.audioOnly)
              Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: size.width * 0.3,
                  child: AspectRatio(
                    aspectRatio: 9 / 16,
                    child: _renderLocalPreview(),
                  ),
                ),
              ),
            Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 112.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _formatDuration(_callDuration),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: size.width * 0.1,
              right: size.width * 0.1,
              bottom: 24.0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Consumer(builder: (context, ref, child) {
                      final state = ref.watch(localAudioMuted);
                      return ThatButton(
                        onPressed: () => ref
                            .read(videoCallController.notifier)
                            .swithcLocalAudioStream(),
                        isRed: state,
                        redIcon: Assets.icons.microphoneSlash,
                        whiteIcon: Assets.icons.microphone2,
                      );
                    }),
                    if (!widget.audioOnly)
                      Consumer(builder: (context, ref, child) {
                        final state = ref.watch(remoteAudioMuted);
                        return ThatButton(
                          onPressed: () => ref
                              .read(videoCallController.notifier)
                              .switchRemoteAudioStreams(),
                          isRed: state,
                          redIcon: Assets.icons.volumeSlash,
                          whiteIcon: Assets.icons.volumeHigh,
                        );
                      }),
                    if (widget.audioOnly)
                      PopupMenuButton(
                          color: Colors.black.withOpacity(0.75),
                          surfaceTintColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          offset: const Offset(-54, -142),
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                value: 'Speaker',
                                onTap: () {
                                  ref
                                      .read(videoCallController.notifier)
                                      .changeToSpeaker();
                                  setState(() {
                                    selectedAudioSource = 'Speaker';
                                  });
                                },
                                child: ListTile(
                                  leading: Text(
                                    'Speaker',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: selectedAudioSource == 'Speaker'
                                          ? Colors.red
                                          : Colors.white,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  trailing: Assets.icons.volumeHigh.svg(
                                    color: selectedAudioSource == 'Speaker'
                                        ? Colors.red
                                        : Colors.white,
                                    package: "flutter_agora_helper",
                                  ),
                                ),
                              ),
                              PopupMenuItem(
                                value: 'Earpiece',
                                onTap: () {
                                  ref
                                      .read(videoCallController.notifier)
                                      .changeToEarpiece();
                                  setState(() {
                                    selectedAudioSource = 'Earpiece';
                                  });
                                },
                                child: ListTile(
                                  leading: Text(
                                    'Earpiece',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: selectedAudioSource == 'Earpiece'
                                          ? Colors.red
                                          : Colors.white,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  trailing: Assets.icons.earpiece.svg(
                                    color: selectedAudioSource == 'Earpiece'
                                        ? Colors.red
                                        : Colors.white,
                                    package: "flutter_agora_helper",
                                  ),
                                ),
                              ),
                            ];
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colors.light.withOpacity(0.5),
                            ),
                            padding: const EdgeInsets.all(12),
                            child: Assets.icons.volumeHigh.svg(
                              color: colors.white,
                              height: MediaQuery.of(context).size.width * 0.06,
                              package: "flutter_agora_helper",
                            ),
                          )),
                    if (!widget.audioOnly)
                      Consumer(builder: (context, ref, child) {
                        final state = ref.watch(localVideoStopped);
                        return ThatButton(
                          onPressed: () {
                            ref
                                .read(videoCallController.notifier)
                                .switchLocalVideoStream();
                          },
                          isRed: state,
                          redIcon: Assets.icons.videoSlash,
                          whiteIcon: Assets.icons.video2,
                        );
                      }),
                    ThatButton(
                      isRed: true,
                      redIcon: widget.audioOnly
                          ? widget.redIcon
                          : Assets.icons.callSlash,
                      whiteIcon: widget.audioOnly
                          ? widget.redIcon
                          : Assets.icons.call3,
                      onPressed: () {
                        ref.read(localAudioMuted.notifier).state = false;
                        ref.read(remoteAudioMuted.notifier).state = false;
                        ref.read(localVideoStopped.notifier).state = false;
                        ref.read(videoCallController.notifier).leave();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _renderRemoteVideo() => Consumer(
        builder: (context, ref, child) {
          if (widget.audioOnly) {
            return child!;
          }
          final user = ref.watch(remoteUser);
          if (user == null) {
            return child!;
          }
          return AgoraVideoView(
            controller: VideoViewController.remote(
              rtcEngine: AgoraRtcEngine.rtcEngine,
              canvas: VideoCanvas(uid: user),
              connection: RtcConnection(channelId: widget.channelName),
            ),
          );
        },
        child: NoVideoView(
          avatarUrl: widget.avatarUrl,
          bgColor: widget.bgColor,
          name: widget.name,
        ),
      );

  Widget _renderLocalPreview() => Consumer(
        builder: (context, ref, child) {
          final joined = ref.watch(joinedInChannel);
          if (!joined) {
            return child!;
          }
          return AgoraVideoView(
            controller: VideoViewController(
              rtcEngine: AgoraRtcEngine.rtcEngine,
              canvas: const VideoCanvas(
                uid: 0,
                renderMode: RenderModeType.renderModeHidden,
              ),
            ),
          );
        },
        child: const SizedBox.shrink(),
      );
}
