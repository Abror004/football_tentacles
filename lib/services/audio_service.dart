import 'package:assets_audio_player/assets_audio_player.dart';

class AudioService {

  // static final AppDB _instance=AppDB._();
  // static AppDB get instance =>_instance;


 // static final AudioService _instance = AudioService._();
  AudioService._();
  static final AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer();

  static AssetsAudioPlayer get instance =>_audioPlayer;
}