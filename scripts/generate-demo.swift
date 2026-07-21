#!/usr/bin/env swift

import AppKit
import ImageIO
import UniformTypeIdentifiers

private let canvas = NSSize(width: 1_000, height: 600)
private let outputPath = CommandLine.arguments.dropFirst().first ?? "docs/assets/demo.gif"

private struct Palette {
    static let page = NSColor(calibratedRed: 10 / 255, green: 14 / 255, blue: 24 / 255, alpha: 1)
    static let panel = NSColor(calibratedRed: 21 / 255, green: 24 / 255, blue: 42 / 255, alpha: 1)
    static let border = NSColor(calibratedRed: 44 / 255, green: 49 / 255, blue: 72 / 255, alpha: 1)
    static let text = NSColor(calibratedRed: 241 / 255, green: 244 / 255, blue: 251 / 255, alpha: 1)
    static let muted = NSColor(calibratedRed: 157 / 255, green: 165 / 255, blue: 187 / 255, alpha: 1)
    static let accent = NSColor(calibratedRed: 126 / 255, green: 224 / 255, blue: 210 / 255, alpha: 1)
    static let warm = NSColor(calibratedRed: 255 / 255, green: 208 / 255, blue: 128 / 255, alpha: 1)
    static let success = NSColor(calibratedRed: 159 / 255, green: 229 / 255, blue: 168 / 255, alpha: 1)
    static let dotRed = NSColor(calibratedRed: 255 / 255, green: 112 / 255, blue: 105 / 255, alpha: 1)
    static let dotYellow = NSColor(calibratedRed: 255 / 255, green: 204 / 255, blue: 102 / 255, alpha: 1)
    static let dotGreen = NSColor(calibratedRed: 104 / 255, green: 211 / 255, blue: 145 / 255, alpha: 1)
}

private enum Weight {
    case regular
    case medium
    case bold
}

private struct TextLine {
    let text: String
    let x: CGFloat
    let y: CGFloat
    let size: CGFloat
    let color: NSColor
    let weight: Weight

    init(
        _ text: String,
        x: CGFloat = 66,
        y: CGFloat,
        size: CGFloat = 23,
        color: NSColor = Palette.text,
        weight: Weight = .regular
    ) {
        self.text = text
        self.x = x
        self.y = y
        self.size = size
        self.color = color
        self.weight = weight
    }
}

private struct DemoFrame {
    let lines: [TextLine]
    let duration: Double
    let footer: String?

    init(lines: [TextLine], duration: Double, footer: String? = nil) {
        self.lines = lines
        self.duration = duration
        self.footer = footer
    }
}

private func font(size: CGFloat, weight: Weight) -> NSFont {
    switch weight {
    case .regular:
        return NSFont.monospacedSystemFont(ofSize: size, weight: .regular)
    case .medium:
        return NSFont.monospacedSystemFont(ofSize: size, weight: .medium)
    case .bold:
        return NSFont.monospacedSystemFont(ofSize: size, weight: .bold)
    }
}

private func drawText(_ line: TextLine) {
    let attributes: [NSAttributedString.Key: Any] = [
        .font: font(size: line.size, weight: line.weight),
        .foregroundColor: line.color
    ]
    let rect = NSRect(
        x: line.x,
        y: canvas.height - line.y - line.size - 6,
        width: canvas.width - line.x - 52,
        height: line.size + 14
    )
    (line.text as NSString).draw(in: rect, withAttributes: attributes)
}

private func drawCircle(x: CGFloat, yFromTop: CGFloat, radius: CGFloat, color: NSColor) {
    color.setFill()
    NSBezierPath(ovalIn: NSRect(
        x: x - radius,
        y: canvas.height - yFromTop - radius,
        width: radius * 2,
        height: radius * 2
    )).fill()
}

