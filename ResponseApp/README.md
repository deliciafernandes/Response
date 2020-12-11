# Response ⚠️ 📱

A Cross Platform Mobile Application for disaster management

> Routing model:

Splash Screen -> Homepage

> To try/use the Response App yourself:
1. Download the app-release.apk in your mobile device(android or iOS(iphone and ipad))
2. Install the app
3. Ready to use 😊

Images used:
1. Pandemic Image by <a href="https://pixabay.com/users/Tumisu-148124/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=4914028">Tumisu</a> from <a href="https://pixabay.com/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=4914028">Pixabay</a>
2. Wildfire Image by <a href="https://pixabay.com/users/skeeze-272447/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=1105209">skeeze</a> from <a href="https://pixabay.com/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=1105209">Pixabay</a>
3. Storm Photo by Pixabay from Pexels
4. Flood <span>Photo by <a href="https://unsplash.com/@kellysikkema?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Kelly Sikkema</a> on <a href="https://unsplash.com/?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Unsplash</a></span>
5. Violence Photo by Oscar Chan from Pexels
6. Earthquake Image by <a href="https://pixabay.com/users/Angelo_Giordano-753934/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=1665870">Angelo Giordano</a> from <a href="https://pixabay.com/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=1665870">Pixabay</a>
7. <a href='https://www.freepik.com/free-photos-vectors/people'>People vector created by freepik - www.freepik.com</a>
8. <a href='https://www.freepik.com/vectors/medical'>Medical vector created by freepik - www.freepik.com</a>


Icons:
1. <a href="https://icons8.com/icon/86478/location">Location icon by Icons8</a>
2. <a href="https://icons8.com/icon/74/idea">Idea icon by Icons8</a>
3. <a href="https://icons8.com/icon/88625/news">News icon by Icons8</a>
4. <a href="https://icons8.com/icon/43720/share">Share icon by Icons8</a>


# Once cloned, do the following to make sure the app runs perfectly:

### iOS:
1. Make sure app has a Info.plist file in "ios/Runner/" folder having the following code for location permissions:
	```
	<key>UIViewControllerBasedStatusBarAppearance</key>
	<false/>
	<key>NSLocationWhenInUseUsageDescription</key>
	<string>Response App needs access to location when open.</string>

	<key>NSLocationAlwaysUsageDescription</key>
	<string>Response App needs access to location when in the background.</string>

	<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
   <string>Response App needs access to location when open and in the background</string>```

3. Make sure app has a AppDelegate.swift  file in "ios/Runner/" folder having the Google API key for Google Maps SDK.
4. This is a no brainer, "ios/Runner/GoogleService-Info.plist".

### Android:
1. This is a no brainer again, "android/app/google-services.json"
2. Make sure app has a local.properties file, if not:
	* Go to your  `Project -> Android`
	* Create a file  `local.properties` file
	* Open the file and Paste your Android SDK path depending on the operating system:
		a. Windows
			`sdk.dir = C:/Users/USERNAME/AppData/Local/Android/sdk`

		b. Linux or MacOS
			`sdk.dir = /home/USERNAME/Android/sdk`

		Replace  `USERNAME`  with your user name

3. Next, [Adding Google Maps API key to Android App carefully!](https://developers.google.com/maps/documentation/android-sdk/get-api-key)

### Chatbot:
1. Download a JSON file from the [google cloud console](https://console.cloud.google.com/) which helps your App to connect to the Chatbot Dialog flow Agent.
	* Incase you have no clue as to what is to be done, follow [How to add a ChatBot in Flutter using DialogFlow!](https://medium.com/flutterdevs/chatbot-in-flutter-using-dialogflow-70e28665a827)
2. Once downloaded, rename file to "credentials.json"
3. Place the credentials.json file in the "assets/json/" folder

## Run this in the terminal:
- flutter clean
- flutter doctor
- flutter pub get

**iOS Specific, `cd ios`**
- pod repo update
- pod update
- sudo gem install cocoapods
- pod setup

- flutter run
