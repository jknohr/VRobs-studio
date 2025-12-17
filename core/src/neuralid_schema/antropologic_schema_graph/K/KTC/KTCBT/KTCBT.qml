// Neural Studio - KTCBT Button Component
// Qt 6.10 Quick Controls implementation
// Location: K/KTC/KTCBT/NeuralButton.qml
// Implements the KTCBT schema with PredefinedVariants

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Button {
    id: root
    
    // =========================================================================
    // PREDEFINED VARIANT SELECTION
    // =========================================================================
    
    enum Variant {
        Custom,
        Primary,
        Secondary, 
        Tertiary,
        Icon,
        FAB,
        Destructive,
        Toggle
    }
    
    property int variant: NeuralButton.Variant.Primary
    
    // =========================================================================
    // WIDGET INTERFACE - Standard Connection Points
    // =========================================================================
    
    // Input Slots (connected by parent widget)
    property string labelSlot: ""
    property string iconSlot: ""
    property bool enabledSlot: true
    property bool visibleSlot: true
    property int badgeSlot: 0
    property bool loadingSlot: false
    property bool toggleSlot: false
    
    // Output Signals (emitted to parent widget)
    signal activated(var payload)
    signal activationStarted(var payload)
    signal activationEnded(var payload)
    signal focusEntered()
    signal focusExited()
    signal toggleChanged(bool state)
    signal longPressed(var payload)
    signal doubleActivated(var payload)
    
    // Payload data (passed back in signals)
    property var payload: ({})
    property int itemIndex: -1
    
    // =========================================================================
    // OVERRIDES (take precedence over variant defaults)
    // =========================================================================
    
    property string labelOverride: ""
    property string iconOverride: ""
    property color backgroundColorOverride: "transparent"
    property color textColorOverride: "transparent"
    property color borderColorOverride: "transparent"
    property real widthOverride: 0
    property real heightOverride: 0
    
    // =========================================================================
    // TOGGLE SUPPORT
    // =========================================================================
    
    property bool isToggle: variant === NeuralButton.Variant.Toggle
    property string buttonGroupId: ""
    
    // =========================================================================
    // FEEDBACK SETTINGS
    // =========================================================================
    
    property bool rippleEnabled: true
    property color rippleColor: Qt.rgba(1, 1, 1, 0.3)
    property int rippleDuration: 300
    
    property real hoverScale: 1.02
    property real pressScale: 0.95
    property int scaleDuration: 100
    
    property bool hapticEnabled: true
    property int debounceMs: 200
    property int longPressThreshold: 500
    
    // =========================================================================
    // ACCESSIBILITY
    // =========================================================================
    
    property string ariaLabel: text
    property int tabIndex: 0
    property real minTouchTarget: 44
    
    Accessible.name: semanticLabel !== "" ? semanticLabel : ariaLabel
    Accessible.role: Accessible.Button
    Accessible.description: semanticDescription
    
    // =========================================================================
    // SEMANTIC LABELING - AI Voice Command Support
    // =========================================================================
    
    // Unique semantic identifier for AI to address this button
    // e.g., "mute_channel_2", "volume_up_master", "play_button"
    property string semanticId: ""
    
    // Human-readable label for AI announcements
    // e.g., "Mute button for Channel 2", "Volume up for Master"
    property string semanticLabel: ""
    
    // Detailed description for accessibility/AI context
    // e.g., "Toggles audio mute state for Channel 2"
    property string semanticDescription: ""
    
    // Action verb for voice commands (e.g., "mute", "increase", "toggle")
    property string semanticAction: "activate"
    
    // Parent context for grouped commands (e.g., "channel_2", "master")
    property string semanticContext: ""
    
    // Voice command aliases this button responds to
    property var voiceAliases: []  // ["mute", "silence", "quiet"]
    
    // Category for group commands (e.g., "mute all buttons")
    property var semanticTags: []  // ["audio", "mute", "toggle"]
    
    // =========================================================================
    // INTERNAL STATE
    // =========================================================================
    
    property bool _isHovered: false
    property bool _isPressed: false
    property real _currentScale: 1.0
    
    // =========================================================================
    // BIND SLOTS TO PROPERTIES
    // =========================================================================
    
    text: labelOverride !== "" ? labelOverride : labelSlot
    enabled: enabledSlot
    visible: visibleSlot
    checkable: isToggle
    checked: toggleSlot
    
    // =========================================================================
    // VARIANT STYLING
    // =========================================================================
    
    // Theme colors (override these from your theme)
    property color primaryColor: "#6366F1"       // Indigo
    property color primaryTextColor: "#FFFFFF"
    property color secondaryColor: "transparent"
    property color secondaryTextColor: "#6366F1"
    property color tertiaryTextColor: "#6366F1"
    property color destructiveColor: "#EF4444"   // Red
    property color destructiveTextColor: "#FFFFFF"
    property color disabledColor: "#9CA3AF"
    property color disabledTextColor: "#6B7280"
    
    // Computed colors based on variant
    readonly property color variantBackground: {
        if (!enabled) return disabledColor
        if (backgroundColorOverride !== Qt.rgba(0,0,0,0)) return backgroundColorOverride
        
        switch (variant) {
            case NeuralButton.Variant.Primary:
            case NeuralButton.Variant.FAB:
                return primaryColor
            case NeuralButton.Variant.Secondary:
                return secondaryColor
            case NeuralButton.Variant.Tertiary:
                return "transparent"
            case NeuralButton.Variant.Icon:
                return "transparent"
            case NeuralButton.Variant.Destructive:
                return destructiveColor
            case NeuralButton.Variant.Toggle:
                return checked ? primaryColor : secondaryColor
            default:
                return primaryColor
        }
    }
    
    readonly property color variantTextColor: {
        if (!enabled) return disabledTextColor
        if (textColorOverride !== Qt.rgba(0,0,0,0)) return textColorOverride
        
        switch (variant) {
            case NeuralButton.Variant.Primary:
            case NeuralButton.Variant.FAB:
                return primaryTextColor
            case NeuralButton.Variant.Secondary:
            case NeuralButton.Variant.Icon:
                return secondaryTextColor
            case NeuralButton.Variant.Tertiary:
                return tertiaryTextColor
            case NeuralButton.Variant.Destructive:
                return destructiveTextColor
            case NeuralButton.Variant.Toggle:
                return checked ? primaryTextColor : secondaryTextColor
            default:
                return primaryTextColor
        }
    }
    
    readonly property color variantBorderColor: {
        if (borderColorOverride !== Qt.rgba(0,0,0,0)) return borderColorOverride
        
        switch (variant) {
            case NeuralButton.Variant.Secondary:
            case NeuralButton.Variant.Toggle:
                return primaryColor
            default:
                return "transparent"
        }
    }
    
    readonly property int variantBorderWidth: {
        switch (variant) {
            case NeuralButton.Variant.Secondary:
            case NeuralButton.Variant.Toggle:
                return 2
            default:
                return 0
        }
    }
    
    readonly property int variantRadius: {
        switch (variant) {
            case NeuralButton.Variant.FAB:
                return width / 2  // Circular
            case NeuralButton.Variant.Icon:
                return 8
            default:
                return 8
        }
    }
    
    // =========================================================================
    // SIZE CALCULATIONS
    // =========================================================================
    
    implicitWidth: {
        if (widthOverride > 0) return widthOverride
        
        switch (variant) {
            case NeuralButton.Variant.FAB:
                return 56
            case NeuralButton.Variant.Icon:
                return Math.max(minTouchTarget, 40)
            default:
                return Math.max(minTouchTarget, contentItem.implicitWidth + leftPadding + rightPadding)
        }
    }
    
    implicitHeight: {
        if (heightOverride > 0) return heightOverride
        
        switch (variant) {
            case NeuralButton.Variant.FAB:
                return 56
            case NeuralButton.Variant.Icon:
                return Math.max(minTouchTarget, 40)
            default:
                return Math.max(minTouchTarget, 44)
        }
    }
    
    padding: variant === NeuralButton.Variant.Icon ? 8 : 16
    
    // =========================================================================
    // VISUAL COMPONENTS
    // =========================================================================
    
    background: Rectangle {
        id: backgroundRect
        
        color: root.variantBackground
        radius: root.variantRadius
        border.width: root.variantBorderWidth
        border.color: root.variantBorderColor
        
        scale: root._currentScale
        
        Behavior on scale {
            NumberAnimation { duration: scaleDuration; easing.type: Easing.OutCubic }
        }
        
        Behavior on color {
            ColorAnimation { duration: 150 }
        }
        
        // Ripple effect
        Rectangle {
            id: ripple
            
            property real rippleX: 0
            property real rippleY: 0
            property real rippleSize: 0
            
            x: rippleX - rippleSize / 2
            y: rippleY - rippleSize / 2
            width: rippleSize
            height: rippleSize
            radius: rippleSize / 2
            color: root.rippleColor
            opacity: 0
            
            visible: root.rippleEnabled
        }
        
        // Loading spinner overlay
        Item {
            anchors.fill: parent
            visible: root.loadingSlot
            
            BusyIndicator {
                anchors.centerIn: parent
                running: root.loadingSlot
                palette.dark: root.variantTextColor
            }
        }
        
        // Badge
        Rectangle {
            visible: root.badgeSlot > 0
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.margins: -4
            
            width: Math.max(18, badgeText.implicitWidth + 8)
            height: 18
            radius: 9
            color: root.destructiveColor
            
            Text {
                id: badgeText
                anchors.centerIn: parent
                text: root.badgeSlot > 99 ? "99+" : root.badgeSlot.toString()
                color: "white"
                font.pixelSize: 10
                font.weight: Font.Bold
            }
        }
    }
    
    contentItem: RowLayout {
        spacing: 8
        opacity: root.loadingSlot ? 0.3 : 1.0
        
        // Icon (Material Symbols Rounded)
        Text {
            id: iconText
            
            visible: (root.iconOverride !== "" || root.iconSlot !== "") && 
                     root.variant !== NeuralButton.Variant.Tertiary
            
            text: root.iconOverride !== "" ? root.iconOverride : root.iconSlot
            
            font.family: "Material Symbols Rounded"
            font.pixelSize: root.variant === NeuralButton.Variant.FAB ? 24 : 20
            
            color: root.variantTextColor
            
            Layout.alignment: Qt.AlignVCenter
        }
        
        // Text label
        Text {
            id: labelText
            
            visible: root.text !== "" && 
                     root.variant !== NeuralButton.Variant.Icon &&
                     root.variant !== NeuralButton.Variant.FAB
            
            text: root.text
            
            font.pixelSize: 14
            font.weight: Font.Medium
            font.letterSpacing: 0.5
            
            color: root.variantTextColor
            
            Layout.alignment: Qt.AlignVCenter
        }
    }
    
    // =========================================================================
    // INTERACTION HANDLING
    // =========================================================================
    
    // Scale animation on hover/press
    onHoveredChanged: {
        _isHovered = hovered
        updateScale()
        
        if (hovered) {
            focusEntered()
        } else {
            focusExited()
        }
    }
    
    onPressedChanged: {
        _isPressed = pressed
        updateScale()
        
        if (pressed) {
            activationStarted(payload)
            startRipple(pressX, pressY)
        } else {
            activationEnded(payload)
        }
    }
    
    // Debounced click handling
    property real _lastClickTime: 0
    property real pressX: 0
    property real pressY: 0
    
    TapHandler {
        onTapped: function(eventPoint) {
            let now = Date.now()
            if (now - root._lastClickTime < root.debounceMs) return
            root._lastClickTime = now
            
            root.activated(root.payload)
        }
        
        onDoubleTapped: function(eventPoint) {
            root.doubleActivated(root.payload)
        }
        
        onLongPressed: {
            root.longPressed(root.payload)
        }
        
        longPressThreshold: root.longPressThreshold
    }
    
    // Track press position for ripple
    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.NoButton
        hoverEnabled: true
        
        onPositionChanged: function(mouse) {
            root.pressX = mouse.x
            root.pressY = mouse.y
        }
    }
    
    // Toggle state binding
    onCheckedChanged: {
        if (isToggle) {
            toggleChanged(checked)
        }
    }
    
    // =========================================================================
    // HELPER FUNCTIONS
    // =========================================================================
    
    function updateScale() {
        if (_isPressed) {
            _currentScale = pressScale
        } else if (_isHovered) {
            _currentScale = hoverScale
        } else {
            _currentScale = 1.0
        }
    }
    
    function startRipple(x, y) {
        if (!rippleEnabled) return
        
        ripple.rippleX = x
        ripple.rippleY = y
        ripple.rippleSize = 0
        ripple.opacity = 1
        
        rippleAnimation.restart()
    }
    
    ParallelAnimation {
        id: rippleAnimation
        
        NumberAnimation {
            target: ripple
            property: "rippleSize"
            from: 0
            to: Math.max(root.width, root.height) * 2
            duration: rippleDuration
            easing.type: Easing.OutQuad
        }
        
        NumberAnimation {
            target: ripple
            property: "opacity"
            from: 1
            to: 0
            duration: rippleDuration
            easing.type: Easing.OutQuad
        }
    }
}
