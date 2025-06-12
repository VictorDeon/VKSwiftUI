import VKSwiftUI
import SwiftUI

struct TextContent: View {
    @State private var window: NSWindow?

    private func quit() {
        // Fecha a janela como se tivesse clicado no 'X'
        window?.performClose(nil)
        // Então encerra o run loop
        NSApplication.shared.stop(nil)
    }

    var body: some View {
        VStack(spacing: 15) {
            Text("Hello World")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.primary)
            Button(action: quit) {
                Text("Sair")
            }
        }
        .padding()
        .frame(width: 300, height: 300)
        .background(WindowAccessor { win in
            self.window = win
        })
    }
}

let app = NSApplication.shared

TerminalSwiftUI.showWindow(TextContent(), by: app)
app.run()

TerminalSwiftUI.showWindow(TextContent(), by: app)
app.run()

TerminalSwiftUI.showWindow(TextContent(), by: app)
app.run()
