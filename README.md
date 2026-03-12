# 叠叠消 HarmonyOS (Tile Crush)

鸿蒙 NEXT 原生 ArkTS + ArkUI 休闲消除游戏示例工程（MVP）。

## 已实现能力（对应 PRD V2.0）
- 页面骨架：Splash/Home/Map/Game/Result/Shop/Profile/Settings。
- 核心玩法：叠层 tile 点击入槽、3 消、7 槽失败、清空胜利。
- 难度与关卡：内置关卡配置生成器，保证总数为 3 的倍数。
- 道具系统：撤回/洗牌/提示/复活/扩槽 的核心行为。
- 状态管理：`@Observed` + `@ObjectLink` 响应式状态更新。
- 折叠屏适配：基于断点切换 `compact/medium/expanded` 布局。
- 服务层占位：Account/Cloud/IAP/Ads/Share/Push 统一接口，便于接入 Huawei Kit。

## 工程结构
见 `entry/src/main/ets` 下 `pages/components/model/service/utils` 分层。

## 说明
本仓库为可扩展的鸿蒙小游戏工程骨架，重点完成了 PRD 的核心可玩闭环与架构拆分；
华为账号/支付/广告/云同步等需在真机与 AGC 环境下配置真实密钥后启用。
