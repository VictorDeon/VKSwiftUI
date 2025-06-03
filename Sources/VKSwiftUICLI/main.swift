import VKSwiftUI
import SwiftUI

struct TextContent: View {
    var body: some View {
        VStack(spacing: 15) {
            Text("Hello World")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.primary)
        }
        .padding()
        .frame(width: 300, height: 300)
    }
}

let app = NSApplication.shared

TerminalSwiftUI.showWindow(TextContent(), by: app)
app.run()
