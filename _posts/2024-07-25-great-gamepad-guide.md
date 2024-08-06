---
title: "The Great (Web) Gamepad Guide of 2024"
image: "tbd"
---

Did you know you can play games in your browser with a gamepad? If you're on Chrome, you can try it out with the infamous dino game[^1]! Just connect a gamepad over Bluetooth or USB and you're good to go. This is possible on all websites in secure contexts thanks to the Gamepad API, which has been around for quite a while now.

That said, there are still many caveats, missing features and generally many interesting things about the state of the Gamepad API in 2024. In this post, we'll explore what's up and what's next for gamepad support on the web.

## The Basics

Getting data about connected game controllers is as simple as calling a single method on the `navigator` object:

```javascript
const gamepads = navigator.getGamepads();
```

This will return an array of `Gamepad` objects, each representing a connected (and active) gamepad. To activate a gamepad and make it visible to the browser, you need to press a button or move an axis on the controller. This is a fingerpriting protection mechanism to prevent websites from passively tracking users. We'll get into this in more detail later.

The state you get does not change, so you are responsible for re-querying the gamepads yourself[^2]. This is often done using the `requestAnimationFrame` API which is similar to `setTimeout`, but it gets called as soon as the browser is ready to paint the next frame, depending on the refresh rate of your display.

