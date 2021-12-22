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
min SDK: 16
### iOs
```xml
<key>NSMicrophoneUsageDescription</key>
<string>We need to access to the microphone to record audio file</string>
```
min SDK: 8.0 

## Usage

Align(
       
       alignment: Alignment.centerRight,
       
       child: RecorderReplaysAndComments(
       
       sendRequestFunction: (soundFile) {
       
       # soundFile represent the sound you recording
       
       },
    
    ),

);
