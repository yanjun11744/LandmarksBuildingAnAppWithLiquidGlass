/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that shows a featured landmark, and other landmarks organized by continent.
*/

import SwiftUI

/// A view that shows a featured landmark, and other landmarks organized by continent.
struct LandmarksView: View {
    @Environment(ModelData.self) private var modelData
    // 是否正在搜索
    @Environment(\.isSearching) private var isSearching
    
    var body: some View {
        // 绑定模型数据
        @Bindable var modelData = modelData

        ScrollView(showsIndicators: false) {
            // 懒加载堆栈
            LazyVStack(alignment: .leading, spacing: Constants.standardPadding) {

                // 显示精选地标，可选绑定，可选绑定，用于绑定可选值，可选值为模型数据中的精选地标
                LandmarkFeaturedItemView(landmark: modelData.featuredLandmark!)
                    // 灵活头内容，用于灵活头内容，如果去掉这个，精选地标显示全尺寸，而不是一半，
                    // 为什么在 MacBook 上看不到「拉伸」效果？
                    // 核心原因：这个拉伸效果依赖于「下拉超过顶部时出现的负偏移量」，而在 macOS 上几乎不会产生 / 报告这个负偏移，所以你只会看到普通滚动。
                     .flexibleHeaderContent()

                // 遍历大陆，大陆为模型数据中的大陆
                ForEach(ModelData.orderedContinents, id: \.self) { continent in
                    // 当前搜索文本（去掉首尾空格）
                    let searchText = modelData.searchString.trimmingCharacters(in: .whitespacesAndNewlines)
                    // 是否处于搜索状态且有有效关键字
                    let isFiltering = isSearching && !searchText.isEmpty
                    
                    // 组，组用于将内容分组，组内的内容可以有相同的样式
                    Group {
                        // 如果存在地标列表，地标列表为模型数据中的地标列表 ，地标列表为大陆中的地标
                        if let landmarkList = modelData.landmarksByContinent[continent] {
                            // 如果在搜索，则按名称过滤，否则使用完整列表
                            let displayedLandmarks: [Landmark] = isFiltering
                            ? landmarkList.filter { landmark in
                                // LocalizedStringResource 先转成 String 再做不区分大小写匹配
                                String(localized: landmark.name).localizedCaseInsensitiveContains(searchText)
                            }
                            : landmarkList
                            
                            // 只有在有可展示的地标时才显示标题和列表
                            if !displayedLandmarks.isEmpty {
                                ContinentTitleView(title: continent.name)
                                
                                // 显示地标列表，地标列表为大陆中的地标
                                LandmarkHorizontalListView(landmarkList: displayedLandmarks)
                                    // 容器相对帧，容器相对帧用于将容器相对于其父容器进行布局
                                    .containerRelativeFrame(.vertical) { height, axis in
                                        // 计算建议高度，建议高度为容器高度的百分比
                                        let proposedHeight = height * Constants.landmarkListPercentOfHeight
                                        // 如果建议高度大于最小高度，最小高度为常量
                                        if proposedHeight > Constants.landmarkListMinimumHeight {
                                            // 返回建议高度，建议高度为容器高度的百分比
                                            return proposedHeight
                                        }
                                        // 返回最小高度，最小高度为常量
                                        return Constants.landmarkListMinimumHeight
                                    }
                            }
                        }
                    }
                }
            }
        }
        // 灵活头滚动视图，灵活头滚动视图用于将内容相对于其父容器进行布局
        .flexibleHeaderScrollView()
        // 忽略键盘安全区域，忽略键盘安全区域用于忽略键盘安全区域
        .ignoresSafeArea(.keyboard)
        // 忽略顶部安全区域，忽略顶部安全区域用于忽略顶部安全区域
        .ignoresSafeArea(edges: .top)
        // 隐藏工具栏背景，隐藏工具栏背景用于隐藏工具栏背景
        .toolbarBackground(.hidden)
        // 移除标题工具栏，移除标题工具栏用于移除标题工具栏
        .toolbar(removing: .title)
        // 导航目的地，导航目的地用于导航目的地
        .navigationDestination(for: Landmark.self) { landmark in
            // 显示地标详情，地标详情为地标详情视图
            LandmarkDetailView(landmark: landmark)
        }
    }
}

private struct ContinentTitleView: View {
    // 标题
    var title: String
    
    var body: some View {
        // 文本，用于显示标题
        Text(title)
            // 字体，用于设置字体
            .font(.title2)
            // 字体加粗
            .bold()
            // 顶部内边距，用于设置顶部内边距
            .padding(.top, Constants.titleTopPadding)
            // 底部内边距，用于设置底部内边距
            .padding(.bottom, Constants.titleBottomPadding)
            // 左边内边距，用于设置左边内边距
            .padding(.leading, Constants.leadingContentInset)
    }
}

#Preview {
    @Previewable @State var modelData = ModelData()
    
    LandmarksView()
        .environment(modelData)
        .onGeometryChange(for: CGSize.self) { geometry in
            geometry.size
        } action: {
            modelData.windowSize = $0
        }
}
