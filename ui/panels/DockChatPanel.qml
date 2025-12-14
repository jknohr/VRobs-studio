import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// Dock Chat Panel (Stream Interaction via Transport Protocol)
Item {
    id: dockChatPanel
    
    signal closeRequested()
    
    property bool connected: false
    property string dockAddress: ""
    property ListModel messages: ListModel {}
    
    ColumnLayout {
        anchors.fill: parent
        spacing: 12
        
        // Header
        RowLayout {
            Layout.fillWidth: true
            
            Label {
                text: "💬 Dock Chat"
                font.pixelSize: 18
                font.weight: Font.Bold
                color: "#ffffff"
            }
            
            Item { Layout.fillWidth: true }
            
            Rectangle {
                width: 8
                height: 8
                radius: 4
                color: connected ? "#00ff88" : "#ff4444"
            }
            
            Label {
                text: connected ? "Connected" : "Disconnected"
                color: connected ? "#00ff88" : "#ff4444"
                font.pixelSize: 11
            }
            
            Button {
                text: "✕"
                flat: true
                onClicked: closeRequested()
            }
        }
        
        // Connection settings (when not connected)
        GroupBox {
            Layout.fillWidth: true
            visible: !connected
            title: "Connect to Dock"
            
            ColumnLayout {
                anchors.fill: parent
                
                TextField {
                    id: addressField
                    Layout.fillWidth: true
                    placeholderText: "srt://dock.example.com:9000"
                    text: dockAddress
                    
                    background: Rectangle {
                        radius: 4
                        color: "#2a2a2a"
                        border.color: "#444"
                    }
                }
                
                Button {
                    Layout.fillWidth: true
                    text: "Connect"
                    onClicked: {
                        dockAddress = addressField.text
                        // TODO: Connect via SRT/WebSocket
                        connected = true
                        messages.append({
                            "sender": "System",
                            "message": "Connected to dock at " + dockAddress,
                            "isSystem": true
                        })
                    }
                }
            }
        }
        
        // Chat messages (when connected)
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            visible: connected
            
            ListView {
                id: msgList
                model: messages
                spacing: 4
                
                delegate: RowLayout {
                    width: ListView.view.width
                    spacing: 8
                    
                    Label {
                        text: model.sender + ":"
                        color: model.isSystem ? "#888" : "#4a9eff"
                        font.weight: Font.Medium
                        font.pixelSize: 12
                    }
                    
                    Label {
                        Layout.fillWidth: true
                        text: model.message
                        color: model.isSystem ? "#888" : "#ffffff"
                        wrapMode: Text.WordWrap
                        font.pixelSize: 12
                    }
                }
            }
        }
        
        // Send message (when connected)
        RowLayout {
            Layout.fillWidth: true
            visible: connected
            spacing: 8
            
            TextField {
                id: chatInput
                Layout.fillWidth: true
                placeholderText: "Send to stream..."
                color: "#ffffff"
                
                background: Rectangle {
                    radius: 4
                    color: "#2a2a2a"
                    border.color: chatInput.focus ? "#4a9eff" : "#444"
                }
                
                Keys.onReturnPressed: sendToStream()
            }
            
            Button {
                text: "Send"
                onClicked: sendToStream()
            }
        }
        
        // Disconnect button
        Button {
            Layout.fillWidth: true
            visible: connected
            text: "Disconnect"
            flat: true
            onClicked: {
                connected = false
                messages.clear()
            }
        }
    }
    
    function sendToStream() {
        if (chatInput.text.trim() === "") return
        
        messages.append({
            "sender": "You",
            "message": chatInput.text,
            "isSystem": false
        })
        
        // TODO: Send via transport protocol
        
        chatInput.text = ""
    }
}
