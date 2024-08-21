import Foundation
import SwiftUI
import UnisseySdk

class UnisseyHostingController: UIHostingController<UnisseyView> {
    
    var videoUri: URL?
    let unisseyViewModel: UnisseyViewModel
    let customBackButton: UIBarButtonItem
    
    required init?(coder: NSCoder) {
        // Set up a custom Back button with the system back button's UI
        let backButtonImage = UIImage(systemName: "chevron.backward", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold))!
        let backButton = UIButton(type: .custom)
        backButton.setImage(backButtonImage, for: .normal)
        backButton.setTitle(NSLocalizedString("back", comment: "back"), for: .normal)
        backButton.setTitleColor(.systemBlue, for: .normal)
        backButton.frame = CGRect(x: 0, y: 0, width: Int(backButtonImage.size.width), height: Int(backButtonImage.size.height))
        backButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0)
        customBackButton = UIBarButtonItem(customView: backButton)
        
        // Set up the UnisseyViewModel and UnisseyView
        unisseyViewModel = UnisseyViewModel(acquisitionPreset: .selfieFast)

        let unisseyView = UnisseyView(unisseyViewModel: unisseyViewModel)
        super.init(coder: coder, rootView: unisseyView)
    }
    
    override func viewDidLoad() {
        // Register the callbacks
        unisseyViewModel.onRecordEndedListener = { result in
            do {
                // `result` is a Result<SessionResponse, Error> containing the response or an error
                let response = try result.get()
                print("Video record ended with file path: '\(response.videoFilePath)'")
                self.videoUri = response.videoFilePath
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "unisseyViewToPlayerView", sender: nil)
                }
            } catch {
                print("An error occurred while recording the video: \(error)")
            }
        }
        
        unisseyViewModel.onStateChangedListener = { _ in
            DispatchQueue.main.async {
                if self.unisseyViewModel.currentPage != .instructions {
                    self.navigationItem.leftBarButtonItem = self.customBackButton
                } else {
                    self.navigationItem.leftBarButtonItem = nil
                }
            }
        }
        
        // Navigate up when the user clicks on the button
        (customBackButton.customView as? UIButton)?.addAction(UIAction(title: "back", handler: { _ in
            self.unisseyViewModel.navigateUp()
        }), for: .touchUpInside)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let playerViewController = segue.destination as? VideoPlayerViewController {
            playerViewController.videoUri = videoUri!
            playerViewController.onRestartButtonClick = {
                self.unisseyViewModel.navigateUp()
                self.videoUri = nil
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
}
