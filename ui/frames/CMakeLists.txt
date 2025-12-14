# Neural Studio UI - Frames Module
# Canvas frames (Blueprint, Active)

set(QML_FILES
    BlueprintFrame.qml
    ActiveFrame.qml
)

qt_add_qml_module(neural-studio-frames
    URI NeuralStudio.Frames
    VERSION 1.0
    QML_FILES ${QML_FILES}
)
