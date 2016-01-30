//
//  ViewController.swift
//  BlockerFinal
//
//  Created by GBS-ios on 12/1/15.
//  Copyright © 2015 globussoft. All rights reserved.
//

import UIKit
import SafariServices
class ViewController: UIViewController,SFSafariViewControllerDelegate  {

    var downloadParse:NSArray? = nil
    var parseArray:NSMutableArray=[]
     var actInd: UIActivityIndicatorView = UIActivityIndicatorView()
    var loadingView: UIView = UIView()
    private var urlString:String = "http://adblock.globusapps.com/testWebView.html"
    
    var parseDictionary:NSMutableDictionary = [:]
    var listString:String=""
    


    @IBAction func clickHereButton(sender: AnyObject) {
        self.gifImageView.hidden=false
        createWelcomeScreen()
        
    }
    @IBOutlet var gifImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.showActivityIndicatory()
        
        self .readAndStoreInNsuserDefault();
        
      //  actInd.stopAnimating()
        
       
       NSURLCache.sharedURLCache().removeAllCachedResponses()
        
        
        

        
        // Do any additional setup after loading the view, typically from a nib.
     
          // self.reloadContentBlocker()

        
    }
    func createWelcomeScreen()
    {
    
        let url:NSURL = NSBundle.mainBundle().URLForResource("Caviar+", withExtension:"gif")!;
        self.gifImageView.image=UIImage.animatedImageWithAnimatedGIFData(
            NSData(contentsOfURL: url))
        self.gifImageView.animationRepeatCount=1;
    self.performSelector(Selector("removeImageGif"), withObject:self, afterDelay:9)
        
    }
    
    func removeImageGif()
    {
        self.gifImageView.image=nil;
        self.gifImageView.hidden=true;
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func updateBlockerList(sender: AnyObject)
    {
          NSURLCache.sharedURLCache().removeAllCachedResponses()
        
            
            self.fetchFromParse()
            

            
                }
    
    func updateFunc(){
        let fileManager = NSFileManager()
        let groupUrl = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier("group.Caviar")
        let sharedContainerPathLocation = groupUrl?.path
        
        var mergeString:String
        
        do {
            
            // let webList:[NSDictionary]=self.stringToDict(datastring!)
            // mergedList.appendContentsOf(webList)
            
            //print(mergedList)
            
        } catch {
            print("Something went wrong")
        }
        
        
        
        
        do{
            
            
           print(self.parseArray.count)
          // print(self.parseArray)
            
            
            let data = try NSJSONSerialization.dataWithJSONObject(self.parseArray, options: NSJSONWritingOptions.PrettyPrinted)
            
            mergeString = String(data: data, encoding: NSUTF8StringEncoding)!
            //  print(mergeString)
            
            var mergeDict:[NSDictionary]=self.stringToDict(mergeString)
            
            let listDict:[NSDictionary]=self.convertStringToDictionary(self.listString)
            
            mergeDict.appendContentsOf(listDict)
            
            
            // print(mergeDict)
            
            
            
            
            
            
            
            
            
            let baseListPath = sharedContainerPathLocation! + "/secondList.json"
            if !fileManager.fileExistsAtPath(baseListPath) {
                fileManager.createFileAtPath(baseListPath, contents: self.dictToString(mergeDict).dataUsingEncoding(NSUTF8StringEncoding), attributes: nil)
            } else {
                try! self.dictToString(mergeDict).writeToFile(baseListPath, atomically: true, encoding: NSUTF8StringEncoding)
            }
            
            
        }
        catch{
            
        }
        
        
        
        self.reloadContentBlocker()
        
        loadingView.hidden=true
        actInd.stopAnimating()
        
        NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: Selector("testBlocking"), userInfo: nil, repeats: false)

        
//       self
//        .performSelector("self.testBlocking()", withObject:nil, afterDelay: 3)
        
  //self.testBlocking()
        
        
        
        
        
        
        
        
        
        

    }
    
    func testBlocking(){
       let svc = SFSafariViewController(URL: NSURL(string: self.urlString)!,entersReaderIfAvailable:true)
        svc.delegate=self;
      svc.view.frame=CGRectMake(0, 0, 200 , 250);
        
   // self.presentViewController(svc, animated: true, completion: nil)
        self.addChildViewController(svc)
       self.view.addSubview(svc.view)
//        self.view.insertChildViewController(svc, atIndex: 0)

    }
 func safariViewController(controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool){
        
        
        //svc.view.hidden=true
        
    }
    //--------------------------------------------------------------
    //--------------------------------------------
         func reloadContentBlocker()
    {
        SFContentBlockerManager.reloadContentBlockerWithIdentifier("com.gobussoft.AdBlocker.BlockerListAd") {
            (error) in
            print("Reloaded: \(error)")
            self.loadingView.hidden=true
            self.actInd.stopAnimating()
        }
   
    }
