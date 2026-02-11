/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
View modifiers that stretch a view in a scroll view when a person scrolls beyond the top bounds.
*/

import SwiftUI
/// 灵活头几何，灵活头几何用于跟踪滚动视图的几何
@Observable private class FlexibleHeaderGeometry {
    // 偏移量，偏移量用于跟踪滚动视图的偏移量
    var offset: CGFloat = 0
}

/// A view modifer that stretches content when the containing geometry offset changes.
/// 灵活头内容修饰器，灵活头内容修饰器用于修饰内容
private struct FlexibleHeaderContentModifier: ViewModifier {
    // 模型数据
    @Environment(ModelData.self) private var modelData
    // 灵活头几何
    @Environment(FlexibleHeaderGeometry.self) private var geometry

    func body(content: Content) -> some View {
        // 计算高度，高度为窗口高度的一半减去偏移量
        let height = (modelData.windowSize.height / 2) - geometry.offset
        // 内容，内容用于显示内容
        content
            // 设置高度，高度为计算高度
            .frame(height: height)
            // 底部内边距，底部内边距用于设置底部内边距
            .padding(.bottom, geometry.offset)
            // 偏移量，偏移量用于设置偏移量
            .offset(y: geometry.offset)
    }
}

/// A view modifier that tracks scroll view geometry to stretch a view with ``FlexibleHeaderContentModifier``.
/// 灵活头滚动视图修饰器，灵活头滚动视图修饰器用于修饰滚动视图
private struct FlexibleHeaderScrollViewModifier: ViewModifier {
    // 灵活头几何
    @State private var geometry = FlexibleHeaderGeometry()

    func body(content: Content) -> some View {
        // 内容，内容用于显示内容
        content
            // 滚动几何变化，滚动几何变化用于跟踪滚动视图的几何变化
            .onScrollGeometryChange(for: CGFloat.self) { geometry in
                min(geometry.contentOffset.y + geometry.contentInsets.top, 0)
            } action: { _, offset in
                geometry.offset = offset
            }
            .environment(geometry)
    }
}

// MARK: - View Extensions
/// 滚动视图扩展，滚动视图扩展用于扩展滚动视图
extension ScrollView {
    /// A function that returns a view after it applies `FlexibleHeaderScrollViewModifier` to it.
    /// 灵活头滚动视图，灵活头滚动视图用于修饰滚动视图
    @MainActor func flexibleHeaderScrollView() -> some View {
        modifier(FlexibleHeaderScrollViewModifier())
    }
}

extension View {
    /// A function that returns a view after it applies `FlexibleHeaderContentModifier` to it.
    func flexibleHeaderContent() -> some View {
        modifier(FlexibleHeaderContentModifier())
    }
}