private func render(_ frame: DemoFrame) -> CGImage {
    guard let bitmap = NSBitmapImageRep(
        bitmapDataPlanes: nil,
        pixelsWide: Int(canvas.width),
        pixelsHigh: Int(canvas.height),
        bitsPerSample: 8,
        samplesPerPixel: 4,
        hasAlpha: true,
        isPlanar: false,
        colorSpaceName: .deviceRGB,
        bytesPerRow: 0,
        bitsPerPixel: 0
    ) else {
        fatalError("Could not create bitmap")
    }

    guard let context = NSGraphicsContext(bitmapImageRep: bitmap) else {
        fatalError("Could not create graphics context")
    }

    NSGraphicsContext.saveGraphicsState()
    NSGraphicsContext.current = context

    Palette.page.setFill()
    NSRect(origin: .zero, size: canvas).fill()

    let panelRect = NSRect(x: 24, y: 24, width: 952, height: 552)
    Palette.panel.setFill()
    NSBezierPath(roundedRect: panelRect, xRadius: 14, yRadius: 14).fill()
    Palette.border.setStroke()
    let border = NSBezierPath(roundedRect: panelRect, xRadius: 14, yRadius: 14)
    border.lineWidth = 2
    border.stroke()

    drawCircle(x: 54, yFromTop: 51, radius: 6, color: Palette.dotRed)
    drawCircle(x: 76, yFromTop: 51, radius: 6, color: Palette.dotYellow)
    drawCircle(x: 98, yFromTop: 51, radius: 6, color: Palette.dotGreen)
    drawText(TextLine("mindpowers", x: 394, y: 35, size: 17, color: Palette.muted, weight: .medium))

    Palette.border.setStroke()
    let divider = NSBezierPath()
    divider.move(to: NSPoint(x: 42, y: canvas.height - 73))
    divider.line(to: NSPoint(x: 958, y: canvas.height - 73))
    divider.lineWidth = 1
    divider.stroke()

    for line in frame.lines {
        drawText(line)
    }

    if let footer = frame.footer {
        drawText(TextLine(footer, x: 66, y: 536, size: 17, color: Palette.muted, weight: .medium))
    }

    NSGraphicsContext.restoreGraphicsState()

    guard let image = bitmap.cgImage else {
        fatalError("Could not create frame image")
    }
    return image
}

private let promptLines = [
    TextLine("> Help me write the Q1 business review.", y: 102, color: Palette.text, weight: .medium),
    TextLine("  Signups +8%. Week-4 retention: 61% -> 54%.", y: 141, color: Palette.muted),
    TextLine("  14 onboarding improvements shipped.", y: 180, color: Palette.muted)
]

