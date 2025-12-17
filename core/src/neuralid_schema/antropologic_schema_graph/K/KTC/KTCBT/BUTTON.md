METADATA

Variants PRECONFIGURED versions with these parameters.. many of them can be null. 
So you can 


1. The Geometry & Shape Engine
These parameters define the physical footprint and contour of the button.

Dimensions: width, height, min-width, max-width (fluid vs. fixed).

Padding: Top, right, bottom, left (internal breathing room).

Margins: External spacing/safe zones.

Corner Topology:

border-radius (uniform or per-corner).

Smoothing: Apple-style "squircle" curvature continuity.

Cutouts: Chamfered vs. filleted corners.

Shape Primitive: Rectangle, circle, pill, polygon (n-sided), arbitrary vector path (SVG shape).

Stroke/Border: Thickness, style (solid, dashed, dotted), alignment (inside, center, outside), cap/join styles (miter, round).

Z-Depth (3D): Elevation, extrusion depth (for 3D buttons), perspective skew.

2. The Visual & Material Surface
Defining the texture, light, and color physics of the button.

Background Fill:

Solid Color (oklch(0.7 0.1 164)).

Gradients (Linear, Radial, Conic, Mesh).

Image/Texture Map (tiling, scaling).

Video/Gif (animated backgrounds).

Material Properties:

opacity (transparency).

backdrop-filter (blur, frosted glass/glassmorphism).

blend-mode (interaction with layers below: overlay, multiply).

Neumorphism Light Source: Angle, distance, intensity (for soft extruded shadows).

Skeuomorphism: Gloss, matte, metallic sheen, bezel depth.

Shadows & Glows:

Drop Shadow (X, Y, Blur, Spread, Color).

Inner Shadow (creates depth/inset).

Glow (outer emission).

Ambient Occlusion (contact shadows).

3. Typography & Iconography (The Payload)
Variables controlling what is inside the button.

Text Parameters:

Font Family, Weight, Size.

line-height, letter-spacing (kerning).

Text Transform (Uppercase, Lowercase, Capitalize).

Text Decoration (Underline, Strikethrough).

Text Shadow/Outline.

Truncation logic (ellipsis vs. wrap).

Iconography:

Source (Vector/SVG vs. Raster).

Position (Left, Right, Top, Bottom of text).

Size relative to text.

Color (match text vs. distinct).

Animation (spin on load, morph).

Badges/overlays: Notification dots or counters attached to corners.

4. The State Machine
A button is not static; it changes based on interaction. We need variables for every state.

Standard States: Default, Hover, Pressed/Active, Focused (keyboard nav), Disabled.

Logic States:

Loading: (Spinner visible? Text hidden? Pulse animation?).

Success: (Morph to checkmark? Green flash?).

Error: (Shake animation? Red flash? Tooltip reveal?).

Toggled: (On/Off state for toggle buttons).

visited: (For link-based buttons).

5. Interaction & Feedback Physics
How the button "feels" when you touch it.

Cursor: Pointer, grab, text, crosshair.

Ripple Effect: Origin point, expansion speed, color, fade-out time (Material Design style).

Scale Transform: Shrink on click (e.g., 95% scale), lift on hover.

Haptics (Mobile/Controller):

Vibration pattern (light tap, heavy thud, buzz).

Impact intensity.

Audio/Sonic:

onHover sound.

onDown sound (click).

onUp sound (release).

Spatial audio location (for AR/VR).

Debounce/Throttle: Time delay to prevent accidental double-clicks.

6. Spatial & AR/VR Parameters
Variables required when the button exists in 3D space (Apple Vision Pro, Meta Quest).

Gaze Behavior:

Dwell time (how long looking triggers a click).

Gaze hover effect (highlight based on eye tracking).

Proximity: Glow or expand as the finger/controller gets closer.

Parallax: Internal movement of layers based on viewing angle.

Physics Body: Mass, friction, restitution (bounciness) if the button can be thrown or collided with.

Occlusion: How it handles being covered by virtual hands.

7. Accessibility (A11y)
Crucial parameters for screen readers and assistive tech.

aria-label: The spoken name of the button.

aria-pressed / aria-expanded: State communication.

