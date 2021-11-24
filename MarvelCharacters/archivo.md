#  MarvelCharacters


This app has been designed using a VIP protocol based architecture.

At the beginning, all character info is asked calling "/v1/public/characters" endpoint. This endpoint gives all the information of a character, so, other endpoint calls are not needed.

Images are saved in a local cache in order to access them remotly once.

The first time you open the app an error would be shown: "Please configure missing keys". That is because you must enter the public and private keys. Go to Api/Workers/Base/BaseWorker.swift and fill the two global variables with your own public/private keys.

CharacterListPresenter class is tested using XCTest.

