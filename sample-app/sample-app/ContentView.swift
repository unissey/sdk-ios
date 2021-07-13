//
//  ContentView.swift
//  sample-app
//
//  Created by Felix Maury on 24/06/2021.
//

import AVKit
import Deepsense
import SwiftUI

struct ContentView: View {
    @State var videoUrl: URL?

    var body: some View {
        NavigationView {
            VStack {
                if let videoUrl = videoUrl {
                    Spacer()
                    VideoPlayer(player: AVPlayer(url: videoUrl))
                        .frame(height: 400)
                        .navigationBarTitle("Captured Video")
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: { self.videoUrl = nil }) {
                            Text("RESET")
                                .foregroundColor(.red)
                                .font(.title)
                        }
                        .padding(.bottom)
                        Spacer()
                    }
                } else {
                    DSWidgetView(onVideoCapture: { capture in
                        guard var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
                        url.appendPathComponent("video.mov") // or whatever extension the video is
                        if (try? capture.video.write(to: url)) != nil {
                            self.videoUrl = url
                        }
                    })
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
