import UIKit
protocol SelectCityDeletage {
    func selectCity(city:String)
}

class SelectCityController: UIViewController {
    var city = ""
    var delegate: SelectCityDeletage?
    @IBAction func disMiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var cityInput: UITextField!
    
    @IBAction func selectCity(_ sender: UIButton) {
        delegate?.selectCity(city: cityInput.text!)
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var curretCity: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        cityInput.becomeFirstResponder()
        curretCity.text = city
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
