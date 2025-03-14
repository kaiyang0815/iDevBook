//
//  RichTextView.swift
//  iDevBook
//
//  Created by kaiyang0815 on 2025/3/13.
//
//

import SwiftUI
import UIKit

/// 自定义富文本视图，用于在SwiftUI中渲染HTML内容
struct RichTextView: UIViewRepresentable {
    let html: String
    @Binding var fontSize: CGFloat
    var textColor: UIColor = .label
    var linkColor: UIColor = .systemBlue
    var imageWidthMode: ImageWidthMode = .responsive
    var imageMaxWidth: String = "100%"
    var imageCornerRadius: CGFloat = 0
    var imageBorderWidth: CGFloat = 0
    var imageBorderColor: UIColor = .gray
    var onLinkTap: ((URL) -> Void)?
    var isSelectable: Bool = true
    var isEditable: Bool = false
    
    enum ImageWidthMode {
        case responsive
        case original
        case fixed
    }
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.isSelectable = isSelectable
        textView.isEditable = isEditable
        textView.isScrollEnabled = true
        textView.delegate = context.coordinator
        
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        updateAttributedText(textView)
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        // 当字体大小或其他属性变化时，更新文本
        updateAttributedText(uiView)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    private func getImageCSS() -> String {
        var css = "img {"
        
        switch imageWidthMode {
        case .responsive:
            css += "max-width: \(imageMaxWidth); height: auto; width: auto;"
        case .original:
            css += "width: auto; height: auto;"
        case .fixed:
            css += "width: \(imageMaxWidth); height: auto;"
        }
        
        if imageCornerRadius > 0 {
            css += "border-radius: \(imageCornerRadius)px;"
        }
        
        if imageBorderWidth > 0 {
            let borderColor = imageBorderColor.hexString
            css += "border: \(imageBorderWidth)px solid \(borderColor);"
        }
        
        css += "display: block; margin: 10px auto;"
        css += "}"
        
        return css
    }
    
    private func updateAttributedText(_ textView: UITextView) {
        if let attributedString = parseHTML(html) {
            textView.attributedText = attributedString
        }
    }
    
    private func parseHTML(_ html: String) -> NSAttributedString? {
        let imageCSS = getImageCSS()
        let htmlTemplate = """
        <!DOCTYPE html>
        <html>
        <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
            font-size: \(fontSize)px;
            color: #000000;
            line-height: 1.4;
            padding: 0;
            margin: 0;
        }
        a {
            color: #0000FF;
            text-decoration: underline;
        }
        \(imageCSS)
        </style>
        </head>
        <body>
        \(html)
        </body>
        </html>
        """
        
        guard let data = htmlTemplate.data(using: .utf8) else {
            return nil
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        do {
            let attributedString = try NSAttributedString(data: data, options: options, documentAttributes: nil)
            
            let mutableAttributedString = NSMutableAttributedString(attributedString: attributedString)
            
            mutableAttributedString.addAttribute(.foregroundColor, value: textColor, range: NSRange(location: 0, length: mutableAttributedString.length))
            
            mutableAttributedString.enumerateAttribute(.link, in: NSRange(location: 0, length: mutableAttributedString.length)) { value, range, _ in
                if value != nil {
                    mutableAttributedString.addAttribute(.foregroundColor, value: linkColor, range: range)
                }
            }
            
            return mutableAttributedString
        } catch {
            print("解析HTML错误: \(error)")
            return nil
        }
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: RichTextView
        
        init(_ parent: RichTextView) {
            self.parent = parent
        }
        
        func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
            parent.onLinkTap?(URL)
            return false
        }
    }
}

extension UIColor {
    var hexString: String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return String(
            format: "#%02X%02X%02X",
            Int(red * 255),
            Int(green * 255),
            Int(blue * 255)
        )
    }
}

extension RichTextView {
    init(html: String, fontSize: CGFloat = 16, textColor: UIColor = .label, linkColor: UIColor = .systemBlue, onLinkTap: ((URL) -> Void)? = nil) {
        self.html = html
        self._fontSize = .constant(fontSize)
        self.textColor = textColor
        self.linkColor = linkColor
        self.onLinkTap = onLinkTap
    }
}

#Preview {
    RichTextView(
        html:
            """
                <p>The <strong>safe area</strong> is the screen portion that remains unobstructed by system UI elements such as the status bar, navigation bar, tab bar, Dynamic Island, and home indicator.</p><p>By default, SwiftUI ensures that views are placed within this safe area to maintain visibility and accessibility. However, there are cases where developers need more control over how views interact with these boundaries.</p><figure class="kg-card kg-image-card kg-card-hascaption"><img src="https://www.createwithswift.com/content/images/2025/03/CleanShot-2025-03-09-at-15.36.10@2x.png" class="kg-image" alt="Placing UI components within the Safe Area Inset" loading="lazy" width="1512" height="768" srcset="https://www.createwithswift.com/content/images/size/w600/2025/03/CleanShot-2025-03-09-at-15.36.10@2x.png 600w, https://www.createwithswift.com/content/images/size/w1000/2025/03/CleanShot-2025-03-09-at-15.36.10@2x.png 1000w, https://www.createwithswift.com/content/images/2025/03/CleanShot-2025-03-09-at-15.36.10@2x.png 1512w" sizes="(min-width: 720px) 720px"><figcaption><span style="white-space: pre-wrap;">Layout iOS Safe Area from </span><a href="https://developer.apple.com/design/human-interface-guidelines/layout?ref=createwithswift.com#iOS-iPadOS-safe-areas"><span style="white-space: pre-wrap;">Apple Human Interface Guidelines</span></a></figcaption></figure><p>Safe Area Inserts allow developers to adjust the positioning and padding of views relative to the safe area. For example, they can create a <strong>custom navigation bar</strong> that extends to the screen&apos;s top edge or position overlays like tooltips, popovers, and floating buttons.</p><figure class="kg-card kg-image-card"><img src="https://www.createwithswift.com/content/images/2025/03/createwithswift.com-safearea-inset-swiftui-asset-01.png" class="kg-image" alt="Placing UI components within the Safe Area Inset" loading="lazy" width="1920" height="1080" srcset="https://www.createwithswift.com/content/images/size/w600/2025/03/createwithswift.com-safearea-inset-swiftui-asset-01.png 600w, https://www.createwithswift.com/content/images/size/w1000/2025/03/createwithswift.com-safearea-inset-swiftui-asset-01.png 1000w, https://www.createwithswift.com/content/images/size/w1600/2025/03/createwithswift.com-safearea-inset-swiftui-asset-01.png 1600w, https://www.createwithswift.com/content/images/2025/03/createwithswift.com-safearea-inset-swiftui-asset-01.png 1920w" sizes="(min-width: 720px) 720px"></figure><p>The <a href="https://developer.apple.com/documentation/swiftui/view/safeareainset(edge:alignment:spacing:content:)-4s51l?ref=createwithswift.com"><code>safeAreaInset(edge:alignment:spacing:content:)</code></a> modifier allows us to insert additional content along a specified edge of a view&#x2019;s safe area. We need to provide the following properties:</p><ul><li><code>edge</code>: Specifies the edge of the view&#x2019;s safe area (e.g., <code>.top</code>, <code>.bottom</code>, <code>.leading</code>, or <code>.trailing</code>).</li><li><code>alignment</code>: It&apos;s optional and determines how the inserted content is aligned.</li><li><code>spacing</code>: It&apos;s optional and adds spacing between the inset content and the main content.</li><li><code>content</code>: A closure that returns the view you wish to insert on that edge of the safe area.</li></ul>
            """
    )
}