tabindex: Keyboard navigation order.

Focus Ring: Color, offset, thickness (high contrast requirements).

Touch Target Size: Invisible padding to ensure tap accuracy (minimum 44px).

8. Exotic / "God Mode" Variables
The variables used in high-end gaming UIs or futuristic concepts.

Particle Emitters: Sparkles, smoke, or confetti on click.

Chromatic Aberration: RGB split distortion on hover (glitch effect).

Distortion Map: Heat haze or water ripple distortion.

Shatter Physics: Does the button break into pieces when destroyed?

Liquid Fill: Fill level (like a progress bar) inside the button.






Qt Quick Controls
QML Types
Button
Button QML Type
Push-button that can be clicked to perform a command or answer a question. More...

Import Statement:	import QtQuick.Controls
Inherits:	
AbstractButton

Inherited By:	
RoundButton and ToolButton

List of all members, including inherited members
Properties
flat : bool
highlighted : bool
Detailed Description
Button presents a push-button control that can be pushed or clicked by the user. Buttons are normally used to perform an action, or to answer a question. Typical buttons are OK, Apply, Cancel, Close, Yes, No, and Help.

Button inherits its API from AbstractButton. For instance, you can set text, display an icon, and react to clicks using the AbstractButton API.

A button emits the signal clicked() when it is activated by the user. Connect to this signal to perform the button's action. Buttons also provide the signals canceled(), doubleClicked(), pressed(), released() and pressAndHold() for long presses.

See the snippet below on how to connect to the button's signals.

RowLayout {
    Button {
        text: "Ok"
        onClicked: model.submit()
    }
    Button {
        text: "Cancel"
        onClicked: model.revert()
    }
}
See also Customizing Button and Button Controls.

Property Documentation
flat : bool

This property holds whether the button is flat.



A flat button typically does not draw a background unless it is pressed or checked.

The default value is false.


highlighted : bool

This property holds whether the button is highlighted.




Qt 6.10
Qt Quick Controls
Qt Quick Controls Guidelines
Button Controls
Button Controls
Qt Quick Controls offers a selection of button-like controls.

AbstractButton

Abstract base type providing functionality common to buttons

Button

Push-button that can be clicked to perform a command or answer a question

CheckBox

Check button that can be toggled on or off

DelayButton

Check button that triggers when held down long enough

RadioButton

Exclusive radio button that can be toggled on or off

RoundButton

A push-button control with rounded corners that can be clicked by the user

Switch

Button that can be toggled on or off

ToolButton

Button with a look suitable for a ToolBar

Each type of button has its own specific use case. The following sections offer guidelines for choosing the appropriate type of button, depending on the use case.

Button Control
Button is a clickable control that starts an action, or opens or closes a popup. A button usually has a text label but it can also contain an icon.

Button is a very suitable control when a popup or dialog needs to perform an action. The most common examples are Apply, Cancel, Save, Close and Help.

Recommendations:

The button's text should be a verb describing the action, or a noun matching the title of the popup that will be opened.
Don't use a button to set state. Switch is more suitable for that.
Use the default font unless you have UI guidelines specifying otherwise.
If the text is localized, consider the influence of a longer text on the layout.
See also Button and AbstractButton

CheckBox Control
CheckBox is used to build multi-selection option lists. Any number of options can be selected, including none, but the options should not be mutually exclusive.

Use a single CheckBox for a yes/no choice, such as when you have to accept the terms of service agreement in a form.

For a single yes/no choice, it is also possible to use a switch. If the choice concerns an option, it is best to use a CheckBox. If it concerns action to be taken, a switch is recommended.

When options can be grouped, you can use a partially checked CheckBox to represent the whole group. Use the checkbox's partially checked state when a user selects some, but not all, sub-items in the group.

The three availables check states are: checked, partially checked and unchecked.

The checkable options are often listed vertically.

Recommendations:

The checkbox label should be a statement that the check mark makes true, and that the absence of a check mark makes false.
The checkbox label should not contain a negative statement.
Use the default font, unless you have UI guidelines specifying otherwise.
If the text is localized, consider the influence of a longer text on the layout.
See also CheckBox

DelayButton Control
DelayButton is a button that incorporates a delay before triggering an action. This delay prevents accidental presses.

