//
//  ContentView.swift
//  sample-app
//
//  Created by Felix Maury on 24/06/2021.
//

import SwiftUI
import Deepsense

struct ContentView: View {
    @State var video: Data?
    
    var body: some View {
        NavigationView {
            VStack {
                DSWidgetView(onVideoCapture: { capture in
//                    self.video = capture
                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
