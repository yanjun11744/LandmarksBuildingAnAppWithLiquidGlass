/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that scrolls a list of landmarks horizontally.
*/

import SwiftUI

/// A view that scrolls a list of landmarks horizontally.
struct LandmarkHorizontalListView: View {
    // 地标列表
    let landmarkList: [Landmark]

    var body: some View {
        // 水平滚动视图，水平滚动视图用于水平滚动地标列表，showsIndicators: false 用于隐藏指示器
        ScrollView(.horizontal, showsIndicators: false) {
            // 懒加载水平堆栈，懒加载水平堆栈用于懒加载水平堆栈
            LazyHStack(spacing: Constants.standardPadding) {
                // 空视图，空视图用于空视图
                Spacer()
                    // 设置宽度，宽度为常量
                    .frame(width: Constants.standardPadding)
                // 遍历地标列表
                ForEach(landmarkList) { landmark in
                    // 导航链接
                    NavigationLink(value: landmark) {
                        // 地标列表项视图
                        LandmarkListItemView(landmark: landmark)
                            // 设置比例，设置比例为常量
                            .aspectRatio(Constants.landmarkListItemAspectRatio, contentMode: .fill)
                    }
                    // 按钮样式，按钮样式用于按钮样式
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

#Preview {
    let modelData = ModelData()

    LandmarkHorizontalListView(landmarkList: modelData.landmarks)
        .frame(height: 180.0)
}