private let frames = [
    DemoFrame(
        lines: promptLines,
        duration: 2.0,
        footer: "A rough ask goes in. Better questions start the work."
    ),
    DemoFrame(
        lines: promptLines + [
            TextLine("● mindstorming", y: 245, color: Palette.accent, weight: .bold),
            TextLine("Before I draft: what decision should this review", y: 289, weight: .medium),
            TextLine("help leadership make?", y: 325, weight: .medium)
        ],
        duration: 2.5,
        footer: "Mindpowers clarifies the job before producing prose."
    ),
    DemoFrame(
        lines: promptLines + [
            TextLine("● mindstorming", y: 245, color: Palette.accent, weight: .bold),
            TextLine("Before I draft: what decision should this review", y: 289, weight: .medium),
            TextLine("help leadership make?", y: 325, weight: .medium),
            TextLine("> Shift the Q2 roadmap toward retention.", y: 391, color: Palette.warm, weight: .medium)
        ],
        duration: 1.8,
        footer: "The intended decision changes the story."
    ),
    DemoFrame(
        lines: [
            TextLine("● mindstorming", y: 102, color: Palette.accent, weight: .bold),
            TextLine("Then growth isn't the story.", y: 159, size: 27, color: Palette.muted, weight: .medium),
            TextLine("Growth is masking", y: 224, size: 37, color: Palette.text, weight: .bold),
            TextLine("a retention problem.", y: 275, size: 37, color: Palette.text, weight: .bold),
            TextLine("Signups rose while week-4 retention fell, despite", y: 359, size: 21, color: Palette.muted),
            TextLine("14 onboarding releases.", y: 394, size: 21, color: Palette.muted)
        ],
        duration: 2.6,
        footer: "The useful insight appears before the first paragraph."
    ),
    DemoFrame(
        lines: [
            TextLine("Decision story locked", y: 102, size: 29, color: Palette.text, weight: .bold),
            TextLine("INSIGHT", y: 184, size: 18, color: Palette.accent, weight: .bold),
            TextLine("Retention fell despite 14 onboarding releases", x: 225, y: 181, size: 21, weight: .medium),
            TextLine("DECISION", y: 251, size: 18, color: Palette.warm, weight: .bold),
            TextLine("Reallocate Q2 capacity toward retention", x: 225, y: 248, size: 21, weight: .medium),
            TextLine("STATUS", y: 318, size: 18, color: Palette.success, weight: .bold),
            TextLine("Ready to draft", x: 225, y: 315, size: 21, weight: .medium)
        ],
        duration: 2.5,
        footer: "Clear intent becomes a contract for drafting."
    ),
    DemoFrame(
        lines: [
            TextLine("Draft opening", y: 102, size: 22, color: Palette.accent, weight: .bold),
            TextLine("Growth is masking a retention problem:", y: 173, size: 29, color: Palette.text, weight: .bold),
            TextLine("signups grew 8%, but week-4 retention fell", y: 221, size: 26, weight: .medium),
            TextLine("from 61% to 54% - despite shipping 14", y: 265, size: 26, weight: .medium),
            TextLine("onboarding improvements.", y: 309, size: 26, weight: .medium)
        ],
        duration: 3.0,
        footer: "Insight first. Evidence attached. No generic throat-clearing."
    ),
    DemoFrame(
        lines: [
            TextLine("Better questions", x: 168, y: 178, size: 44, color: Palette.text, weight: .bold),
            TextLine("before better documents.", x: 168, y: 237, size: 44, color: Palette.accent, weight: .bold),
            TextLine("validate  ·  shape  ·  draft  ·  review  ·  remember", x: 168, y: 344, size: 19, color: Palette.muted, weight: .medium)
        ],
        duration: 2.5
    )
]

let outputURL = URL(fileURLWithPath: outputPath)
try FileManager.default.createDirectory(
    at: outputURL.deletingLastPathComponent(),
    withIntermediateDirectories: true
)

let temporaryURL = FileManager.default.temporaryDirectory
    .appendingPathComponent("mindpowers-demo-\(UUID().uuidString).gif")

guard let destination = CGImageDestinationCreateWithURL(
    temporaryURL as CFURL,
    UTType.gif.identifier as CFString,
    frames.count,
    nil
) else {
    fatalError("Could not create GIF destination")
}

let gifProperties: [CFString: Any] = [
    kCGImagePropertyGIFLoopCount: 0
]
CGImageDestinationSetProperties(destination, [
    kCGImagePropertyGIFDictionary: gifProperties
] as CFDictionary)

for frame in frames {
    let frameProperties: [CFString: Any] = [
        kCGImagePropertyGIFDelayTime: frame.duration,
        kCGImagePropertyGIFUnclampedDelayTime: frame.duration
    ]
    CGImageDestinationAddImage(
        destination,
        render(frame),
        [kCGImagePropertyGIFDictionary: frameProperties] as CFDictionary
    )
}

guard CGImageDestinationFinalize(destination) else {
    fatalError("Could not finalize GIF")
}

if FileManager.default.fileExists(atPath: outputURL.path) {
    try FileManager.default.removeItem(at: outputURL)
}
try FileManager.default.moveItem(at: temporaryURL, to: outputURL)

print("generated: \(outputPath)")
