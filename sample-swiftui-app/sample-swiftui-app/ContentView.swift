import SwiftUI
import UnisseySdk

struct ContentView: View {
    @State var videoUri: URL?
    
    @ObservedObject var unisseyViewModel = UnisseyViewModel(acquisitionPreset: .selfieFast)

    var body: some View {
        NavigationView {
            VStack {
                UnisseyView(unisseyViewModel: unisseyViewModel)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            if unisseyViewModel.currentPage != .instructions {
                                Button {
                                    unisseyViewModel.navigateUp()
                                } label: {
                                    HStack {
                                        Image(systemName: "chevron.backward")
                                        Text("back")
                                    }
                                }
                            }
                        }
                    }
                    .onAppear {
                        videoUri = nil
                    }
                    .task {
                        for await event in unisseyViewModel.cameraEvents.values {
                            if case .videoRecordEnded(let response) = event {
                                print("Video record ended with file path: '\(response.videoFilePath)'")
                                videoUri = response.videoFilePath
                            }
                        }
                    }
                NavigationLink(destination: VideoPlayerView(videoUri: videoUri,
                                                            onRestartButtonClick: {
                    unisseyViewModel.navigateUp()
                    videoUri = nil
                }), isActive: .constant(videoUri != nil)) { EmptyView() }
            }
        }
        .navigationViewStyle(.stack)
    }
}

#Preview {
    ContentView()
}
