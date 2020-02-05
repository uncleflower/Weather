import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    var appid = "6ccf12049ccc08bf39c0e6d4a4100db9"
    let weather = Weather()
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    
    var locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestLocation()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        locationManager.requestWhenInUseAuthorization()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lat = locations[0].coordinate.latitude
        let lon = locations[0].coordinate.longitude
        
        let parameters = ["lat": "\(lat)","lon": "\(lon)","appid": appid]
        getWeather(parameters: parameters)
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "select" {
            let vc = segue.destination as! SelectCityController
            vc.city = weather.citiy
            vc.delegate = self
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
    
extension ViewController:CLLocationManagerDelegate,SelectCityDeletage {
    func selectCity(city: String) {
        let parameters = ["q":"\(city)","appid":appid]
        getWeather(parameters: parameters)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    func getWeather(parameters:[String:String]) {
        Alamofire.request("https://api.openweathermap.org/data/2.5/weather?",parameters: parameters).responseJSON { response in
            
            if let json = response.result.value {
                print("JSON: \(json)")
                let weatherJSON = JSON(json)
                self.createWeather(weatherJSON: weatherJSON)
                self.updateUI()
                
            }
        }
    }
    func createWeather(weatherJSON: JSON) {
        weather.citiy = weatherJSON["name"].stringValue
        weather.condition = weatherJSON["weather",0,"id"].intValue
        weather.temp = Int(round(weatherJSON["main","temp"].doubleValue - 274.15))
    }
    func updateUI() {
        cityLabel.text = self.weather.citiy
        tempLabel.text = "\(self.weather.temp)" + "˚"
        weatherImage.image = UIImage(named: self.weather.icon)
    }
}


