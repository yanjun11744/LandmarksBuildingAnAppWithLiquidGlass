/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that shows the featured landmark with a large image.
*/

import SwiftUI

/// A view that shows the featured landmark with a large image.
struct LandmarkFeaturedItemView: View {
    // 模型数据
    @Environment(ModelData.self) var modelData
    // 地标
    let landmark: Landmark

    var body: some View {
        // 导航链接
        NavigationLink(value: landmark) {
            // 装饰图像，用于装饰性图像
            Image(decorative: landmark.backgroundImageName)
                // 可变大小
                .resizable()
                .aspectRatio(contentMode: .fill)
                // 填充整个可用空间
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                // 裁剪超出部分
                .clipped()
                // 背景扩展效果，用于扩展背景图像，使其在边缘处透明，从而使文本更易读
                .backgroundExtensionEffect()
                // 叠加层，用于叠加内容
                .overlay(alignment: .bottom) {
                    // 垂直堆栈，用于垂直堆叠内容
                    VStack {
                        // 文本，用于显示大标题
                        Text("Featured Landmark", comment: "Big headline in the main image of featured landmarks.")
                            // 字体，用于设置字体
                            .font(.subheadline)
                            // 字体加粗
                            .fontWeight(.bold)
                            // 前景色，用于设置前景色
                            .foregroundColor(.white)
                            // 透明度，用于设置透明度
                            .opacity(0.8)
                        // 文本，用于显示地标名称
                        Text(landmark.name)
                            // 字体，用于设置字体
                            .font(.largeTitle)
                            // 字体加粗
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        // 按钮，用于显示学习更多按钮
                        Button("Learn More") {
                            // 添加地标到路径
                            modelData.path.append(landmark)
                        }
                        // 按钮样式，用于设置按钮样式
                        .buttonStyle(.borderedProminent)
                        // 底部内边距，用于设置底部内边距
                        .padding(.bottom, Constants.learnMorePadding)
                    }
                    // 底部内边距，用于设置底部内边距
                    .padding([.bottom], Constants.learnMoreBottomPadding)
                }
        }
        // 按钮样式，用于设置按钮样式，plain 表示普通按钮样式
        .buttonStyle(.plain)
    }
}

#Preview {
    let modelData = ModelData()
    let previewLandmark = modelData.landmarksById[1012] ?? modelData.landmarks.first!

    LandmarkFeaturedItemView(landmark: previewLandmark)
        .frame(height: 400.0)
        .environment(modelData)
}
