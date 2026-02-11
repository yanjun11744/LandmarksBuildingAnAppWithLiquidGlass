/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
An enumeration of navigation options in the app.
*/

import SwiftUI

/// An enumeration of navigation options in the app.
enum NavigationOptions: Equatable, Hashable, Identifiable {
    /// A case that represents viewing the app's landmarks, organized by continent.
    /// 表示查看应用的地标，按大陆组织
    case landmarks
    /// A case that represents viewing the app's landmarks on a map.
    /// 表示查看应用的地标地图
    case map
    /// A case that represents viewing a person's favorite landmarks and other custom landmark collections.
    /// 表示查看个人收藏的地标和其他自定义地标集合
    case collections
    
    /// 主页面
    static let mainPages: [NavigationOptions] = [.landmarks, .map, .collections]
    /// 主页面ID    String 类型
    var id: String {
        switch self {
        case .landmarks: return "landmarks"
        case .map: return "map"
        case .collections: return "collections"
        }
    }
    /// 主页面名称  LocalizedStringResource 类型
    var name: LocalizedStringResource {
        switch self {
        case .landmarks: return "landmarks"
        case .map: return "map"
        case .collections: return "collections"
        }
    }
    /// 主页面图标  String 类型
    var symbolName: String {
        switch self {
        case .landmarks: return "building.columns"
        case .map: return "map"
        case .collections: return "book.closed"
        }
    }
    /// A view builder that the split view uses to show a view for the selected navigation option.
    /// 返回一个视图，用于显示选定的导航选项
    @MainActor @ViewBuilder func viewForPage() -> some View {
        switch self {
        case .landmarks: LandmarksView()
        case .map: MapView()
        case .collections: CollectionsView()
        }
        
    }
}
