Home Yoga App---------


DESCRIPTION------

*** Download the apk & then remove the app from recent tabs & then re-open the app for Local Databases to show workout data *** 

This is a fully functional Yoga app with all the functionalities and facilities that anyone needs for working out at home.
The most important feature I implemented in this app is the Multilingual Support. One can easily change the app language to their
native language by clicking on the drop down button in the appbar and selecting any of the three languages added till now,i.e,
English, Hindi & Bengali. The changes are immediate, instant & dynamic , i.e, it doesn't require app reload/restart for translation of all
the UI elements. I did this by acquiring the state of the app context and setting the locale through the app state, for dynamic language switching.
One can also change language through the settings page available at drawer. It works the same.Even if the app is closed by the user and when reopened,
the locale of the UI will be same as what user selected before closing.

100% of all the UI elements(Buttons, labels, tags, headers, snackbars, etc.) in the app is localized and can be translated to any language.
The upper section of the home page,i.e, the section of data under 'Yoga For All' and all of its workouts listed inside it 
is fetched from Local database and therefore I didn't localized it since the assessment didn't include it, but it can be easily localized using the Google Translate API.
In workout details page, i.e. where the users start working out, contains Workout name & description which are also fetched from Local Database,
therefore it hasn't been localized but it can be done using Google Translate API. 

Rest all, including the bottom section of the app, the section of data under 'Choose your type' is hardcoded and therefore fully localized.
The code has been well-organized with best practises. I used MVS (Model Views Services) Architecture for the code for easy readability, maintainability & Scalability.


LOCALIZATION SETUP------

For localization, first I added dependencies by running commands 'flutter pub add flutter_localization' & 'flutter pub add intl' and set generate: true under 
package specific dependencies. Then I made a 'l10n' directory under 'lib' folder, then made .arb files, each of English, Hindi & Bengali, like app_en.arb. 
Then a l10n.yaml file is created under root project module and there mentioned the arb directory of .arb files, file name for output of localization and 
template file of default language(English). Then under terminal I ran 'flutter gen-l10n' to create a gen-l10n directory which contains output localized files 
of all languages. Under each .arb files I added all UI elements text and their translation to native languages in JSON(Key-value) format. This has been done for 
all .arb files for english, hindi & bengali. 

Under main.dart, I added App localizations Delegates & mentioned supported Locales and under locale parameter , I assigned a variable of Locale Datatype.
For localization of UI texts, I made a function of return type Applocalizations that will translate the texts and called the function with the key
corresponding to that particular text in .arb files, for example, translate(context).home gives 'Home' in english, if app locale is set as 'en'.


HOW TO ADD NEW LANGUAGES------

Just copy all the keys from 'app_en.arb' file and paste in a new file named... 'app_LANGUAGE_CODE.arb' under the l10n folder. Then translate the values of each key using 
CHATGPT or Google translate to whatever language desired and assign the translated text each corresponding to the empty keys in the new .arb file created. Then run 
'flutter gen-l10n' under terminal. A new localized output file of the new language will be created under gen-l10n folder under .dart_tool directory. 
 
Go to 'constants.dart' and under the list 'languages' add another Dropdown Menu Item with syntax- 'DropdownMenuItem(value: "LANGUAGE_CODE",child: Text("LANGUAGE"))'.

The new language will be added successfully with this ease.


CHALLENGES FACED AND HOW THEY WERE OVERCAME------

For dynamic switching, I acquired the current state of the app and set the locale through the state, for dynamic & instant switching between languages.

Initially once the user set the language and closes the app, then after reopening , the language has been set to it's default locale. To set the language saved
before closing app, I used Shared Preferences and saved the data under Local Database. On reopening, the function didChangeDependencies has been called on main.dart,
since the state object dependencies has been changed and under that the set language locale has been fetched from Local database and has been updated to
locale parameter of MaterialApp widget. Thus now once user set a language then after closing & re-opening the app, the app locale remains unchanged.

Another minor problem faced is the translation of the UI texts to 2 different languages. I used chatGPT for it but for some keys, I had to translate it manually using Google translate
since for some keys chatGPT didn't gave satisfying translations.
It was little hectic but I did it.


-----------THE END-----------






