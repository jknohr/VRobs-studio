import QtQuick
import QtQuick.Controls
import "../blueprint"

// Blueprint Frame - Node Graph Editor Canvas
Item {
    id: blueprintFrame
    
    // Include the existing BlueprintCanvas
    BlueprintCanvas {
        anchors.fill: parent
    }
    
    // Frame indicator (subtle)
    Rectangle {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 8
        width: label.width + 24
        height: 28
        radius: 14
        color: "#30ffffff"
        opacity: 0.6
        
        Label {
            id: label
            anchors.centerIn: parent
            text: "Blueprint Mode"
            color: "#ffffff"
            font.pixelSize: 12
            font.weight: Font.Medium
        }
    }
}