Another funny thing is that in Chrome the navigator.getgamepads() method always returns an array with 4 elements, each defaulting to `null` (in both Firefox and Safari you'll get an empty array when no gamepad is connected)[^3]. This means that you can't determine whether there is a connected gamepad depending on `gamepads.length`, but should instead do something like this:

```javascript
const isGamepadConnected = navigator.getGamepads().filter((g) => g).length > 0;
```

The API also offers two very useful events: `gamepadconnected` and `gamepaddisconnected`. We can use these two to prevent excessive polling for gamepads when there are none connected.

### Gamepad controls

Each Gamepad has two sets of controls: buttons and axes. Buttons are a simple array of `GamepadButton`, which, according to the spec should be placed in "decreasing order of importance". For instance, the Xbox Wireless controller's <kbd>A</kbd> button is on index 0, <kbd>B</kbd> is on index 1, and so on. Each `GamepadButton` these properties:

1. `pressed`: a boolean indicating whether the button is pressed or not. Most of the time, you're going to be using this one because it's the most useful and has the most compatibility across different controllers.
2. `touched`: a boolean indicating whether the button is touched or not. This property mostly mirrors the `pressed` property, and does not even exist in Safari's implementation. I am not aware of any controllers that use this property.
3. `value`: a float between 0 and 1 indicating how much the button is pressed. This is useful for analog buttons, like L2 (index 6) and R2 (index 7) on Xbox and PlayStation controllers. For most buttons, this is either 0 or 1.

Axes are a tiny bit more complicated: because the standard 2 analog sticks on a controller both represent 4 different directions, each gets direction pair gets its own axis ranging from -1 (all the way to the left/top) to 1 (all the way to the right/bottom). For instance, if you had the following values inside of `gamepad.axes`:

```javascript
[
  0.019607901573181152, 0.011764764785766602, -0.7254902124404907,
  0.48235297203063965,
];
```

it would mean the right one is moved to the left and down (axis indexes 2 and 3, respectively), while the left stick is not moved at all (not that there needs to be some tolerance for this, as the sticks are never perfectly centered [^4]).

### Putting it together

OK, now, let's put what we learned together we can make simple game controls for a game that doesn't exist:

```javascript
const gameloop = () => {
  const gamepads = navigator.getGamepads();
  const gamepad = gamepads[0];
  if (!gamepad) {
    return;
  }

  // check if the primary button is pressed (A on Xbox controllers and X on PlayStation controllers)
  if (gamepad.buttons[0].pressed) {
    jump();
  }

  if (gamepad.axes[0] > 0.1) {
    moveRight();
  } else if (gamepad.axes[0] < -0.1) {
    moveLeft();
  }

  requestAnimationFrame(gameloop);
};

window.addEventListener("gamepadconnected", (e) => {
  console.log("Gamepad connected!");
  requestAnimationFrame(gameloop);
});
```

## The gotchas

The Gamepad API spec defines something called a Standard Gamepad, which has exactly 17 buttons and 4 axes (this is to prevent fingerprinting, so a gamepad would advertise itself as having 16 buttons even if in reality it had less). Ideally, all gamepads would map to this mapping and be consistent across all platforms. In reality, this is far from the case.

To date, Chromium has built-in mappings for 55 controllers [[source](https://github.com/chromium/chromium/blob/f481da2acc7e286e2a17a25ce1ce8e2a2c32fbdb/device/gamepad/gamepad_standard_mappings_mac.mm#L778-L890)], Firefox for 40 [[source](https://github.com/mozilla/gecko-dev/blob/fa55b33a4b56f392bc5a0c7616e0dfe055112cb5/dom/gamepad/GamepadRemapping.h#L18-L99)] while Safari only has 9 [[source](https://github.com/WebKit/WebKit/tree/main/Tools/TestWebKitAPI/mac/GamepadMappings)]. That being said, I'd argue Safari has the most spec-compliant mappings, which helps in adoption of the API. It is the only browser consistently reporting 17 buttons and it swiftly adopted proposals like `vibrationActuator`. Let's dig deeper into the mappings.

### Sony DualSense

The controller released alongside the PlayStation 5 in 2020 is a great example of a controller with many inconsistencies. Its biggest part, the touch pad in the middle of the controller is only considered a button in Chrome, while the "mute mic" button is not mapped to anything anywhere [^5]. We can hope to get more use of the trackpad with the [proposed `GamepadTouch`](https://knyg.github.io/gamepad/extensions.html#gamepadtouch-interface) extension to the API, but for now, it's just a mostly-unsupported button.

Here is a diagram of the button mappings across different browsers:

{% picture /img/gamepads/dualsense.png %}

Note that because Firefox does not have a mapping for the controller (`gamepad.mapping === ""`), the button order is shuffled around and the D-Pad is not mapped at all to buttons, but to axes instead. There is also no support for partial button presses on the R2 and L2 triggers. Additionally, it's worth noting that for the controller, only Safari on macOS can vibrate the controller using the `vibrationActuator` API [[source](https://github.com/mdn/browser-compat-data/issues/12180#issuecomment-2211653079)].

If you are serious about supporting DualSense on the web, consider using the awesome [`dualsense-ts` library](https://github.com/nsfm/dualsense-ts), which uses the WebHID API to get low-level access to the hardware.

### Xbox Wireless Controller

The Xbox Wireless Controller is a great example of a controller with mappings in all major browser (most likely because it's remained mostly consistent since the Xbox One release in 2013). Here's the same diagram as above, but for the Xbox:

{% picture /img/gamepads/xbox.png %}

The only notable difference is that the Share button is only mapped in Chrome (with the other browsers keeping just 17 buttons for consistency).

## What's next

When looking into the future of the Gamepad API, there are a few things currently either pending implementation or still pending standardization:

### Touch events

Touch events have been a part of the Gamepad API extensions for quite a while now, but since April there has been an [active effort](https://github.com/w3c/gamepad/pull/198) to merge the minto the main spec. This would let browser communicate events using built-in touch pads on controllers like the DualSense and the Steam Controller and enable more complex interactions such as scrolling.

Touch events are also a very interesting topic when considering controllers for <abbr title="Extended Reality">XR</abbr>, which heavily feature trackpads on them, even to the extent that the `xr-standard` controller mapping includes it (and currently works around the platform limitation by surfacing it as an axis).

Chrome actually implemented this extension [last year](https://chromestatus.com/feature/4782975812108288), but I am yet to see the API work with any controller.

### Gamepad pose

Another proposal (currently part of the Gamepad Extensions) is called GamepadPose. This interface on the `Gamepad` object would enable tracking things like the acceleration, orientation and position of the controller in 3D space. This would allow for gestures like detecting shaking or supporting use-cases akin to Wii Sports. Lovely!

It's just a shame that the Xbox controller, which offers the best-in-class browser support and is what many people think of when mentioning a "game controller" does not offer any support for determining acceleration or the position in 3D space, in addition to the lack of a touch pad or even build-in batteries.

### An 18th button

The official specification also has an active issue attempting to introduce a button at index 17, defined as the "fourth button in center cluster". This would mean that Chrome's non-standard support for DualSense's trackpad, Xbox's Share and the Switch's Capture buttons would be considered compliant according to the Standard Gamepad mapping.

<figure>
 <img src="/img/gamepads/standard_gamepad.svg">
  <figcaption>The current <a href="https://w3c.github.io/gamepad/#remapping">Standard</a> gamepad mapping</figcaption>
</figure>

[^1]: Visit chrome://dino/
[^2]: In the past, Firefox actually implemented `gamepadbuttondown` and `gamepadbuttonup` events, but those are non-standard and shouldn't be used. A big reason why that is is that you just cannot control the amount of events that are to be dispatched, which can potentially lead to performance issues with the main thread being blocked for long periods of time when quickly triggering events such as by quickly moving the gamepad axes.
[^3]: This is unsurprisingly against the spec, which states that _to mitigate fingerprinting, getGamepads() returns an empty list before a gamepad user gesture has been seen._
[^4]: This is even worse with things like the Nintento Joy-Cons, which have a habit of [drifting](https://www.theverge.com/21504741/nintendo-switch-joy-con-drift-problem-explained).
[^5]: Besides Firefox when you connect the controller via cable. In that case, it's mapped to button 14.

