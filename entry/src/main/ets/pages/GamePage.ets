import { GameState } from '../model/GameState';
import { GameStatus, TileData, ToolType } from '../model/TileData';
import { LEVELS } from '../utils/AppConfig';
import { LevelSolver } from '../utils/LevelSolver';
import { SlotBar } from '../components/SlotBar';
import { TileBoard } from '../components/TileBoard';
import { ToolBar } from '../components/ToolBar';

@Entry
@Component
struct GamePage {
  @State gameState: GameState = new GameState();
  @State warningText: string = '';
  @State boardMode: 'compact' | 'expanded' = 'compact';

  aboutToAppear(): void {
    this.startLevel(1);
  }

  private startLevel(levelId: number): void {
    let level = LEVELS.find(item => item.id === levelId) ?? LEVELS[0];
    this.gameState.levelId = level.id;
    this.gameState.boardTiles = LevelSolver.createTiles(level);
    this.gameState.totalCount = this.gameState.boardTiles.length;
    this.gameState.removedCount = 0;
    this.gameState.score = 0;
    this.gameState.progress = 0;
    this.gameState.status = GameStatus.PLAYING;
    this.gameState.slotCapacity = 7;
    this.gameState.resetSlots(7);
    this.warningText = '';
  }

  private checkAndEliminate(): void {
    let typeMap = new Map<string, number[]>();
    this.gameState.slots.forEach((item, idx) => {
      let arr = typeMap.get(item.type) ?? [];
      arr.push(idx);
      typeMap.set(item.type, arr);
    });

    typeMap.forEach((indexes) => {
      if (indexes.length >= 3) {
        let removeSet = new Set(indexes.slice(0, 3));
        this.gameState.slots = this.gameState.slots.filter((_, idx) => !removeSet.has(idx));
        this.gameState.score += 30;
        this.gameState.removedCount += 3;
      }
    });

    this.gameState.progress = this.gameState.removedCount / this.gameState.totalCount;
  }

  private onTapTile(tile: TileData): void {
    if (this.gameState.status !== GameStatus.PLAYING) {
      return;
    }
    tile.removed = true;
    this.gameState.slots.push(tile);
    this.checkAndEliminate();
    LevelSolver.recalcBlocked(this.gameState.boardTiles);

    if (this.gameState.slots.length >= this.gameState.slotCapacity - 2) {
      this.warningText = '即将满槽！';
    }

    if (this.gameState.removedCount >= this.gameState.totalCount) {
      this.gameState.status = GameStatus.WIN;
      return;
    }

    if (this.gameState.slots.length >= this.gameState.slotCapacity) {
      this.gameState.status = GameStatus.LOSE;
      this.warningText = '收集槽已满，挑战失败';
    }
  }

  private onUseTool(tool: ToolType): void {
    if (!this.gameState.useTool(tool)) {
      this.warningText = '道具不足';
      return;
    }

    switch (tool) {
      case 'undo': {
        let tile = this.gameState.slots.pop();
        if (tile) {
          tile.removed = false;
          LevelSolver.recalcBlocked(this.gameState.boardTiles);
        }
        break;
      }
      case 'shuffle': {
        let active = this.gameState.boardTiles.filter(t => !t.removed);
        let positions = active.map(t => ({ x: t.x, y: t.y }));
        LevelSolver.shuffle(positions);
        active.forEach((tile, idx) => {
          tile.x = positions[idx].x;
          tile.y = positions[idx].y;
        });
        LevelSolver.recalcBlocked(this.gameState.boardTiles);
        break;
      }
      case 'hint': {
        let hints = this.gameState.boardTiles.filter(t => !t.removed && !t.blocked).slice(0, 3);
        this.warningText = hints.length > 0 ? `提示：优先点击 ${hints.map(h => h.type).join(' ')}` : '暂无可用提示';
        break;
      }
      case 'revive': {
        if (this.gameState.status === GameStatus.LOSE) {
          this.gameState.status = GameStatus.PLAYING;
          this.gameState.resetSlots(this.gameState.slotCapacity);
          this.warningText = '已复活，继续挑战';
        }
        break;
      }
      case 'expand': {
        this.gameState.slotCapacity += 2;
        this.warningText = `槽位扩展至 ${this.gameState.slotCapacity}`;
        break;
      }
    }
  }

  build() {
    Column({ space: 10 }) {
      Row() {
        Text(`关卡 ${this.gameState.levelId}`)
          .fontSize(20)
          .fontWeight(FontWeight.Bold);
        Blank();
        Text(`得分 ${this.gameState.score}`)
          .fontSize(16);
      }.width('100%');

      Progress({ value: this.gameState.progress * 100, total: 100 })
        .width('100%')
        .color(this.gameState.progress > 0.66 ? '#059669' : this.gameState.progress > 0.33 ? '#D97706' : '#DC2626');

      ToolBar({ counts: this.gameState.tools, onUse: (t: ToolType) => this.onUseTool(t) });

      TileBoard({ tiles: this.gameState.boardTiles, onTileClick: (t: TileData) => this.onTapTile(t) })
        .layoutWeight(1)
        .borderRadius(12);

      Text(`场上剩余：${this.gameState.totalCount - this.gameState.removedCount}`)
        .fontSize(12)
        .fontColor('#6B7280');

      SlotBar({ slots: this.gameState.slots, capacity: this.gameState.slotCapacity });

      if (this.warningText.length > 0) {
        Text(this.warningText).fontColor('#D97706').fontSize(14);
      }

      if (this.gameState.status === GameStatus.WIN) {
        Text('🎉 通关成功').fontColor('#059669').fontSize(20).fontWeight(FontWeight.Bold);
      }
      if (this.gameState.status === GameStatus.LOSE) {
        Text('💥 闯关失败').fontColor('#DC2626').fontSize(20).fontWeight(FontWeight.Bold);
      }
    }
    .padding(12)
    .backgroundColor('#F9FAFB')
    .width('100%')
    .height('100%');
  }
}
