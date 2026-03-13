import { TileData } from '../model/TileData';

@Component
export struct SlotBar {
  @Link slots: TileData[];
  @Prop capacity: number = 7;

  build() {
    Row({ space: 8 }) {
      ForEach(Array.from({ length: this.capacity }, (_, i) => i), (idx: number) => {
        if (idx < this.slots.length) {
          Text(this.slots[idx].type)
            .width(44)
            .height(44)
            .fontSize(24)
            .textAlign(TextAlign.Center)
            .backgroundColor('#FFFFFF')
            .borderRadius(8)
            .border({ width: 1, color: '#8B5CF6' });
        } else {
          Blank()
            .width(44)
            .height(44)
            .backgroundColor('#C4B5FD')
            .borderRadius(8)
            .opacity(0.35);
        }
      })
    }
    .padding(12)
    .backgroundColor('#2D1B69')
    .borderRadius(12)
    .width('100%')
    .justifyContent(FlexAlign.Center);
  }
}
