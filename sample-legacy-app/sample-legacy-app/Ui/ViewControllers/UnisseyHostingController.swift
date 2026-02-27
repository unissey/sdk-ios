import Combine
import Foundation
import SwiftUI
import UnisseySdk

class UnisseyHostingController: UIHostingController<UnisseyView> {
    
    var videoUri: URL?
    let unisseyViewModel: UnisseyViewModel
    
    private var cancellables = Set<AnyCancellable>()
    
    required init?(coder: NSCoder) {
        // Set up the UnisseyViewModel and UnisseyView
        unisseyViewModel = UnisseyViewModel(acquisitionPreset: .selfieFast)

        let unisseyView = UnisseyView(unisseyViewModel: unisseyViewModel)
        super.init(coder: coder, rootView: unisseyView)
    }
    
    override func viewDidLoad() {
        // React to Unissey's events
        unisseyViewModel.cameraEvents
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                guard let self else { return }
                
                if case let .videoRecordEnded(response) = event {
                    print("Video record ended with file path: '\(response.videoFilePath)'")
                    self.videoUri = response.videoFilePath
                    self.performSegue(withIdentifier: "unisseyUiViewToPlayerView", sender: nil)
                }
            }
            .store(in: &cancellables)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        cancellables.forEach { $0.cancel() }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let playerViewController = segue.destination as? VideoPlayerViewController {
            playerViewController.videoUri = videoUri!
            playerViewController.onRestartButtonClick = {
                _ = self.unisseyViewModel.navigateUp()
                self.videoUri = nil
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
}
