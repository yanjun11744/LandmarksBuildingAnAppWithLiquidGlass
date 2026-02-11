/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that shows a single landmark in a list.
*/

import SwiftUI

/// A view that shows a single landmark in a list.
struct LandmarkListItemView: View {
    // 地标
    let landmark: Landmark

    var body: some View {
        // 图像，图像用于显示图像
        Image(landmark.thumbnailImageName)
            // 可变大小
            .resizable()
            // 设置比例，设置比例为填充
            .aspectRatio(contentMode: .fill)
            // 设置框架，设置框架为最小宽度为0，最大宽度为无穷大，最小高度为0，最大高度为无穷大
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            // 覆盖，覆盖用于覆盖图像
            .overlay {
                // 可读性圆角矩形，可读性圆角矩形用于可读性圆角矩形
                ReadabilityRoundedRectangle()
            }
            // 裁剪，裁剪用于裁剪图像
            .clipped()
            // 圆角，圆角用于圆角图像
            .cornerRadius(Constants.cornerRadius)
            // 覆盖，覆盖用于覆盖图像
            .overlay(alignment: .bottom) {
                // 文本，文本用于显示文本
                Text(landmark.name)
                    // 字体，字体用于设置字体
                    .font(.title3).fontWeight(.semibold)
                    // 多行文本对齐，多行文本对齐用于多行文本对齐
                    .multilineTextAlignment(.center)
                    // 前景色，前景色用于设置前景色
                    .foregroundColor(.white)
                    // 底部内边距，底部内边距用于设置底部内边距
                    .padding(.bottom)
            }
            // 上下文菜单，上下文菜单用于上下文菜单
            .contextMenu {
                // 分享链接，分享链接用于分享链接
                ShareLink(item: landmark, preview: landmark.sharePreview)
                // 地标收藏按钮，地标收藏按钮用于地标收藏按钮
                LandmarkFavoriteButton(landmark: landmark)
                // 地标集合菜单，地标集合菜单用于地标集合菜单
                LandmarkCollectionsMenu(landmark: landmark)
            }
    }
}

#Preview {
    let modelData = ModelData()
    let previewLandmark = modelData.landmarksById[1001] ?? modelData.landmarks.first!
    LandmarkListItemView(landmark: previewLandmark)
        .frame(width: 252.0, height: 180.0)
}
