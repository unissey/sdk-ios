import AVKit
import SwiftUI

public struct VideoPlayerView: View {
    var videoUri: URL?
    var onRestartButtonClicked: () -> Void
    
    public var body: some View {
        VStack {
            if let videoUri = videoUri {
                VideoPlayer(player: AVPlayer(url: videoUri))
                    .frame(maxHeight: 600)
            }
            Spacer()
            Button(action: onRestartButtonClicked) {
                Text("restart")
            }
            Spacer()
        }
    }
}

struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerView(videoUri: URL(fileURLWithPath: ""), onRestartButtonClicked: {})
    }
}
