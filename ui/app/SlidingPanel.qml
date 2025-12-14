import QtQuick
import QtQuick.Controls

// Slide-out panel component (like Drawer but more customizable)
Item {
    id: slidingPanel
    
    property int edge: Qt.RightEdge  // Qt.LeftEdge or Qt.RightEdge
    property bool opened: false
    property alias content: contentLoader.sourceComponent
    
    // Position based on edge
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    x: edge === Qt.RightEdge ? 
       (opened ? parent.width - width : parent.width) :
       (opened ? 0 : -width)
    
    z: 500  // Below corner buttons, above canvas
    
    Behavior on x {
        NumberAnimation { duration: 250; easing.type: Easing.OutCubic }
    }
    
    function toggle() {
        opened = !opened
    }
    
    function open() {
        opened = true
    }
    
    function close() {
        opened = false
    }
    
    // Panel background
    Rectangle {
        anchors.fill: parent
        color: "#1a1a1a"
        border.width: 1
        border.color: edge === Qt.RightEdge ? "#333" : "#333"
        
        // Shadow
        Rectangle {
            width: 8
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            x: edge === Qt.RightEdge ? -8 : parent.width
            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop { position: edge === Qt.RightEdge ? 0.0 : 1.0; color: "transparent" }
                GradientStop { position: edge === Qt.RightEdge ? 1.0 : 0.0; color: "#40000000" }
            }
        }
    }
    
    // Content area
    Loader {
        id: contentLoader
        anchors.fill: parent
        anchors.margins: 16
    }
    
    // Click outside to close (optional overlay)
    Rectangle {
        visible: opened
        parent: slidingPanel.parent
        anchors.fill: parent
        color: "#20000000"
        z: slidingPanel.z - 1
        
        MouseArea {
            anchors.fill: parent
            onClicked: slidingPanel.close()
        }
    }
}
