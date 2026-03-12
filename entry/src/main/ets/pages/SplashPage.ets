@Component
export struct SplashPage {
  @State progress: number = 0;

  aboutToAppear(): void {
    this.progress = 80;
  }

  build() {
    Column({ space: 12 }) {
      Text('🐑 叠叠消').fontSize(36).fontWeight(FontWeight.Bold);
      Text('正在加载资源...').fontColor('#6B7280');
      Progress({ value: this.progress, total: 100 }).width('70%');
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center);
  }
}
