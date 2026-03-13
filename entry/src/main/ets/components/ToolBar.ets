import { ToolType } from '../model/TileData';

@Component
export struct ToolBar {
  tools: ToolType[] = ['undo', 'shuffle', 'hint', 'revive', 'expand'];
  @Prop counts: Map<ToolType, number> = new Map();
  onUse: (tool: ToolType) => void = () => {};

  private label(tool: ToolType): string {
    switch (tool) {
      case 'undo': return '撤回';
      case 'shuffle': return '洗牌';
      case 'hint': return '提示';
      case 'revive': return '复活';
      case 'expand': return '扩槽';
      default: return tool;
    }
  }

  build() {
    Row({ space: 8 }) {
      ForEach(this.tools, (tool: ToolType) => {
        Button(`${this.label(tool)} ${this.counts.get(tool) ?? 0}`)
          .fontSize(12)
          .height(36)
          .backgroundColor('#7C3AED')
          .fontColor(Color.White)
          .onClick(() => this.onUse(tool));
      })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly);
  }
}
