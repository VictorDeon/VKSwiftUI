# VKSwiftUI

Microserviço que disponibiliza uma forma de usar o swift ui dentro do CLI macos

## Como usar

Se for executado em um ambiente sincrono, na thread main:

```swift
let app = NSApplication.shared

TerminalSwiftUI.showWindow(YourSwiftUIComponent(), by: app)
app.run()
```

Se for executado em um ambiente assincrono, em background temos que retornar a thread principal.

```swift
await MainActor.run {
    let app = NSApplication.shared
    
    TerminalSwiftUI.showWindow(TextContent(), by: app)
    app.run()
}
```