Recommendations:

Use in touch user interfaces.
Use for actions that must be triggered with care.
See also Button and AbstractButton

RadioButton Control
RadioButton is used to select only one option from a set of options. Selecting one option automatically deselects the one selected before.

If there are only two mutually exclusive options, combine them into a single checkbox or a switch.

Recommendations:

Limit the label text to one line.
Ensure that a sensible default option is checked.
List RadioButton options vertically.
If the text is localized, consider the influence of a longer text on the layout.
Use the default font, unless you have UI guidelines that specify otherwise.
Just like with CheckBox, do not make the list too large.
In order to avoid confusion, do not put two groups of radio buttons next to each other.
See also RadioButton

RoundButton Control
RoundButton is a clickable control that starts an action, or opens or closes a popup. A round button with a square image icon or one-letter font icon is circular. A circular RoundButton takes less space than a normal Button, and can also be used as a floating action button.



Recommendations:

Keep labels short and concise.
If the text is localized, consider the influence of a longer text on the layout.
See also RoundButton

Switch Control


Switch represents a physical switch that allows users to choose between an "on" or "off" state. Use a switch for binary operations that take effect immediately after it has been switched on. For example, a switch to turn WIFI on or off.

Recommendations:

Keep labels short and concise.
If the text is localized, consider the influence of a longer text on the layout.
See also Switch

ToolButton Control


ToolButton is nearly identical to Button, but it has a graphical appearance that makes it more suitable for insertion into a ToolBar.

See also ToolButton

https://doc.qt.io/qt-6/qtquickcontrols-customize.html
https://doc.qt.io/qt-6/qml-qtquick-controls-buttongroup.html
https://doc.qt.io/qt-6/qml-qtquick-controls-abstractbutton.html
https://doc.qt.io/qt-6/qml-qtquick-controls-radiobutton.html
https://doc.qt.io/qt-6/qtquickcontrols-customize.html
https://doc.qt.io/qt-6/qml-qtquick-controls-dialog.html
https://doc.qt.io/qt-6/qml-qtquick-controls-toolbutton.html
https://doc.qt.io/qt-6/qtquick-how-tos.html

SCALING OF 

Scalability
When you develop applications for several different mobile device platforms, you face the following challenges:

Mobile device platforms support devices with varying screen configurations: size, aspect ratio, orientation, and density.
Different platforms have different UI conventions and you need to meet the users' expectations on each platform.
Qt Quick enables you to develop applications that can run on different types of devices, such as tablets and handsets. In particular, they can cope with different screen configurations. However, there is always a certain amount of fixing and polishing needed to create an optimal user experience for each target platform.

You need to consider scalability when:

You want to deploy your application to more than one device platform, such as Android and iOS, or more than one device screen configuration.
Your want to be prepared for new devices that might appear on the market after your initial deployment.
To implement scalable applications using Qt Quick:

Design UIs using Qt Quick Controls that provide sets of UI controls.
Define layouts using Qt Quick Layouts, which can resize their items.
Use property binding to implement use cases not covered by the layouts. For example, to display alternative versions of images on screens with low and high pixel density or automatically adapt view contents according to the current screen orientation.
Select a reference device and calculate a scaling ratio for adjusting image and font sizes and margins to the actual screen size.
Load platform-specific assets using file selectors.
Load components on demand by using a Loader.
Consider the following patterns when designing your application:

The contents of a view might be quite similar on all screen sizes, but with an expanded content area. If you use the ApplicationWindow QML type from Qt Quick Controls, it will automatically calculate the window size based on the sizes of its content items. If you use Qt Quick Layouts to position the content items, they will automatically resize the items pushed to them.
The contents of an entire page in a smaller device could form a component element of a layout in a larger device. Therefore, consider making that a separate component (that is, defined in a separate QML file), and in the smaller device, the view will simply contain an instance of that component. On the larger device, there may be enough space to use loaders to show additional items. For example, in an email viewer, if the screen is large enough, it may be possible to show the email list view, and the email reader view side by side.
For games, you would typically want to create a game board that does not scale, so as not to provide an unfair advantage to players on larger screens. One solution is to define a safe zone that fits the screen with the smallest supported aspect ratio (usually, 3:2), and add decorative-only content in the space that will be hidden on a 4:3 or 16:9 screen.
Resizing Application Windows Dynamically
Qt Quick Controls provide a set of UI controls to create user interfaces in Qt Quick. Typically, you declare an ApplicationWindow control as the root item of your application. The ApplicationWindow adds convenience for positioning other controls, such as MenuBar, ToolBar, and StatusBar in a platform independent manner. The ApplicationWindow uses the size constraints of the content items as input when calculating the effective size constraints of the actual window.

