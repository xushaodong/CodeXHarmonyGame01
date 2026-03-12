import { TileData } from '../model/TileData';
import { LevelSolver } from '../utils/LevelSolver';

@Component
export struct TileBoard {
  @Link tiles: TileData[];
  onTileClick: (tile: TileData) => void = () => {};

  private pickTopClickableTile(tile: TileData): TileData | undefined {
    let candidates = this.tiles
      .filter(t => !t.removed && t.type === tile.type)
      .sort((a, b) => b.layer - a.layer);
    return candidates.find(t => !t.blocked);
  }

  build() {
    Stack() {
      ForEach(this.tiles.filter(t => !t.removed).sort((a, b) => a.layer - b.layer), (tile: TileData) => {
        Text(tile.type)
          .width(72)
          .height(72)
          .fontSize(36)
          .textAlign(TextAlign.Center)
          .backgroundColor(tile.blocked ? '#D1D5DB' : '#FFFFFF')
          .borderRadius(12)
          .border({ width: 1, color: tile.blocked ? '#9CA3AF' : '#7C3AED' })
          .opacity(tile.blocked ? 0.55 : 1)
          .position({ x: tile.x, y: tile.y })
          .onClick(() => {
            if (tile.blocked || tile.removed) {
              return;
            }
            let top = this.pickTopClickableTile(tile);
            if (top && top.id === tile.id) {
              this.onTileClick(tile);
              LevelSolver.recalcBlocked(this.tiles);
            }
          });
      }, (item: TileData) => item.id)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF8F0');
  }
}
