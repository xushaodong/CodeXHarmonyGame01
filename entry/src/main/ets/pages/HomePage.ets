@Component
export struct HomePage {
  build() {
    Column({ space: 12 }) {
      Text('叠叠消 HarmonyOS').fontSize(28).fontWeight(FontWeight.Bold);
      Text('继续游戏 / 每日挑战 / 排行榜 / 商城').fontColor('#6B7280');
      Button('进入游戏');
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .padding(16);
  }
}
