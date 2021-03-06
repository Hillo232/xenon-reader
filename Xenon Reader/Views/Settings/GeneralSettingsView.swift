//
//  GeneralSettingsView.swift
//  Xenon Reader
//
//  Created by H. Kamran on 2/16/21.
//

import SwiftUI

struct GeneralSettingsView: View {
    @AppStorage("fontSize") var fontSize = 12.0
    @AppStorage("libraryPath") var libraryPath = ""
    @AppStorage("libraryUrl") var libraryUrl = ""

    var body: some View {
        Form {
            HStack {
                Text(libraryPath)

                Button("Select Folder") {
                    let panel = NSOpenPanel()
                    
                    panel.allowsMultipleSelection = false
                    panel.canChooseDirectories = true
                    panel.canChooseFiles = false

                    panel.title = "Xenon Reader Library Path"
                    panel.message = "Where your EPUBs are stored"
                    panel.prompt = "Select"

                    if panel.runModal() == .OK {
                        let libraryPath = panel.url?.absoluteString ?? FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].absoluteString

                        self.libraryPath = libraryPath.replacingOccurrences(of: "file://", with: "").removingPercentEncoding ?? "<none>"
                        self.libraryUrl = libraryPath
                    }
                }
            }

            Slider(value: $fontSize, in: 8 ... 64) {
                Text("Font Size (\(fontSize, specifier: "%.0f") pts)")
            }
        }
    }
}

#if DEBUG
    struct GeneralSettingsView_Previews: PreviewProvider {
        static var previews: some View {
            GeneralSettingsView()
        }
    }
#endif
