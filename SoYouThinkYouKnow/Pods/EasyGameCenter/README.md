<h1 align="center"> Easy Game Center \ EGC</h1>
 
[![](http://img.shields.io/badge/Swift-2.2-blue.svg)]()  [![](http://img.shields.io/badge/tvOS-9.0%2B-blue.svg)]()  [![](http://img.shields.io/badge/iOS-7.0%2B-blue.svg)]()  [![](http://img.shields.io/badge/iOS-8.0%2B-blue.svg)]()  [![](http://img.shields.io/badge/iOS-9.0%2B-blue.svg)]()  [![](https://img.shields.io/packagist/l/doctrine/orm.svg)]()  [![Pod Version](http://img.shields.io/cocoapods/v/EasyGameCenter.svg?style=flat)](http://cocoadocs.org/docsets/EasyGameCenter/)  [![Pod Platform](http://img.shields.io/cocoapods/p/EasyGameCenter.svg?style=flat)](http://cocoadocs.org/docsets/EasyGameCenter/)  [![Pod License](http://img.shields.io/cocoapods/l/EasyGameCenter.svg?style=flat)](http://opensource.org/licenses/MIT)

<p align="center">
        <img src="http://s2.postimg.org/jr6rlurax/easy_Game_Center_Swift.png" height="200" width="200" />
</p>

<p align="center">
        <img src="https://img.shields.io/badge/Easy Game Center-2.2-D8B13C.svg" />
</p>
**Easy Game Center** helps you manage Game Center on iOS. Report and track **high scores**, **achievements** and **Multiplayer**. Easy Game Center facilitate Game Center management.  

<p align="center">
        <img src="http://g.recordit.co/aEYan5qPW3.gif" height="500" width="280" />
</p>

##iOS Games using Easy Game Center
* **Hipster Moustache : http://bit.ly/1zGJMNG  By Stephan Yannick**
* **Dyslexia : http://apple.co/1L3D6xS By Nicolas Morelli**
* **Kicuby : https://goo.gl/BzNXBW By Kicody**

##Project Features
* Swift and Objective-C
* Manage **Multiplayers**
* Manage **Leaderboards**
* Manage **Achievements**
* Manage in **single line of code** most functions of Game Center
* Achievements are saved in cache and automatically refreshed
* Delegate function when player is connected, not connected, multiplayer etc...
* Most of the functions have completion
* Simply use the methods with EGC.method or EasyGameCenter.method

##Contributions & Support
* Any contribution is more than welcome ! You can contribute through pull requests and issues on GitHub. :D
* Send me your application's link, if you use Easy Game center, I will add on the cover page 
* Contact for support [Issues](https://github.com/DaRkD0G/Easy-Game-Center-Swift/issues) or [@YannickSteph](https://twitter.com/YannickSteph)


##Installation <a id="Installation"></a>
--------
###CocoaPods
```ruby
pod 'EasyGameCenter', :git => 'https://github.com/DaRkD0G/Easy-Game-Center-Swift.git'
```
###Manual
Add the following classe **`EasyGameCenter.swift`** to your Xcode project (make sure to select Copy Items in the dialog)

Add **`GameKit`** and **`SystemConfiguration`** frameworks to your Xcode project.    
[**See**](http://s27.postimg.org/45wds3jub/Capture_d_cran_2558_03_20_19_56_34.png)


##Documentation

###Initialize and Example
--------
**You can add protocol `EGCDelegate` for access to delegate functions**
* Connexion `EGCAuthentified` `EGCInCache`
* Multiplayer `EGCMatchStarted` `EGCMatchRecept` `EGCMatchEnded` `EGCMatchCancel`

`EGCDelegate` it's optional, it's not mandatory
 
```swift 
class MainViewController: UIViewController, EGCDelegate {
    /**
        This method is called after the view controller has loaded
    */
    override func viewDidLoad() {
        super.viewDidLoad()

        // Init EGC and set delegate UIViewController
        EGC.sharedInstance(self)
        
        // Will not show automatic Game Center login page
        // EGC.showLoginPage = false

        // If you want see message debug
        // EGC.debugMode = true
    }
    /**
        Notifies the view controller that its view was added to a view hierarchy.
    */
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        // Set new view controller delegate, that's when you change UIViewController
        // If you have several UIViewController just add this in your UIViewControllers for set new Delegate
        EGC.delegate = self
    }
    
    /// ############################################################ ///
    ///        Mark: - Delegate function of EasyGameCenter           ///
    /// ############################################################ ///
    /**
        Listener Player is authentified 
        Optional function
    */
    func EGCAuthentified(authentified:Bool) {
        print("Player Authentified = \(authentified)")
    }
    /**
        Listener when Achievements is in cache
        Optional function
    */
    func EGCInCache() {
        // Call when GkAchievement & GKAchievementDescription in cache
    }
    
    /// ############################################################ ///
    ///  Mark: - Delegate function of EasyGameCenter for MultiPlaye  ///
    /// ############################################################ ///
    /**
        Listener When Match Started
        Optional function
    */
    func EGCMatchStarted() {
        print("MatchStarted")
    }
    /**
        Listener When Match Recept Data
        When player send data to all player
        Optional function
    */
    func EGCMatchRecept(match: GKMatch, didReceiveData data: NSData, fromPlayer playerID: String) {
        // See Packet Example in project
        let strucData =  Packet.unarchive(data)
        print("Recept From player = \(playerID)")
        print("Recept Packet.name = \(strucData.name)")
        print("Recept Packet.index = \(strucData.index)")
    }
    /**
        Listener When Match End
        Optional function
    */
    func EGCMatchEnded() {
        print("MatchEnded")
    }
    /**
        Listener When Match Cancel
        Optional function
    */
    func EGCMatchCancel() {
        print("Match cancel")
    }
``` 



###Show Methods
--------
####Show Achievements
* **Show Game Center Achievements with completion**
* **Option :** Without completion 
```swift 
    EGC.showGameCenterAchievements()
```
* **Option :** With completion
```swift
    EGC.showGameCenterAchievements { 
        (isShow) -> Void in
        if isShow {
                print("Game Center Achievements is shown")
        }
    }
```

####Show Leaderboard
* **Show Game Center Leaderboard  with completion**
* **Option :** Without completion 
```swift
    EGC.showGameCenterLeaderboard(leaderboardIdentifier: "IdentifierLeaderboard")
```
* **Option :** With completion
```swift
    EGC.showGameCenterLeaderboard(leaderboardIdentifier: "IdentifierLeaderboard") { 
        (isShow) -> Void in
        if isShow {
            print("Game Center Leaderboards is shown")
        }
    }
```

####Show Challenges
* **Show Game Center Challenges  with completion**
* **Option :** Without completion 
```swift 
    EGC.showGameCenterChallenges()
```
* **Option :** With completion 
```swift
    EGC.showGameCenterChallenges {
        (isShow) -> Void in
        if isShow {
            print("Game Center Challenges Is shown")
        }
    }
```

####Show authentification page Game Center
* **Show Game Center authentification page with completion**
* **Option :** Without completion 
```swift
    EGC.showGameCenterAuthentication()
```
* **Option :** With completion 
```swift
    EGC.showGameCenterAuthentication { 
        (result) -> Void in
        if result {
            print("Game Center Authentication is open")
        }
    }
```

####Show custom banner
* **Show custom banner Game Center with completion**
* **Option :** Without completion 
```swift
    EGC.showCustomBanner(title: "Title", description: "My Description...")
```
* **Option :** With completion 
```swift
    EGC.showCustomBanner(title: "Title", description: "My Description...") { 
        print("Custom Banner is finish to Show")
    }
```

###Achievements Methods<a id="Achievements-Methods"></a>
--------
<p align="center">
        <img src="http://g.recordit.co/K1I3O6BEXq.gif" height="500" width="280" />
</p>
####Progress Achievements
* **Add progress to an Achievement with show banner**
* **Option :** Report achievement 
```swift
    EGC.reportAchievement(progress: 42.00, achievementIdentifier: "Identifier")
```
* **Option :** Without show banner 
```swift 
    EGC.reportAchievement(progress: 42.00, achievementIdentifier: "Identifier", showBannnerIfCompleted: false)
```
* **Option :** Add progress to existing (addition to the old)
```swift
    EGC.reportAchievement(progress: 42.00, achievementIdentifier: "Identifier", addToExisting: true)
```
* **Option :** Without show banner & add progress to existing (addition to the old)
```swift
    EGC.reportAchievement(progress: 42.00, achievementIdentifier: "Identifier", showBannnerIfCompleted: false ,addToExisting: true)
```

####If Achievement completed 
* **Is completed Achievement**
```swift
    if EGC.isAchievementCompleted(achievementIdentifier: "Identifier") {
        print("\n[Easy Game Center]Yes\n")
    } else {
        print("\n[Easy Game Center] No\n")
    }
```

####Get All Achievements completed for banner not show
* **Get All Achievements completed and banner not show with completion**
```swift
    if let achievements : [GKAchievement] = EGC.getAchievementCompleteAndBannerNotShowing() {
        for oneAchievement in achievements  {
            print("\n[Easy Game Center] Achievement where banner not show \(oneAchievement.identifier)\n")
        }
    } else {
        print("\n[Easy Game Center] No Achievements with banner not showing\n")
    }
```

####Show all Achievements completed for banner not show
* **Show All Achievements completed and banner not show with completion**
* **Option :** Without completion 
```swift
    EGC.showAllBannerAchievementCompleteForBannerNotShowing()
```
* **Option :** With completion 
```swift
    EGC.showAllBannerAchievementCompleteForBannerNotShowing { 
        (achievementShow) -> Void in
        if let achievementIsOK = achievementShow {
            print("\n[Easy Game Center] Achievement show is \(achievementIsOK.identifier)\n")
        } else {
            print("\n[Easy Game Center] No Achievements with banner not showing\n")
        }
    }
```

####Get all Achievements GKAchievementDescription
* **Get all achievements descriptions (GKAchievementDescription) with completion**
```swift
    EGC.getGKAllAchievementDescription {
        (arrayGKAD) -> Void in
        if let arrayAchievementDescription = arrayGKAD {
            for achievement in arrayAchievementDescription  {
                print("\n[Easy Game Center] ID : \(achievement.identifier)\n")
                print("\n[Easy Game Center] Title : \(achievement.title)\n")
                print("\n[Easy Game Center] Achieved Description : \(achievement.achievedDescription)\n")
                print("\n[Easy Game Center] Unachieved Description : \(achievement.unachievedDescription)\n")
            }
        }
    }
```

####Get Achievements GKAchievement
* **Get One Achievement (GKAchievement)**
```swift
    if let achievement = EGC.getAchievementForIndentifier(identifierAchievement: "AchievementIdentifier") {
        print("\n[Easy Game Center] ID : \(achievement.identifier)\n")
    }
```

####Get Achievements GKAchievement GKAchievementDescription (Tuple)
* **Get Tuple ( GKAchievement , GKAchievementDescription) for identifier Achievement**
```swift
    EGC.getTupleGKAchievementAndDescription(achievementIdentifier: "AchievementIdentifier") {            
        (tupleGKAchievementAndDescription) -> Void in
        if let tupleInfoAchievement = tupleGKAchievementAndDescription {
            // Extract tuple
            let gkAchievementDescription = tupleInfoAchievement.gkAchievementDescription
            let gkAchievement = tupleInfoAchievement.gkAchievement
            // The title of the achievement.
            print("\n[Easy Game Center] Title : \(gkAchievementDescription.title)\n")
            // The description for an unachieved achievement.
            print("\n[Easy Game Center] Achieved Description : \(gkAchievementDescription.achievedDescription)\n")
        }
    }
```

####Achievement progress
* **Get Progress to an achievement**
```swift
    let progressAchievement = EGC.getProgressForAchievement(achievementIdentifier: "AchievementIdentifier")
```

####Reset all Achievements
* **Reset all Achievement**
* **Option :** Without completion 
```swift
    EGC.resetAllAchievements()
```
```swift
    EGC.resetAllAchievements { 
        (achievementReset) -> Void in
        print("\n[Easy Game Center] ID : \(achievementReset.identifier)\n")
    }
```

###Leaderboards Methods<a id="Leaderboards"></a>
--------
####Report
* **Report Score Leaderboard**
```swift
    EGC.reportScoreLeaderboard(leaderboardIdentifier: "LeaderboardIdentifier", score: 100)
```

####Get GKLeaderboard
* **Get GKLeaderboard with completion**
```swift
    EGC.getGKLeaderboard { 
        (resultArrayGKLeaderboard) -> Void in
        if let resultArrayGKLeaderboardIsOK = resultArrayGKLeaderboard {
            for oneGKLeaderboard in resultArrayGKLeaderboardIsOK  {
                print("\n[Easy Game Center] ID : \(oneGKLeaderboard.identifier)\n")
                print("\n[Easy Game Center] Title :\(oneGKLeaderboard.title)\n")
                print("\n[Easy Game Center] Loading ? : \(oneGKLeaderboard.loading)\n")
            }
        }
    }
```

####Get GKScore
* **Get GKScore Leaderboard with completion**
```swift
    EGC.getGKScoreLeaderboard(leaderboardIdentifier: "LeaderboardIdentifier") {
        (resultGKScore) -> Void in
        if let resultGKScoreIsOK = resultGKScore as GKScore? {
            print("\n[Easy Game Center] Leaderboard Identifier : \(resultGKScoreIsOK.leaderboardIdentifier)\n")
            print("\n[Easy Game Center] Date : \(resultGKScoreIsOK.date)\n")
            print("\n[Easy Game Center] Rank :\(resultGKScoreIsOK.rank)\n")
            print("\n[Easy Game Center] Hight Score : \(resultGKScoreIsOK.value)\n")
        }
    }
```

####Get Hight Score (Tuple)
* **Get Hight Score Leaderboard with completion, (Tuple of name,score,rank)**
```swift
    EGC.getHighScore(leaderboardIdentifier: "LeaderboardIdentifier") {
        (tupleHighScore) -> Void in
        //(playerName:String, score:Int,rank:Int)?
        if let tupleIsOk = tupleHighScore {
            print("\n[Easy Game Center] Player name : \(tupleIsOk.playerName)\n")
            print("\n[Easy Game Center] Score : \(tupleIsOk.score)\n")
            print("\n[Easy Game Center] Rank :\(tupleIsOk.rank)\n")
        }
    }
```

###MultiPlayer <a id="MultiPlayer"></a>
--------
<p align="center">
        <img src="http://g.recordit.co/ApqB4QkOEv.gif" height="500" width="280" />
</p>

###MultiPlayer Methods <a id="MultiPlayer-Methods"></a>
--------
####Find player By number of player
* **Find Player By min and max player**
```swift
    EGC.findMatchWithMinPlayers(2, maxPlayers: 4)
```

####Send Data to all Player
* **Send Data to all Player (NSData)**
```swift
    // Example Struc
    var myStruct = Packet(name: "My Data to Send !", index: 1234567890, numberOfPackets: 1)
    
    //Send Data
    EGC.sendDataToAllPlayers(myStruct.archive(), modeSend: .Reliable): 4)
```

####Get Player in match
* **Get Player in match return Set**
```swift
    if let players = EGC.getPlayerInMatch() {
        for player in players{
            print(player.alias)
        }
    }
```

####Get match
* **Get current match**
```swift
    if let match = EGC.getMatch() {
        print(match)
    }
```

####Disconnect Match / Stop
* **Disconnect Match or Stop for send data to all player in match**
```swift
    EGC.disconnectMatch()
```

###Other methods Game Center <a id="other-methods"></a>
--------
####Player identified to Game Center
* **Is player identified to gameCenter**
```swift
    if EGC.isPlayerIdentified { /* Player identified */ }
```

####Get Local Player
* **Get local Player (GKLocalPlayer)**
```swift
    let localPlayer = EGC.getLocalPlayer()
```

####Get information on Local Player
```swift
    EGC.getlocalPlayerInformation {
        (playerInformationTuple) -> () in
        //playerInformationTuple:(playerID:String,alias:String,profilPhoto:UIImage?)
            
        if let typleInformationPlayer = playerInformationTuple {
                
            self.PlayerID.text = "Player ID : \(typleInformationPlayer.playerID)"
            self.Name.text = "Name : \(typleInformationPlayer.alias)"
            self.PlayerAuthentified.text = "Player Authentified : True"
                
            if let haveProfilPhoto = typleInformationPlayer.profilPhoto {
                self.PlayerProfil.image = haveProfilPhoto
            }
                
        }
    }
```

###NetWork
--------
* **Is Connected to NetWork**
```swift
    if EGC.isConnectedToNetwork { /* You have network */ } 
```

###Hidden automatique login of Game Center
--------
* **Hidden automatique page for login to Game Center, if player not login**
```swift
    EGC.showLoginPage = false
```

###Debug Mode
--------
* **If you doesn't want see message of Easy Game Center**
```swift
    // If you doesn't want see message Easy Game Center, delete this ligne
    // EGC.debugMode = true
```

###Legacy support
For support of iOS 7+ & iOS 8+ 

[@RedWolfStudioFR](https://twitter.com/RedWolfStudioFR) 

[@YannickSteph](https://twitter.com/YannickSteph)

Yannick Stephan works hard to have as high feature parity with **Easy Game Center** as possible. 

###License
The MIT License (MIT)

Copyright (c) 2015 Red Wolf Studio, Yannick Stephan

[Red Wolf Studio](http://www.redwolfstudio.fr)

[Yannick Stephan](http://yannickstephan.com)
