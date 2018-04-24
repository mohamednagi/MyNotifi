import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .alert, .sound]) { (success, error) in
            if error == nil{
                print("Auth is perfect")
            } } }
    @IBAction func BuNotification(_ sender: UIButton) {
        TimedNotification(inSeconds: 3) { (success) in
            if success{
                print("Successfully notified")
            } } }
    func TimedNotification(inSeconds:TimeInterval, completion: @escaping (_ success:Bool) -> ()){
        
        guard let imageURL = Bundle.main.url(forResource: "giphy", withExtension: "gif") else{
            completion(false)
            return
        }
        let attachment = try! UNNotificationAttachment(identifier: "giphy", url: imageURL, options: .none)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        let content = UNMutableNotificationContent()
        content.title = "this is my title"
        content.subtitle = "this is my subtitle one"
        content.body = "this is my body :D"
        content.attachments = [attachment]
        let request = UNNotificationRequest(identifier: "customNotification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if error == nil{
                completion(true)
            }else{
                completion(false)
            } } } }
