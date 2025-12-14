import QtQuick
import QtQuick.Controls
import QtQuick3D
import QtMultimedia

// Active Frame - Live Monitoring and Streaming View
Item {
    id: activeFrame
    
    // Background
    Rectangle {
        anchors.fill: parent
        color: "#0a0a0a"
    }
    
    // 3D Viewport for VR preview (using Qt Quick 3D)
    View3D {
        id: viewport3d
        anchors.fill: parent
        anchors.margins: 60
        
        environment: SceneEnvironment {
            clearColor: "#181818"
            backgroundMode: SceneEnvironment.Color
            antialiasingMode: SceneEnvironment.MSAA
            antialiasingQuality: SceneEnvironment.High
        }
        
        // Default camera
        PerspectiveCamera {
            id: camera
            position: Qt.vector3d(0, 100, 300)
            eulerRotation.x: -15
        }
        
        // Basic lighting
        DirectionalLight {
            eulerRotation.x: -30
            eulerRotation.y: -30
            ambientColor: Qt.rgba(0.1, 0.1, 0.1, 1.0)
        }
        
        // Ground plane
        Model {
            source: "#Rectangle"
            scale: Qt.vector3d(5, 5, 1)
            eulerRotation.x: -90
            materials: PrincipledMaterial {
                baseColor: "#2a2a2a"
            }
        }
        
        // Placeholder - VR Preview content will be rendered here
        // This will connect to the rendering pipeline
    }
    
    // Control bar at bottom
    Rectangle {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 80
        width: controlRow.width + 32
        height: 48
        radius: 24
        color: "#40000000"
        
        Row {
            id: controlRow
            anchors.centerIn: parent
            spacing: 16
            
            RoundButton {
                icon.source: "qrc:/icons/play.svg"
                icon.width: 20
                icon.height: 20
                ToolTip.visible: hovered
                ToolTip.text: "Start Streaming"
            }
            
            RoundButton {
                icon.source: "qrc:/icons/record.svg"
                icon.width: 20
                icon.height: 20
                ToolTip.visible: hovered
                ToolTip.text: "Record"
            }
            
            RoundButton {
                icon.source: "qrc:/icons/vr.svg"
                icon.width: 20
                icon.height: 20
                ToolTip.visible: hovered
                ToolTip.text: "VR Preview"
            }
        }
    }
    
    // Frame indicator
    Rectangle {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 8
        width: label.width + 24
        height: 28
        radius: 14
        color: "#3000ff00"
        opacity: 0.6
        
        Label {
            id: label
            anchors.centerIn: parent
            text: "Active Mode"
            color: "#00ff88"
            font.pixelSize: 12
            font.weight: Font.Medium
        }
    }
}
