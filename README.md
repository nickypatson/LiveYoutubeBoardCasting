# LiveYoutubeBoardCasting

LiveYoutubeBoardCasting is a framework for creating live broadcasts and video streams on Youtube data API(3.0) in Objective 

## ScreenShots

![Alt text](/ScreenShotSample.png?raw=true "Optional Title")

## Requirements

- Xcode 8
- Permission to Microphone and Camera.
- Using 
  pod LFLiveKit (https://github.com/LaiFengiOS/LFLiveKit)


## Introduction

- Go to your Google account.
- Create a new application.
- Add YouTube Data API in the API Library.  
- Add API key and OAuth 2.0 client ID:

Create google auth2.0 key using console.developer.google.com

![Alt text](/ScreenShot1.png?raw=true "Optional Title")

Then create configuaton file from

https://developers.google.com/identity/sign-in/ios/start

then add APIKEY from console to  YoutubeStreamingLayer.m



## Instruction to Use

- "Enable Live Streaming" from this url https://www.youtube.com/my_live_events
- Sign using google account
- Create BoardCast 
- Then Click Upcoming events 
- From there select the event and and press "start live broadcast" .
- Url will be display in the console or Live Videos can be shown here https://www.youtube.com/my_live_events

## More Reference

https://developers.google.com/youtube/v3/

## Author

Nicky Patson

[HomePage](http://about.me/nickypatson)

<mail.nickypatson@gmail.com>





