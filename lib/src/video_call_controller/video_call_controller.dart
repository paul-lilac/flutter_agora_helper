import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_agora_helper/src/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../agora_rtc_engine.dart';

part 'providers.dart';

typedef UserJoined = void Function(
  RtcConnection connection,
  int remoteUid,
  int elapsed,
);

typedef OnJoinChannelSuccess = void Function(
  RtcConnection connection,
  int elapsed,
);

typedef OnUserOffline = void Function(
  RtcConnection connection,
  int remoteUid,
  UserOfflineReasonType reason,
);

class VideoCallController extends StateNotifier<void> {
  VideoCallController(this.ref) : super(Null) {
    rtcEngine = AgoraRtcEngine.rtcEngine;
  }

  late RtcEngine rtcEngine;
  final Ref ref;

  Future<void> setupVideoSDKEngine(bool audioOnly) async {
    if (audioOnly) {
      await Permission.microphone.request();
    } else {
      await [Permission.microphone, Permission.camera].request();
    }

    if (!audioOnly) {
      const configuration = VideoEncoderConfiguration(
        dimensions: VideoDimensions(
          width: 1920,
          height: 1080,
        ),
        advanceOptions: AdvanceOptions(
          compressionPreference: CompressionPreference.preferLowLatency,
          encodingPreference: EncodingPreference.preferAuto,
        ),
        codecType: VideoCodecType.videoCodecGenericH264,
        degradationPreference: DegradationPreference.maintainBalanced,
        orientationMode: OrientationMode.orientationModeFixedPortrait,
      );

      await rtcEngine.setVideoEncoderConfiguration(configuration);
    }

    try {
      rtcEngine.registerEventHandler(RtcEngineEventHandler(
        onJoinChannelSuccess: (connection, elapsed) {
          log("local user ${connection.localUid} joined in ${connection.channelId}");

          ref.read(joinedInChannel.notifier).state = true;
          if (!audioOnly) {
            try {
              rtcEngine.startPreview(
                sourceType: VideoSourceType.videoSourceCamera,
              );
            } catch (e) {
              log("startPreview-Error: ${e.toString()}");
            }
          }
        },
        onUserJoined: (connection, remoteUid, elapsed) {
          log("remote user $remoteUid joined in ${connection.channelId}");
          ref.read(remoteUser.notifier).state = remoteUid;
        },
        onUserOffline: (connection, remoteUid, reason) {
          log("remote user $remoteUid left ${connection.channelId}");
          leave();
        },
        // onRemoteVideoStateChanged:
        //     (connection, remoteUid, state, reason, elapsed) {
        //   if (state == RemoteVideoState.remoteVideoStateStopped) {
        //     // Remote user stopped sending video
        //     ref.read(remoteUser.notifier).state =
        //         null; // Set remoteUser state to null
        //   } else if (state == RemoteVideoState.remoteVideoStateDecoding) {
        //     // Remote user's video stream is being decoded
        //     ref.read(remoteUser.notifier).state =
        //         remoteUid; // Update remoteUser state with remoteUid
        //   }
        // },
        onUserMuteAudio: (connection, remoteUid, muted) {
          rtcEngine.muteAllRemoteAudioStreams(muted);
        },
        onUserMuteVideo: (connection, remoteUid, muted) {
          if (muted) {
            // Remote user stopped sending video
            ref.read(remoteUser.notifier).state =
                null; // Set remoteUser state to null
          } else {
            // Remote user's video stream is being decoded
            ref.read(remoteUser.notifier).state =
                remoteUid; // Update remoteUser state with remoteUid
          }
        },
        onError: (err, msg) {
          log("Error: ${err.name} - $msg");
        },
        onPermissionError: (permissionType) {
          log("PermissionError: ${permissionType.name}");
        },
      ));
      log("Event handlers Set");
    } catch (e) {
      log("Error Event handlers Set: ${e.toString()}");
    }
  }

  Future<void> joinRTCCall({
    required String channelName,
    required int uid,
    required String token,
    required bool audioOnly,
    required ClientRoleType role,
  }) async {
    try {
      if (!audioOnly) {
        await rtcEngine.enableVideo();
      } else {
        await rtcEngine.disableVideo();
        rtcEngine.setDefaultAudioRouteToSpeakerphone(!audioOnly);
      }
      log("joining channel : $channelName, role: ${role.toString()}");

      await rtcEngine.joinChannel(
        token: token,
        channelId: channelName,
        uid: uid,
        options: ChannelMediaOptions(
          clientRoleType: role,
          channelProfile: ChannelProfileType.channelProfileCommunication,
        ),
      );

      log("joinChannel Success");
    } catch (e) {
      log("joinChannel Error: ${e.runtimeType.toString()}");
      log("joinChannel Error: ${e.toString()}");
    }
  }

  Future<void> swithcLocalAudioStream() async {
    final value = ref.read(localAudioMuted);
    await rtcEngine.muteLocalAudioStream(!value);
    ref.read(localAudioMuted.notifier).state = !value;
  }

  Future<void> switchRemoteAudioStreams() async {
    final value = ref.read(remoteAudioMuted);
    rtcEngine.muteAllRemoteAudioStreams(!value);
    ref.read(remoteAudioMuted.notifier).state = !value;
  }

  Future<void> changeAudioRoute() async {
    final value = !ref.read(isSpeaker);
    rtcEngine.setDefaultAudioRouteToSpeakerphone(value);
    ref.read(isSpeaker.notifier).state = value;
  }

  Future<void> switchLocalVideoStream() async {
    final value = ref.read(localVideoStopped);
    rtcEngine.muteLocalVideoStream(!value);
    ref.read(localVideoStopped.notifier).state = !value;
  }

  Future<void> leave() async {
    ref.read(joinedInChannel.notifier).state = false;
    ref.read(remoteUser.notifier).state = null;
    await rtcEngine.leaveChannel();
  }
}