In addition to controls that define standard parts of application windows, controls are provided for creating views and menus, as well as presenting or receiving input from users. You can use Qt Quick Controls Styles to apply custom styling to the predefined controls.

Qt Quick Controls, such as the ToolBar, do not provide a layout of their own, but require you to position their contents. For this, you can use Qt Quick Layouts.

Laying Out Screen Controls Dynamically
Qt Quick Layouts provide ways of laying out screen controls in a row, column, or grid, using the RowLayout, ColumnLayout, and GridLayout QML types. The properties for these QML types hold their layout direction and spacing between the cells.

You can use the Qt Quick Layouts QML types to attach additional properties to the items pushed to the layouts. For example, you can specify minimum, maximum, and preferred values for item height, width, and size.

The layouts ensure that your UIs are scaled properly when windows and screens are resized and always use the maximum amount of space available.

A specific use case for the GridLayout type is to use it as a row or a column depending on the screen orientation.



The following code snippet uses the flow property to set the flow of the grid from left to right (as a row) when the screen width is greater than the screen height and from top to bottom (as a column) otherwise:

ApplicationWindow {
    id: root
    visible: true
    width: 480
    height: 620

    GridLayout {
        anchors.fill: parent
        anchors.margins: 20
        rowSpacing: 20
        columnSpacing: 20
        flow:  width > height ? GridLayout.LeftToRight : GridLayout.TopToBottom
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#5d5b59"
            Label {
                anchors.centerIn: parent
                text: "Top or left"
                color: "white"
            }
        }
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#1e1b18"
            Label {
                anchors.centerIn: parent
                text: "Bottom or right"
                color: "white"
            }
        }
    }
}

Constantly resizing and recalculating screens comes with a performance cost. Mobile and embedded devices might not have the power required to recalculate the size and position of animated objects for every frame, for example. If you run into performance problems when using layouts, consider using some other methods, such as bindings, instead.

Here are some things not to do with layouts:

Do not have bindings to the x, y, width, or height properties of items in a Layout, since this would conflict with the goal of the Layout, and also cause binding loops.
Do not define complex JavaScript functions that are regularly evaluated. This will cause poor performance, particularly during animated transitions.
Do not make assumptions about the container size, or about the size of child items. Try to make flexible layout definitions that can absorb changes in the available space.
Do not use layouts if you want the design to be pixel perfect. Content items will be automatically resized and positioned depending on the space available.
Using Bindings
If Qt Quick Layouts do not fit your needs, you can fall back to using property binding. Binding enables objects to automatically update their properties in response to changing attributes in other objects or the occurrence of some external event.

When an object's property is assigned a value, it can either be assigned a static value, or bound to a JavaScript expression. In the former case, the property's value will not change unless a new value is assigned to the property. In the latter case, a property binding is created and the property's value is automatically updated by the QML engine whenever the value of the evaluated expression changes.

This type of positioning is the most highly dynamic. However, constantly evaluating JavaScript expressions comes with a performance cost.

You can use bindings to handle low and high pixel density on platforms that do not have automatic support for it (like Android, macOS and iOS do). The following code snippet uses the Screen.pixelDensity attached property to specify different images to display on screens with low, high, or normal pixel density:

Image {
    source: {
        if (Screen.pixelDensity < 40)
        "image_low_dpi.png"
        else if (Screen.pixelDensity > 300)
        "image_high_dpi.png"
        else
        "image.png"
        }
    }

On Android, macOS and iOS, you can provide alternative resources with higher resolutions by using the corresponding identifier (e.g. @2x, @3x, or @4x) for icons and images, and place them in the resource file. The version that matches the pixel density of the screen is automatically selected for use.

