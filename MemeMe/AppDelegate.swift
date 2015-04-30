//
//  AppDelegate.swift
//  MemeMe
//
//  Created by Sanjib Ahmad on 4/26/15.
//  Copyright (c) 2015 Object Coder. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var memes = [Meme]()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Meme test data - uncomment for testing
//        memes.append(Meme(
//            topText: "Legend of the Scarlet Blades",
//            bottomText: "Writer : Saverio Tenuta. Art : Saverio Tenuta",
//            originalImage: UIImage(named: "LegendScarletBlades")!,
//            memeImage: UIImage(named: "LegendScarletBlades")!))
//        memes.append(Meme(
//            topText: "The Swords of Glass",
//            bottomText: "Writer : Sylviane Corgiat. Art : Laura Zuccheri",
//            originalImage: UIImage(named: "TheSwordsOfGlass")!,
//            memeImage: UIImage(named: "TheSwordsOfGlass")!))
//        memes.append(Meme(
//            topText: "The Incal",
//            bottomText: "Writer : Alexandro Jodorowsky. Art : Jean Giraud, Zoran Janjetov, Moebius. Cover artist : Jos, Jean Giraud. Colorist : Val",
//            originalImage: UIImage(named: "TheIncal")!,
//            memeImage: UIImage(named: "TheIncal")!))
//        memes.append(Meme(
//            topText: "The White Lama",
//            bottomText: "Writer : Alexandro Jodorowsky. Art : Georges Bess",
//            originalImage: UIImage(named: "TheWhiteLama")!,
//            memeImage: UIImage(named: "TheWhiteLama")!))
//        memes.append(Meme(
//            topText: "Angel Claws",
//            bottomText: "Art : Moebius. Writer : Alexandro Jodorowsky",
//            originalImage: UIImage(named: "Angelclaws")!,
//            memeImage: UIImage(named: "Angelclaws")!))
//        memes.append(Meme(
//            topText: "Muse",
//            bottomText: "Art : Terry Dodson. Writer : Denis-Pierre Filippi",
//            originalImage: UIImage(named: "Muse")!,
//            memeImage: UIImage(named: "Muse")!))
//        memes.append(Meme(
//            topText: "The Eyes of the Cat",
//            bottomText: "Writer : Alexandro Jodorowsky. Art : Moebius",
//            originalImage: UIImage(named: "TheEyesOfTheCat")!,
//            memeImage: UIImage(named: "TheEyesOfTheCat")!))
//        memes.append(Meme(
//            topText: "Cape Horn",
//            bottomText: "Writer : Christian Perrissin. Art : Enea Riboldi",
//            originalImage: UIImage(named: "CapeHorn")!,
//            memeImage: UIImage(named: "CapeHorn")!))
//        memes.append(Meme(
//            topText: "The Metabarons",
//            bottomText: "Writer : Alexandro Jodorowsky. Art : Juan Gimenez",
//            originalImage: UIImage(named: "TheMetabarons")!,
//            memeImage: UIImage(named: "TheMetabarons")!))
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

