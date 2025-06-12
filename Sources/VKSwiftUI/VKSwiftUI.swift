import SwiftUI

// 1. Um ViewModifier que injeta a janela no Environment
public struct WindowAccessor: NSViewRepresentable {
    public let callback: (NSWindow) -> Void
    public init(callback: @escaping (NSWindow) -> Void) {
        self.callback = callback
    }
    public func makeNSView(context: Context) -> NSView {
        let view = NSView()
        DispatchQueue.main.async {
            if let window = view.window {
                callback(window)
            }
        }
        return view
    }
    public func updateNSView(_ nsView: NSView, context: Context) { }
}

class HostingWindowController<V: View>: NSWindowController, NSWindowDelegate {
    // Cria a janela SwiftUI
    init(app: NSApplication, rootView: V, title: String, mask: NSWindow.StyleMask) {
        // transformamos o CLI num app com Dock e foco
        app.setActivationPolicy(.regular)

        let win = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 300, height: 100),
            styleMask: mask,
            backing: .buffered,
            defer: false
        )
        win.title = title
        win.level = .floating
        win.collectionBehavior.insert(.canJoinAllSpaces)
        win.center()

        // configuro o contentView e o delegate
        win.contentView = NSHostingView(rootView: rootView)
        // garantimos que a janela receba eventos de teclado
        win.makeKeyAndOrderFront(nil)
        // trazemos o app para frente
        app.activate(ignoringOtherApps: true)

        super.init(window: win)
        win.delegate = self
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    // Quando a janela fecha, paramos o run loop
    public func windowWillClose(_ notification: Notification) {
        NSApp.stop(nil)
    }
}


public struct TerminalSwiftUI {
    @MainActor static var windowControllers: [Any] = []

    /// Show swift UI window by CLI
    /// - Parameters:
    ///     - view: Swift UI component. (required.)
    ///     - app: NSApplication singleton app. (required)
    ///     - title: Window title
    @MainActor public static func showWindow<V: View>(
        _ view: V,
        by app: NSApplication,
        title: String = "Window",
        mask: NSWindow.StyleMask = [.titled, .closable, .resizable]
    ) {
        let controller = HostingWindowController(app: app, rootView: view, title: title, mask: mask)
        windowControllers.append(controller)
        controller.showWindow(nil)
    }
}
