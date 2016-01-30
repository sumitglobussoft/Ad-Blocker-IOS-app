//
//  ActionRequestHandler.swift
//  BlockerFinalG
//
//  Created by GBS-ios on 12/1/15.
//  Copyright © 2015 globussoft. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionRequestHandler: NSObject, NSExtensionRequestHandling {

    func beginRequestWithExtensionContext(context: NSExtensionContext)
    {
       
        let groupUrl = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier("group.Caviar")
        let sharedContainerPathLocation = groupUrl?.path
        
        let filePath = sharedContainerPathLocation! + "/secondList.json"
        let fileUrl = NSURL(fileURLWithPath: filePath)
        
        let attachment = NSItemProvider(contentsOfURL: fileUrl)!
        
        let item = NSExtensionItem()
        item.attachments = [attachment]
        
        context.completeRequestReturningItems([item], completionHandler: nil);

        
        
//        let attachment = NSItemProvider(contentsOfURL: NSBundle.mainBundle().URLForResource("blockerList", withExtension: "json"))!
//        let item = NSExtensionItem()
//        
//        let dataDefault: NSUserDefaults = NSUserDefaults(suiteName:"group.Caviar")!
//        let dataSring:NSData
//        dataSring = dataDefault.objectForKey("data")!.dataUsingEncoding(NSUTF8StringEncoding)!
//        let attachment1 = NSItemProvider(item:dataSring, typeIdentifier: kUTTypeJSON as String)
//        
//        
//        item.attachments = [attachment,attachment1]
//        
//        context.completeRequestReturningItems([item], completionHandler: nil);

       
        /*

        let dataDefault: NSUserDefaults = NSUserDefaults(suiteName:"group.sukAdBlocker")!

        let attachment = NSItemProvider(contentsOfURL: NSBundle.mainBundle().URLForResource("blockerList", withExtension: "json"))!
    
        let item = NSExtensionItem()
        item.attachments = [attachment]
    
        context.completeRequestReturningItems([item], completionHandler: nil);*/
  //  }

   }
    
}
