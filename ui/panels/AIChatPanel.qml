import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// AI Chat Panel (Gemini Integration)
Item {
    id: aiChatPanel
    
    signal closeRequested()
    
    property ListModel chatHistory: ListModel {}
    
    ColumnLayout {
        anchors.fill: parent
        spacing: 12
        
        // Header
        RowLayout {
            Layout.fillWidth: true
            
            Label {
                text: "🤖 AI Assistant"
                font.pixelSize: 18
                font.weight: Font.Bold
                color: "#ffffff"
            }
            
            Item { Layout.fillWidth: true }
            
            Label {
                text: "Gemini"
                color: "#4285f4"
                font.pixelSize: 11
            }
            
            Button {
                text: "✕"
                flat: true
                onClicked: closeRequested()
            }
        }
        
        // Chat history
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            
            ListView {
                id: chatList
                model: chatHistory
                spacing: 8
                
                delegate: Rectangle {
                    width: ListView.view.width - 8
                    height: msgText.implicitHeight + 16
                    radius: 8
                    color: model.isUser ? "#1a4a7a" : "#2a2a2a"
                    
                    Label {
                        id: msgText
                        anchors.fill: parent
                        anchors.margins: 8
                        text: model.message
                        wrapMode: Text.WordWrap
                        color: "#ffffff"
                    }
                }
                
                // Welcome message
                Component.onCompleted: {
                    chatHistory.append({
                        "isUser": false,
                        "message": "Hello! I'm your AI assistant. I can help you with:\n• Node graph setup\n• VR streaming configuration\n• Troubleshooting\n\nHow can I help you today?"
                    })
                }
            }
        }
        
        // Suggestions
        Flow {
            Layout.fillWidth: true
            spacing: 8
            
            Repeater {
                model: ["Add video node", "Connect to headset", "Start stream"]
                
                Button {
                    text: modelData
                    flat: true
                    font.pixelSize: 11
                    onClicked: {
                        chatHistory.append({ "isUser": true, "message": modelData })
                        // TODO: Connect to Gemini backend
                        chatHistory.append({ 
                            "isUser": false, 
                            "message": "I'll help you with that. [AI response would go here]" 
                        })
                    }
                }
            }
        }
        
        // Input area
        RowLayout {
            Layout.fillWidth: true
            spacing: 8
            
            TextField {
                id: inputField
                Layout.fillWidth: true
                placeholderText: "Ask anything..."
                color: "#ffffff"
                
                background: Rectangle {
                    radius: 8
                    color: "#2a2a2a"
                    border.color: inputField.focus ? "#4285f4" : "#444"
                }
                
                Keys.onReturnPressed: sendMessage()
            }
            
            Button {
                text: "Send"
                onClicked: sendMessage()
            }
        }
    }
    
    function sendMessage() {
        if (inputField.text.trim() === "") return
        
        chatHistory.append({ "isUser": true, "message": inputField.text })
        
        // TODO: Connect to Gemini API via LLMNode backend
        chatHistory.append({
            "isUser": false,
            "message": "Processing your request... (Gemini integration pending)"
        })
        
        inputField.text = ""
    }
}
