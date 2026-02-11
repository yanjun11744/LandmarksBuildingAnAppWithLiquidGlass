/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that establishes split view navigation for the app.
*/

import SwiftUI

/// A view that establishes split view navigation for the app.
struct LandmarksSplitView: View {
    // 模型数据
    @Environment(ModelData.self) var modelData
    // 优先显示的列
    @State private var preferredColumn: NavigationSplitViewColumn = .detail

    var body: some View {
        // 绑定模型数据
        @Bindable var modelData = modelData
        
        NavigationSplitView(preferredCompactColumn: $preferredColumn) {
            List {
                Section {
                    // 遍历导航选项
                    ForEach(NavigationOptions.mainPages) { page in
                        // 导航链接
                        NavigationLink(value: page) {
                            Label(page.name, systemImage: page.symbolName)
                        }
                    }
                }
            }
            // 导航目的地
            .navigationDestination(for: NavigationOptions.self) { page in
                // 导航堆栈
                NavigationStack(path: $modelData.path) {
                    page.viewForPage()
                }
                // 导航目的地，显示地标详情
                .navigationDestination(for: Landmark.self) { landmark in
                    LandmarkDetailView(landmark: landmark)
                }
                // 导航目的地，显示地标集合详情
                .navigationDestination(for: LandmarkCollection.self) { collection in
                    CollectionDetailView(collection: collection)
                }
                // 显示徽章
                .showsBadges()
            }
            // 设置最小宽度
            .frame(minWidth: 150)
            // 详情视图
        } detail: {
            // 导航堆栈
            NavigationStack(path: $modelData.path) {
                NavigationOptions.landmarks.viewForPage()
            }
            // 导航目的地，显示地标详情
            .navigationDestination(for: Landmark.self) { landmark in
                LandmarkDetailView(landmark: landmark)
            }
            // 显示徽章
            .showsBadges()
        }
        // 添加全局搜索，系统自动在内容视图中定位搜索栏
        // in content views.
        .searchable(text: $modelData.searchString, prompt: "Search")
        // 添加检查器，地标详情视图使用它显示额外信息
        // additional information.
        .inspector(isPresented: $modelData.isLandmarkInspectorPresented) {
            if let landmark = modelData.selectedLandmark {
                // 地标详情检查器视图
                LandmarkDetailInspectorView(landmark: landmark, inspectorIsPresented: $modelData.isLandmarkInspectorPresented)
            } else {
                EmptyView()
            }
        }
    }
}

#Preview {
    @Previewable @State var modelData = ModelData()

    LandmarksSplitView()
        .environment(modelData)
        .onGeometryChange(for: CGSize.self) { geometry in
            geometry.size
        } action: {
            modelData.windowSize = $0
        }
}
