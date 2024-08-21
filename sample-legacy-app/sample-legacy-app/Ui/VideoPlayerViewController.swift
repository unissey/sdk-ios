import AVFoundation
import AVKit
import UIKit

class VideoPlayerViewController: UIViewController {
    
    var videoUri: URL!
    var onRestartButtonClick: (() -> Void)!
    var player: AVPlayer?
    
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var restartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up the video player
        player = AVPlayer(url: videoUri)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        playerViewController.view.frame = videoView.bounds
        playerViewController.showsPlaybackControls = true
        playerViewController.videoGravity = .resizeAspectFill
        
        addChild(playerViewController)
        videoView.addSubview(playerViewController.view)
        player?.play()
        
        // Set up the `Restart` button
        restartButton.addAction(UIAction(title: "restart", handler: { _ in
            self.onRestartButtonClick()
        }), for: .touchUpInside)
    }

}
