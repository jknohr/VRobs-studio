import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// Settings Panel
Item {
    id: settingsPanel
    
    signal closeRequested()
    
    ColumnLayout {
        anchors.fill: parent
        spacing: 16
        
        // Header
        RowLayout {
            Layout.fillWidth: true
            
            Label {
                text: "Settings"
                font.pixelSize: 20
                font.weight: Font.Bold
                color: "#ffffff"
            }
            
            Item { Layout.fillWidth: true }
            
            Button {
                text: "✕"
                flat: true
                onClicked: closeRequested()
            }
        }
        
        // Settings sections
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            
            ColumnLayout {
                width: parent.width
                spacing: 24
                
                // Display section
                GroupBox {
                    Layout.fillWidth: true
                    title: "Display"
                    
                    ColumnLayout {
                        anchors.fill: parent
                        
                        RowLayout {
                            Label { text: "Theme"; color: "#ccc" }
                            Item { Layout.fillWidth: true }
                            ComboBox {
                                model: ["Dark", "Light", "System"]
                                currentIndex: 0
                            }
                        }
                        
                        RowLayout {
                            Label { text: "UI Scale"; color: "#ccc" }
                            Item { Layout.fillWidth: true }
                            Slider {
                                from: 0.75
                                to: 1.5
                                value: 1.0
                                stepSize: 0.25
                            }
                        }
                    }
                }
                
                // VR Headset Profiles section
                GroupBox {
                    Layout.fillWidth: true
                    title: "VR Headset Profiles"
                    
                    ColumnLayout {
                        anchors.fill: parent
                        
                        CheckBox { text: "Meta Quest 3"; checked: true }
                        CheckBox { text: "Valve Index"; checked: false }
                        CheckBox { text: "Vive Pro 2"; checked: false }
                        
                        Button {
                            text: "+ Add Custom Profile"
                            flat: true
                        }
                    }
                }
                
                // Streaming section
                GroupBox {
                    Layout.fillWidth: true
                    title: "Streaming"
                    
                    ColumnLayout {
                        anchors.fill: parent
                        
                        RowLayout {
                            Label { text: "SRT Port"; color: "#ccc" }
                            Item { Layout.fillWidth: true }
                            SpinBox {
                                from: 1000
                                to: 65535
                                value: 9000
                            }
                        }
                        
                        RowLayout {
                            Label { text: "Bitrate (Mbps)"; color: "#ccc" }
                            Item { Layout.fillWidth: true }
                            SpinBox {
                                from: 10
                                to: 300
                                value: 100
                            }
                        }
                    }
                }
                
                // About section
                GroupBox {
                    Layout.fillWidth: true
                    title: "About"
                    
                    ColumnLayout {
                        Label { 
                            text: "Neural Studio v0.1.0"
                            color: "#888"
                        }
                        Label {
                            text: "Qt 6.10.1 / OpenUSD / OpenXR"
                            color: "#666"
                            font.pixelSize: 11
                        }
                    }
                }
            }
        }
    }
}