For example, the following code snippet will try to load artwork@2x.png on Retina displays:

Image {
    source: "artwork.png"
}

Handling Pixel Density
Some QML types, such as Image, BorderImage, and Text, are automatically scaled according to the properties specified for them. If the width and height of an Image are not specified, it automatically uses the size of the source image, specified using the source property. By default, specifying the width and height causes the image to be scaled to that size. This behavior can be changed by setting the fillMode property, allowing the image to be stretched and tiled instead. However, the original image size might appear too small on high DPI displays.

A BorderImage is used to create borders out of images by scaling or tiling parts of each image. It breaks a source image into 9 regions that are scaled or tiled according to property values. However, the corners are not scaled at all, which can make the results less than optimal on high DPI displays.

A Text QML type attempts to determine how much room is needed and set the width and height properties accordingly, unless they are explicitly set. The fontPointSize property sets the point size in a device-independent manner. However, specifying fonts in points and other sizes in pixels causes problems, because points are independent of the display density. A frame around a string that looks correct on low DPI displays is likely to become too small on high DPI displays, causing the text to be clipped.

The level of high DPI support and the techniques used by the supported platforms varies from platform to platform. The following sections describe different approaches to scaling screen contents on high DPI displays.

For more information about high DPI support in Qt and the supported platforms, see High DPI.

High DPI Scaling
If a target device supports high DPI scaling, the operating system provides Qt with a scaling ratio that is used to scale graphics output.

The advantage of this approach is that vector graphics and fonts scale automatically and existing applications tend to work unmodified. For raster content, high-resolution alternative resources are needed, however.

Scaling is implemented for the Qt Quick and Qt Widgets stacks, as well as general support in Qt Gui.

Low level graphics APIs operate in device pixels. This includes code which uses the OpenGL API, and code which uses the QRhi API. For example, this means that a QWindow with a size() of 1280x720 and a QWindow::devicePixelRatio() of 2 has a render target (swapchain) with a device pixel size of 2560x1440.

The OS scales window, event, and desktop geometry. The Cocoa platform plugin sets the scaling ratio as QWindow::devicePixelRatio() or QScreen::devicePixelRatio(), as well as on the backing store.

For Qt Widgets, QPainter picks up devicePixelRatio() from the backing store and interprets it as a scaling ratio.

However, in OpenGL, pixels are always device pixels. For example, geometry passed to glViewport() needs to be scaled by devicePixelRatio().

The specified font sizes (in points or pixels) do not change and strings retain their relative size compared to the rest of the UI. Fonts are scaled as a part of painting, so that a size 12 font effectively becomes a size 24 font with 2x scaling, regardless of whether it is specified in points or in pixels. The px unit is interpreted as device independent pixels to ensure that fonts do not appear smaller on a high DPI display.

Calculating Scaling Ratio
You can select one high DPI device as a reference device and calculate a scaling ratio for adjusting image and font sizes and margins to the actual screen size.

The following code snippet uses reference values for DPI, height, and width from the Nexus 5 Android device, the actual screen size returned by the QRect class, and the logical DPI value of the screen returned by the qApp global pointer to calculate a scaling ratio for image sizes and margins (m_ratio) and another for font sizes (m_ratioFont):

qreal refDpi = 216.;
qreal refHeight = 1776.;
qreal refWidth = 1080.;
QRect rect = QGuiApplication::primaryScreen()->geometry();
qreal height = qMax(rect.width(), rect.height());
qreal width = qMin(rect.width(), rect.height());
qreal dpi = QGuiApplication::primaryScreen()->logicalDotsPerInch();
m_ratio = qMin(height/refHeight, width/refWidth);
m_ratioFont = qMin(height*refDpi/(dpi*refHeight), width*refDpi/(dpi*refWidth));

For a reasonable scaling ratio, the height and width values must be set according to the default orientation of the reference device, which in this case is the portrait orientation.

The following code snippet sets the font scaling ratio to 1 if it would be less than one and thus cause the font sizes to become too small:

