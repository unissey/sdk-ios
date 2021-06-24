//
//  ContentView.swift
//  sample-app
//
//  Created by Felix Maury on 24/06/2021.
//

import Deepsense
import SwiftUI
import AVKit

struct ContentView: View {
    @State var videoUrl: URL?

    var body: some View {
        NavigationView {
            VStack {
                if let videoUrl = videoUrl {
                    Spacer()
                    VideoPlayer(player: AVPlayer(url: videoUrl))
                        .frame(height: 400)
                    Spacer()
                } else {
                    DSWidgetView(onVideoCapture: { capture in
                        guard var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
                        url.appendPathComponent("video.mpeg") // or whatever extension the video is
                        if ((try? capture.video.write(to: url)) != nil) {
                            self.videoUrl = url
                        }
                    })
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
