import SwiftUI
import UnisseySdk

struct ContentView: View {
    @State var videoUri: URL?
    
    @ObservedObject var unisseyViewModel: UnisseyViewModel
    
    init() {
        let sessionConfig = SessionConfig(uiConfig: UiConfig())
        unisseyViewModel = UnisseyViewModel(acquisitionPreset: .selfieFast, sessionConfig: sessionConfig)
    }

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
                        unisseyViewModel.onRecordEndedListener = { result in
                            do {
                                let response = try result.get()
                                print("Video record ended with file path: '\(response.videoFilePath)'")
                                videoUri = response.videoFilePath
                            } catch {
                                print("An error occurred while recording the video: \(error)")
                            }
                        }
                    }
                NavigationLink(destination: VideoPlayerView(videoUri: videoUri,
                                                            onRestartButtonClicked: {
                    unisseyViewModel.navigateUp()
                    videoUri = nil
                }), isActive: .constant(videoUri != nil)) { EmptyView() }
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
