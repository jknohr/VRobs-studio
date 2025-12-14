# Neural Studio UI - Panels Module
# Slide-out panels (Settings, AI Chat, Dock Chat)

set(QML_FILES
    SettingsPanel.qml
    AIChatPanel.qml
    DockChatPanel.qml
)

qt_add_qml_module(neural-studio-panels
    URI NeuralStudio.Panels
    VERSION 1.0
    QML_FILES ${QML_FILES}
)
