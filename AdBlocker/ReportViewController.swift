//
//  ReportViewController.swift
//  BlockerFinal
//
//  Created by GBS-ios on 12/3/15.
//  Copyright © 2015 globussoft. All rights reserved.
//

import UIKit

class ReportViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet var urlTextField: UITextField!
    
    @IBOutlet var commentOnTextField: UITextField!
    @IBAction func segmentActoin(sender: AnyObject) {
        
    }
    @IBAction func submitAction(sender: AnyObject)
    {
        if (self.urlTextField.text?.characters.count==0){
            
            self.urlTextField.layer.borderColor=UIColor .redColor().CGColor;
            self.urlTextField.layer.borderWidth=1.0
            
        }else if (self.commentOnTextField.text?.characters.count==0)
        {
            
            self.commentOnTextField.layer.borderColor=UIColor .redColor().CGColor;
             self.commentOnTextField.layer.borderWidth=1.0
          
        }
        else{
        self.postRequest()
        }
        self .resignFirstResponder()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.urlTextField.delegate=self
        self.commentOnTextField.delegate=self
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Text Field Delegates
    func textFieldDidBeginEditing(textField: UITextField) {
        
        //delegate method
        
        if(textField==self.urlTextField){
            self.urlTextField.layer.borderColor=UIColor .clearColor().CGColor;
             self.urlTextField.layer.borderWidth=1.0
        }
        else if(textField==self.commentOnTextField){
            self.commentOnTextField.layer.borderColor=UIColor .clearColor().CGColor;
             self.commentOnTextField.layer.borderWidth=1.0
        }
        
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {  //delegate method
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    // MARK: - Service Integration
    func postRequest()
    {
        let request = NSMutableURLRequest(URL: NSURL(string: "http://adblock.globusapps.com/report-site")!)
        request.HTTPMethod = "POST"
        let postString = String(format: "url=%@&comment=%@",self.urlTextField.text!, self.commentOnTextField.text!)
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            print("response = \(response)")
            let responseString:String = String(data: data!, encoding: NSUTF8StringEncoding)!
            
            print(responseString)
            
            var userInfo: [String: AnyObject] = self.convertStringToDictionary(responseString)!
            print("responseString = \(userInfo["code"])")
            self .performSelectorOnMainThread(Selector("addAlert:"), withObject:userInfo["message"], waitUntilDone:true)
        }
        task.resume()
    }
    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [String:AnyObject]
                return json
            } catch {
                print("Something went wrong")
            }
        }
        return nil
    }
    func addAlert(object:String)
    {
        let alert = UIAlertController(title:"Message", message:object, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
        self.urlTextField.text="";
        self.commentOnTextField.text="";
        
        
    }
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
