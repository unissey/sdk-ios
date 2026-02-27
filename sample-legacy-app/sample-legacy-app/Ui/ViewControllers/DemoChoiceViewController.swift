import UIKit

class DemoChoiceViewController: UIViewController {
    
    @IBOutlet weak var uiDemoButton: UIButton!
    @IBOutlet weak var headlessDemoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the `UI Demo` button
        uiDemoButton.setTitle(NSLocalizedString("ui_demo_button_title", comment: ""), for: .normal)
        uiDemoButton.addAction(UIAction(title: "uiDemo", handler: { _ in
            self.performSegue(withIdentifier: "demoChoiceViewToUnisseyUiView", sender: nil)
        }), for: .touchUpInside)
        
        // Set up the `UI Demo` button
        headlessDemoButton.setTitle(NSLocalizedString("headless_demo_button_title", comment: ""), for: .normal)
        headlessDemoButton.addAction(UIAction(title: "headlessDemo", handler: { _ in
            self.performSegue(withIdentifier: "demoChoiceViewToUnisseyHeadlessView", sender: nil)
        }), for: .touchUpInside)
    }
}