//    public func webViewDidFinishLoad(webView: UIWebView){
////        NSString * jsCallBack = [NSString stringWithFormat:@"myFunction()"];
////        [webView stringByEvaluatingJavaScriptFromString:jsCallBack];
//        
//        webView.stringByEvaluatingJavaScriptFromString("myFunction()")
//        //[webView stringByEvaluatingJavaScriptFromString:@"myFunction()"]
//    }
//    func test()
//    {
//        
//        let groupUrl = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier("group.Caviar")
//        
//        let sharedContainerPathLocation = groupUrl?.path
//        
//        let filePath = sharedContainerPathLocation! + "/blockerList1.json"
//        let fileUrl = NSURL(fileURLWithPath: filePath)
//        
//       
//
//      
//    }
//    

    
    func readAndStoreInNsuserDefault()
    {
        
        
        let mergedList:[NSDictionary] = itemsFromFile("blockerList")
        
        let fileManager = NSFileManager()
        let groupUrl = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier("group.Caviar")
        let sharedContainerPathLocation = groupUrl?.path
        
        
        do{
            
            let data = try NSJSONSerialization.dataWithJSONObject(mergedList, options: NSJSONWritingOptions.PrettyPrinted)
            
            listString = String(data: data, encoding: NSUTF8StringEncoding)!
         // print(listString)
            
            
            let baseListPath = sharedContainerPathLocation! + "/secondList.json"
            if !fileManager.fileExistsAtPath(baseListPath) {
                fileManager.createFileAtPath(baseListPath, contents: listString.dataUsingEncoding(NSUTF8StringEncoding), attributes: nil)
            } else {
              
                
             try! listString.writeToFile(baseListPath, atomically: true, encoding: NSUTF8StringEncoding)
            }
            
            
        }
        catch{
            
        }
        self.reloadContentBlocker()
        
        
       

    }
    // MARK: - String to Array
    func convertStringToDictionary(text: String)->[NSDictionary]
    {
        let emptyObject:[NSDictionary]=[]
        
       // let emptyObject:NSMutableArray! = NSMutableArray()

        if let data = text.dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
                return json as! [NSDictionary];

            } catch {
                print("Something went wrong")
            }
        }
        return emptyObject
    }
    @IBAction func openContentBlockerInSetting(sender: AnyObject)
    {
       UIApplication.sharedApplication().openURL(NSURL(string:"prefs:root=Safari")!)
    }
    
    
    func stringToDict(text: String) -> [NSDictionary] {
        var dict:NSArray
        if let data = text.dataUsingEncoding(NSUTF8StringEncoding)
        {
            var      error: NSError?
            
            do{
                
                dict = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 1)) as! NSArray
                
                if error != nil {
                    //println(error)
                }
                return dict as! [NSDictionary]
            }
            catch{
                
            }
            
        }
        return []
        
    }
func encodeDownloadedData()
{
    
}
    func fetchFromParse()
  {
    self.showActivityIndicatory()
  
    self.parseArray=NSMutableArray()
          let query = PFQuery(className:"BlockerList")
    
    query.limit=1000
        // Array for object ids
    
 
        query.findObjectsInBackgroundWithBlock{(objects,error)-> Void in
            if error == nil {
                for object in objects!
                {
                    let handlerObj = HandlerObjectiveC.init()
                                    let tempDict:NSMutableDictionary = handlerObj.generateRules(object) as! NSMutableDictionary
                                    self.parseArray.addObject(tempDict)
                }
                self.updateFunc()
   }
        }
        
  
    }

    

 func itemsFromFile(name: String) -> [NSDictionary] {
    let url = NSBundle.mainBundle().URLForResource(name, withExtension: "json")
    let data = NSData(contentsOfURL: url!)
    do{
        
        //        try // print(NSJSONSerialization.JSONObjectWithData(data!, options: [])as! [NSDictionary])
        //
        
        return try! NSJSONSerialization.JSONObjectWithData(data!, options: []) as! [NSDictionary]
    }
    catch{
        
    }
    return []
}
func dictToString(dict:[NSDictionary])->NSString
{
    var jsonString:NSString = ""
    do{
        
        let jsonData = try NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions.init(rawValue: 2))
        
        jsonString = NSString(data: jsonData, encoding: NSUTF8StringEncoding)! as String
    }
    catch
    {
        
    }
    return jsonString
}
    
    
    func showActivityIndicatory() {
//        var container: UIView = UIView()
//        container.frame = uiView.frame
//        container.center = uiView.center
//        container.backgroundColor=UIColor.blackColor()
//       //     (0xffffff, alpha: 0.3)
        
             loadingView.frame = CGRectMake(0, 0, 80, 80)
        loadingView.center = self.view.center
        loadingView.backgroundColor=UIColor.blackColor()
            //UIColorFromHex(0x444444, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.hidden=false
        loadingView.layer.cornerRadius = 10
        self.view.addSubview(loadingView)
        
       
        actInd.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
        actInd.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.WhiteLarge
        actInd.center = CGPointMake(loadingView.frame.size.width / 2,
            loadingView.frame.size.height / 2);
        loadingView.addSubview(actInd)
       // container.addSubview(loadingView)
      //  uiView.addSubview(container)
        actInd.startAnimating()
    }
}