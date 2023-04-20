# social_media_recorder
A Flutter package for both android and iOS which provides  Audio recorder from microphone to a given file path through Button to record voice like social media Button
## Video
![](https://github.com/Subhi-Khalife/social_media_recorder/blob/main/screenshot/layout1.gif)


### Android
```xml
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<application
        ...
        android:requestLegacyExternalStorage="true">

```
min SDK: 16 (29 if you use OPUS)
### iOs
```xml
<key>NSMicrophoneUsageDescription</key>
<string>We need to access to the microphone to record audio file</string>
```
min SDK: 8.0 (11 if you use OPUS)

## Supported encoders
```dart

enum AudioEncoder {
  /// Will output to MPEG_4 format container
  AAC,

  /// Will output to MPEG_4 format container
  AAC_LD,

  /// Will output to MPEG_4 format container
  AAC_HE,

  /// sampling rate should be set to 8kHz
  /// Will output to 3GP format container on Android
  AMR_NB,

  /// sampling rate should be set to 16kHz
  /// Will output to 3GP format container on Android
  AMR_WB,

  /// Will output to MPEG_4 format container
  /// /!\ SDK 29 on Android /!\
  /// /!\ SDK 11 on iOs /!\
  OPUS,
}
```

### Android
https://developer.android.com/reference/android/media/MediaRecorder.AudioEncoder
### iOs
https://developer.apple.com/documentation/coreaudiotypes/coreaudiotype_constants/1572096-audio_data_format_identifiers


## Usage

Align(
       
       alignment: Alignment.centerRight,
       
       child: SocialMediaRecorder(
       
       sendRequestFunction: (soundFile) {
       
       # soundFile represent the sound you recording
       
       },
       
       encode: AudioEncoder.AAC,
       
    ),

);