int tempTimeColumnWidth = 600;
int tempTrackHeaderWidth = 270;
if (m_ratioFont < 1.) {
    m_ratioFont = 1;

You should experiment with the target devices to find edge cases that require additional calculations. Some screens might just be too short or narrow to fit all the planned content and thus require their own layout. For example, you might need to hide or replace some content on screens with atypical aspect ratios, such as 1:1.

The scaling ratio can be applied to all sizes in a QQmlPropertyMap to scale images, fonts, and margins:

m_sizes = new QQmlPropertyMap(this);
m_sizes->insert(QLatin1String("trackHeaderHeight"), QVariant(applyRatio(270)));
m_sizes->insert(QLatin1String("trackHeaderWidth"), QVariant(applyRatio(tempTrackHeaderWidth)));
m_sizes->insert(QLatin1String("timeColumnWidth"), QVariant(applyRatio(tempTimeColumnWidth)));
m_sizes->insert(QLatin1String("conferenceHeaderHeight"), QVariant(applyRatio(158)));
m_sizes->insert(QLatin1String("dayWidth"), QVariant(applyRatio(150)));
m_sizes->insert(QLatin1String("favoriteImageHeight"), QVariant(applyRatio(76)));
m_sizes->insert(QLatin1String("favoriteImageWidth"), QVariant(applyRatio(80)));
m_sizes->insert(QLatin1String("titleHeight"), QVariant(applyRatio(60)));
m_sizes->insert(QLatin1String("backHeight"), QVariant(applyRatio(74)));
m_sizes->insert(QLatin1String("backWidth"), QVariant(applyRatio(42)));
m_sizes->insert(QLatin1String("logoHeight"), QVariant(applyRatio(100)));
m_sizes->insert(QLatin1String("logoWidth"), QVariant(applyRatio(286)));

m_fonts = new QQmlPropertyMap(this);
m_fonts->insert(QLatin1String("six_pt"), QVariant(applyFontRatio(9)));
m_fonts->insert(QLatin1String("seven_pt"), QVariant(applyFontRatio(10)));
m_fonts->insert(QLatin1String("eight_pt"), QVariant(applyFontRatio(12)));
m_fonts->insert(QLatin1String("ten_pt"), QVariant(applyFontRatio(14)));
m_fonts->insert(QLatin1String("twelve_pt"), QVariant(applyFontRatio(16)));

m_margins = new QQmlPropertyMap(this);
m_margins->insert(QLatin1String("five"), QVariant(applyRatio(5)));
m_margins->insert(QLatin1String("seven"), QVariant(applyRatio(7)));
m_margins->insert(QLatin1String("ten"), QVariant(applyRatio(10)));
m_margins->insert(QLatin1String("fifteen"), QVariant(applyRatio(15)));
m_margins->insert(QLatin1String("twenty"), QVariant(applyRatio(20)));
m_margins->insert(QLatin1String("thirty"), QVariant(applyRatio(30)));

The functions in the following code snippet apply the scaling ratio to fonts, images, and margins:

int Theme::applyFontRatio(const int value)
{
    return int(value * m_ratioFont);
}

int Theme::applyRatio(const int value)
{
    return qMax(2, int(value * m_ratio));
}

This technique gives you reasonable results when the screen sizes of the target devices do not differ too much. If the differences are huge, consider creating several different layouts with different reference values.

Loading Files Depending on Platform
You can use the QQmlFileSelector to apply a QFileSelector to QML file loading. This enables you to load alternative resources depending on the platform on which the application is run. For example, you can use the +android file selector to load different image files when run on Android devices.

You can use file selectors together with singleton objects to access a single instance of an object on a particular platform.

File selectors are static and enforce a file structure where platform-specific files are stored in subfolders named after the platform. If you need a more dynamic solution for loading parts of your UI on demand, you can use a Loader.

The target platforms might automate the loading of alternative resources for different display densities in various ways. On Android and iOS, the @2x filename suffix is used to indicate high DPI versions of images. The Image QML type and the QIcon class automatically load @2x versions of images and icons if they are provided. The QImage and QPixmap classes automatically set the devicePixelRatio of @2x versions of images to 2, but you need to add code to actually use the @2x versions:

if ( QGuiApplication::primaryScreen()->devicePixelRatio() >= 2 ) {
    imageVariant = "@2x";
} else {
    imageVariant = "";
}

Android defines generalized screen sizes (small, normal, large, xlarge) and densities (ldpi, mdpi, hdpi, xhdpi, xxhdpi, and xxxhdpi) for which you can create alternative resources. Android detects the current device configuration at runtime and loads the appropriate resources for your application. However, beginning with Android 3.2 (API level 13), these size groups are deprecated in favor of a new technique for managing screen sizes based on the available screen width.

Loading Components on Demand
A Loader can load a QML file (using the source property) or a Component object (using the sourceComponent property). It is useful for delaying the creation of a component until it is required. For example, when a component should be created on demand, or when a component should not be created unnecessarily for performance reasons.

You can also use loaders to react to situations where parts of your UI are not needed on a particular platform, because the platform does not support some functionality. Instead of displaying a view that is not needed on the device the application is running on, you can determine that the view is hidden and use loaders to display something else in its place.

Switching Orientation
The Screen.orientation attached property contains the current orientation of the screen, from the accelerometer (if available). On a desktop computer, this value typically does not change.

If primaryOrientation follows orientation, it means that the screen automatically rotates all content that is displayed, depending on how you hold the device. If orientation changes even though primaryOrientation does not change, the device might not rotate its own display. In that case, you may need to use Item.rotation or Item.transform to rotate your content.

Application top-level page definitions and reusable component definitions should use one QML layout definition for the layout structure. This single definition should include the layout design for separate device orientations and aspect ratios. The reason for this is that performance during an orientation switch is critical, and it is therefore a good idea to ensure that all of the components needed by both orientations are loaded when the orientation changes.

On the contrary, you should perform thorough tests if you choose to use a Loader to load additional QML that is needed in separate orientations, as this will affect the performance of the orientation change.

In order to enable layout animations between the orientations, the anchor definitions must reside within the same containing component. Therefore the structure of a page or a component should consist of a common set of child components, a common set of anchor definitions, and a collection of states (defined in a StateGroup) representing the different aspect ratios supported by the component.

If a component contained within a page needs to be hosted in numerous different form factor definitions, then the layout states of the view should depend on the aspect ratio of the page (its immediate container). Similarly, different instances of a component might be situated within numerous different containers in a UI, and so its layout states should be determined by the aspect ratio of its parent. The conclusion is that layout states should always follow the aspect ratio of the direct container (not the "orientation" of the current device screen).

Within each layout State, you should define the relationships between items using native QML layout definitions. See below for more information. During transitions between the states (triggered by the top level orientation change), in the case of anchor layouts, AnchorAnimation elements can be used to control the transitions. In some cases, you can also use a NumberAnimation on e.g. the width of an item. Remember to avoid complex JavaScript calculations during each frame of animation. Using simple anchor definitions and anchor animations can help with this in the majority of cases.

There are a few additional cases to consider:

What if you have a single page that looks completely different between landscape and portrait, that is, all of the child items are different? For each page, have two child components, with separate layout definitions, and make one or other of the items have zero opacity in each state. You can use a cross-fade animation by simply applying a NumberAnimation transition to the opacity.
What if you have a single page that shares 30% or more of the same layout contents between portrait and landscape? In that case, consider having one component with landscape and portrait states, and a collection of separate child items whose opacity (or position) depends on the orientation state. This will enable you to use layout animations for the items that are shared between the orientations, whilst the other items are either faded in/out, or animated on/off screen.
What if you have two pages on a handheld device that need to be on screen at the same time, for example on a larger form factor device? In this case, notice that your view component will no longer be occupying the full screen. Therefore it's important to remember in all components (in particular, list delegate items) should depend on the size of the containing component width, not on the screen width. It may be necessary to set the width in a Component.onCompleted() handler in this case, to ensure that the list item delegate has been constructed before the value is set.
What if the two orientations take up too much memory to have them both in memory at once? Use a Loader if necessary, if you cannot keep both versions of the view in memory at once, but beware performance on the cross-fade animation during layout switch. One solution could be to have two "splash screen" items that are children of the Page, then you cross fade between those during rotation. Then you can use a Loader to load another child component that loads the actual model data to another child Item, and cross-fade to that when the Loader has completed.
