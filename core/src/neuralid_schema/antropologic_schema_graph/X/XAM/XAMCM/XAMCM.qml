// =============================================================================
// WACVC.qml - Volume Control Widget Qt 6.10 Implementation
// Species: W (Widget), Ethnicity: AC (AudioControl), Lineage: VC (VolumeControl)
// Location: W/WAC/WACVC/WACVC.qml
// =============================================================================
// Composes 3 KTCBT buttons (mute, volume up, volume down) into a unified
// volume control widget. Panes interact ONLY with this widget's interface,
// they have NO knowledge of the internal button components.
//
// HIERARCHY FLOW:
//   Component signals → Widget processes → Widget emits unified signals → Pane
// =============================================================================

import QtQuick
import QtQuick.Layouts

// Import the button component
import K.KTC.KTCBT as Buttons

Item {
    id: root
    
    // =========================================================================
    // WIDGET VARIANT SELECTION
    // =========================================================================
    
    enum Variant {
        Full,           // 3 buttons: Vol Down, Mute, Vol Up
        MuteOnly,       // 1 button: Mute only
        VolumeOnly      // 2 buttons: Vol Down, Vol Up (no mute)
    }
    
    property int variant: WACVC.Variant.Full
    
    // =========================================================================
    // WIDGET INTERFACE - What parent Panes bind to
    // =========================================================================
    
    // INPUT SLOTS (Pane binds these)
    property string audioSourceId: ""
    property int channel: 0
    property real volume: 0.8                  // 0.0 - 1.0
    property bool isMuted: false
    property real stepSize: 0.05
    property real minVolume: 0.0
    property real maxVolume: 1.0
    property bool isEnabled: true
    
    // =========================================================================
    // SEMANTIC LABELING - For voice commands & accessibility
    // =========================================================================
    
    // Channel identification (for voice: "mute channel 2")
    property string channelName: ""            // "Channel 2", "Master"
    property int channelNumber: -1             // Numeric index for voice
    property string displayLabel: ""           // "John Smith", "Discord"
    
    // Source type hint
    property string sourceType: "generic"     // microphone, desktop, browser, etc.
    
    // Voice aliases (AI matches against these)
    property var voiceAliases: []              // ["john", "johns mic"]
    
    // Button-specific voice semantics
    property string muteSemantic: "mute"       // "mute channel 2"
    property string volumeUpSemantic: "increase" // "increase channel 2" 
    property string volumeDownSemantic: "decrease" // "decrease channel 2"
    
    // Group memberships (for "mute all microphones")
    property var groupTags: []                 // ["microphones", "inputs"]
    
    // OUTPUT SIGNALS (Pane connects to these)
    signal volumeChanged(real newVolume)       // Emitted when volume changes
    signal muteToggled(bool isMuted)           // Emitted when mute state changes
    signal interactionStarted()
    signal interactionEnded()
    
    // Voice command response signal
    signal voiceCommandReceived(string command, var params)
    
    // =========================================================================
    // STYLING PROPERTIES (Widget controls these, not Pane)
    // =========================================================================
    
    property int layoutDirection: Qt.Horizontal
    property real buttonSpacing: 4
    property real containerPadding: 8
    property real buttonSize: 40
    
    property color backgroundColor: "#1F2937"
    property color iconColor: "#9CA3AF"
    property color iconColorActive: "#6366F1"
    property color iconColorMuted: "#EF4444"
    
    property string iconMuteOn: "volume_off"
    property string iconMuteOff: "volume_up"
    property string iconVolumeUp: "add"
    property string iconVolumeDown: "remove"
    
    // =========================================================================
    // COMPUTED PROPERTIES
    // =========================================================================
    
    // Computed icon for mute button based on state
    readonly property string currentMuteIcon: isMuted ? iconMuteOn : iconMuteOff
    readonly property color currentMuteColor: isMuted ? iconColorMuted : iconColor
    
    // Button count based on variant
    readonly property int buttonCount: {
        switch (variant) {
            case WACVC.Variant.Full: return 3
            case WACVC.Variant.MuteOnly: return 1
            case WACVC.Variant.VolumeOnly: return 2
            default: return 3
        }
    }
    
    // Button visibility
    readonly property bool showMuteButton: variant === WACVC.Variant.Full || variant === WACVC.Variant.MuteOnly
    readonly property bool showVolumeButtons: variant === WACVC.Variant.Full || variant === WACVC.Variant.VolumeOnly
    
    // Size calculation based on variant and layout
    implicitWidth: layoutDirection === Qt.Horizontal 
        ? (buttonSize * buttonCount) + (buttonSpacing * Math.max(0, buttonCount - 1)) + (containerPadding * 2)
        : buttonSize + (containerPadding * 2)
    
    implicitHeight: layoutDirection === Qt.Horizontal 
        ? buttonSize + (containerPadding * 2)
        : (buttonSize * buttonCount) + (buttonSpacing * Math.max(0, buttonCount - 1)) + (containerPadding * 2)
    
    // =========================================================================
    // INTERNAL STATE (hidden from Pane)
    // =========================================================================
    
    property real _internalVolume: volume
    property bool _interacting: false
    
    // =========================================================================
    // VISUAL LAYOUT
    // =========================================================================
    
    Rectangle {
        id: container
        anchors.fill: parent
        color: backgroundColor
        radius: 12
        
        // Main layout (horizontal or vertical)
        GridLayout {
            anchors.centerIn: parent
            
            columns: layoutDirection === Qt.Horizontal ? root.buttonCount : 1
            rows: layoutDirection === Qt.Horizontal ? 1 : root.buttonCount
            columnSpacing: layoutDirection === Qt.Horizontal ? buttonSpacing : 0
            rowSpacing: layoutDirection === Qt.Vertical ? buttonSpacing : 0
            
            // -----------------------------------------------------------------
            // VOLUME DOWN BUTTON (-) - Component 1
            // -----------------------------------------------------------------
            Buttons.KTCBT {
                id: volumeDownButton
                
                // Visibility based on variant
                visible: root.showVolumeButtons
                
                // Configure the component via its interface
                variant: Buttons.KTCBT.Variant.Icon
                iconSlot: iconVolumeDown
                enabledSlot: root.isEnabled && root._internalVolume > root.minVolume
                
                // Style overrides (widget's internal styling choices)
                widthOverride: buttonSize
                heightOverride: buttonSize
                
                // Theme colors
                secondaryTextColor: iconColor
                
                // SEMANTIC LABELING for AI voice commands
                semanticId: root.channelName ? `volume_down_${root.channelName.toLowerCase().replace(/ /g, '_')}` : "volume_down"
                semanticLabel: root.displayLabel ? `Decrease volume for ${root.displayLabel}` : "Decrease volume"
                semanticDescription: root.channelName ? `Decreases volume on ${root.channelName}` : "Decreases audio volume"
                semanticAction: root.volumeDownSemantic  // "decrease"
                semanticContext: root.channelName || root.audioSourceId
                voiceAliases: ["decrease", "lower", "turn down", "quieter", "down"]
                semanticTags: root.groupTags.concat(["audio", "volume", "control"])
                
                // Handle component signals internally
                onActivated: {
                    root.decreaseVolume()
                }
                
                onActivationStarted: root.handleInteractionStart()
                onActivationEnded: root.handleInteractionEnd()
            }
            
            // -----------------------------------------------------------------
            // MUTE BUTTON (speaker icon) - Component 2
            // -----------------------------------------------------------------
            Buttons.KTCBT {
                id: muteButton
                
                // Visibility based on variant
                visible: root.showMuteButton
                
                // Configure the component via its interface
                variant: Buttons.KTCBT.Variant.Icon
                iconSlot: currentMuteIcon
                enabledSlot: root.isEnabled
                
                // Style overrides
                widthOverride: buttonSize
                heightOverride: buttonSize
                
                // Dynamic color based on mute state
                secondaryTextColor: currentMuteColor
                
                // SEMANTIC LABELING for AI voice commands
                semanticId: root.channelName ? `mute_${root.channelName.toLowerCase().replace(/ /g, '_')}` : "mute"
                semanticLabel: root.displayLabel ? `Mute button for ${root.displayLabel}` : "Mute"
                semanticDescription: root.channelName ? `Toggles mute state for ${root.channelName}` : "Toggles audio mute"
                semanticAction: root.muteSemantic  // "mute"
                semanticContext: root.channelName || root.audioSourceId
                voiceAliases: ["mute", "unmute", "silence", "quiet", "toggle mute"]
                semanticTags: root.groupTags.concat(["audio", "mute", "toggle"])
                
                // Handle component signals internally
                onActivated: {
                    root.toggleMute()
                }
                
                onActivationStarted: root.handleInteractionStart()
                onActivationEnded: root.handleInteractionEnd()
            }
            
            // -----------------------------------------------------------------
            // VOLUME UP BUTTON (+) - Component 3
            // -----------------------------------------------------------------
            Buttons.KTCBT {
                id: volumeUpButton
                
                // Visibility based on variant
                visible: root.showVolumeButtons
                
                // Configure the component via its interface
                variant: Buttons.KTCBT.Variant.Icon
                iconSlot: iconVolumeUp
                enabledSlot: root.isEnabled && root._internalVolume < root.maxVolume
                
                // Style overrides
                widthOverride: buttonSize
                heightOverride: buttonSize
                
                // Theme colors
                secondaryTextColor: iconColor
                
                // SEMANTIC LABELING for AI voice commands
                semanticId: root.channelName ? `volume_up_${root.channelName.toLowerCase().replace(/ /g, '_')}` : "volume_up"
                semanticLabel: root.displayLabel ? `Increase volume for ${root.displayLabel}` : "Increase volume"
                semanticDescription: root.channelName ? `Increases volume on ${root.channelName}` : "Increases audio volume"
                semanticAction: root.volumeUpSemantic  // "increase"
                semanticContext: root.channelName || root.audioSourceId
                voiceAliases: ["increase", "raise", "turn up", "louder", "up"]
                semanticTags: root.groupTags.concat(["audio", "volume", "control"])
                
                // Handle component signals internally
                onActivated: {
                    root.increaseVolume()
                }
                
                onActivationStarted: root.handleInteractionStart()
                onActivationEnded: root.handleInteractionEnd()
            }
        }
    }
    
    // =========================================================================
    // INTERNAL LOGIC (hidden from Pane)
    // The widget processes component signals and emits unified widget signals
    // =========================================================================
    
    function increaseVolume() {
        let newVolume = Math.min(_internalVolume + stepSize, maxVolume)
        if (newVolume !== _internalVolume) {
            _internalVolume = newVolume
            volume = newVolume  // Update bound property
            
            // Emit widget signal to Pane
            // (Pane has NO idea this came from a button click)
            volumeChanged(newVolume)
        }
    }
    
    function decreaseVolume() {
        let newVolume = Math.max(_internalVolume - stepSize, minVolume)
        if (newVolume !== _internalVolume) {
            _internalVolume = newVolume
            volume = newVolume
            
            volumeChanged(newVolume)
        }
    }
    
    function toggleMute() {
        isMuted = !isMuted
        
        // Emit widget signal to Pane
        // (Pane only knows mute state changed, not HOW)
        muteToggled(isMuted)
    }
    
    function handleInteractionStart() {
        if (!_interacting) {
            _interacting = true
            interactionStarted()
        }
    }
    
    function handleInteractionEnd() {
        // Small delay to handle rapid button switches
        Qt.callLater(function() {
            if (_interacting && !volumeDownButton.pressed && 
                !muteButton.pressed && !volumeUpButton.pressed) {
                _interacting = false
                interactionEnded()
            }
        })
    }
    
    // =========================================================================
    // EXTERNAL API (for Pane to call if needed)
    // =========================================================================
    
    function setVolume(newVolume: real) {
        _internalVolume = Math.max(minVolume, Math.min(maxVolume, newVolume))
        volume = _internalVolume
    }
    
    function setMuted(muted: bool) {
        isMuted = muted
    }
}
