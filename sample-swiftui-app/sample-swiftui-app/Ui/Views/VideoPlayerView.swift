import AVKit
import SwiftUI

public struct VideoPlayerView: View {
    var videoUri: URL?
    var onRestartButtonClick: () -> Void
    
    public var body: some View {
        VStack {
            if let videoUri = videoUri {
                VideoPlayer(player: AVPlayer(url: videoUri))
                    .frame(maxHeight: 600)
            }
            Spacer()
            Button(action: onRestartButtonClick) {
                Text("restart")
            }
            Spacer()
        }
    }
}

#Preview {
    VideoPlayerView(videoUri: URL(fileURLWithPath: ""), onRestartButtonClick: {})
}
