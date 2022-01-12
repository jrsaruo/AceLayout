# AceLayout

AceLayout provides a Swifty DSL for Auto Layout.

[![Test](https://github.com/jrsaruo/AceLayout/actions/workflows/test.yml/badge.svg)](https://github.com/jrsaruo/AceLayout/actions/workflows/test.yml) [![codecov](https://codecov.io/gh/jrsaruo/AceLayout/branch/main/graph/badge.svg?token=NN5TRPRC5O)](https://codecov.io/gh/jrsaruo/AceLayout)

## Requirements

- iOS 9.0+ / macOS 10.11+ / tvOS 9.0+
- Xcode 13+
- Swift 5.5+

## Features

- **Strongly typed.**
  - The compiler does not accept wrong constraints such as `some.top == another.leading`.
- **Simple, modern and unmistakable APIs.**
- **No need to write boilerplates.**
  - `view.translatesAutoresizingMaskIntoConstraints = false`
  - `constraint.isActive = true`

## Usage

### Basic

#### Constraints Building

Call the `autoLayout` method of your `UIView`, `UILayoutGuide`, `NSView` or `NSLayoutGuide` with a closure that describes Auto Layout constraints.

```swift
view.autoLayout { item in
    item.top.equal(to: anotherView, plus: 16)          // to UIView
    item.bottom.equalToSuperview()                     // to superview
    item.leading.equal(to: layoutMarginsGuide)         // to UILayoutGuide
    item.trailing.equal(to: anotherView.centerXAnchor) // to NSLayoutAnchor
    item.width.equal(to: 100)                          // to constant
    item.height.equal(to: item.width)                  // to LayoutAnchor
}
```

In the example, the followings are done automatically:

- Set `view.translatesAutoresizingMaskIntoConstraints` to `false`.

- Activates all constraints.

#### Relations

```swift
view.autoLayout { item in
    item.top.greaterThanOrEqual(to: safeAreaLayoutGuide)
    item.bottom.lessThanOrEqualToSuperview()
}
```

#### Priority

`UILayoutPriority` and `NSLayoutConstraint.Priority` are available.

```swift
view.autoLayout { item in
    item.center.equalToSuperview().priority(.required)
    item.size.equal(toSquare: 100).priority(.defaultHigh)
}
```

#### Deactivated Constraints

You can specify an argument `activates` to determine whether to immediately activate constraints.

```swift
let constraints = view.autoLayout(activates: false) { item in
    item.edges.equal(to: anotherView)
}
// All constraints are not active.
assert(constraints.allSatisfy { !$0.isActive })

// You can activate them at any time.
NSLayoutConstraint.activate(constraints)
```

### Convenient Anchors

#### Point

```swift
view.autoLayout { item in
    item.center.equal(to: anotherView)
    item.topLeading.equalToSuperview()
}
```

#### Size

```swift
view.autoLayout { item in
    item.size.equal(to: CGSize(width: 100, height: 200))
}
```

#### HorizontalEdges and VerticalEdges

```swift
view.autoLayout { item in
    item.leadingTrailing.equal(to: anotherView)
    item.topBottom.equalToSuperview(insetBy: 16)
}
```

#### Edges

```swift
view.autoLayout { item in
    item.edges.equalToSuperview(insetBy: 16)
}
```

## Available Anchors

### XAxis

- `leading`
- `trailing`
- `left`
- `right`
- `centerX`

### YAxis

- `top`
- `bottom`
- `centerY`

#### Baseline (only `UIView` / `NSView`)

- `firstBaseline`
- `lastBaseline`

### Dimension

- `width`
- `height`

### Point

- `center`
- `topLeading`
- `topTrailing`
- `topLeft`
- `topRight`
- `bottomLeading`
- `bottomTrailing`
- `bottomLeft`
- `bottomRight`

### Size

- `size`

### HorizontalEdges

- `leadingTrailing`
- `leftRight`

### VerticalEdges

- `topBottom`

### Edges

- `edges`

## Using AceLayout in your project

To use the `AceLayout` library in a SwiftPM project, add the following line to the dependencies in your `Package.swift` file:

```swift
.package(url: "https://github.com/jrsaruo/AceLayout", from "1.0.0"),
```

and add `AceLayout` as a dependency for your target:

```swift
.target(name: "<target>", dependencies: [
    .product(name: "AceLayout", package: "AceLayout"),
    // other dependencies
]),
```

FInally, add `import AceLayout` in your source code.
