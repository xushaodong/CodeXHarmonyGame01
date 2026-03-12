import { TileData } from '../model/TileData';
import { LevelSolver } from '../utils/LevelSolver';

const TILE_SIZE: number = 72;

@Component
export struct TileBoard {
  @Link tiles: TileData[];
  onTileClick: (tile: TileData) => void = () => {};

  private isPointInside(target: TileData, x: number, y: number): boolean {
    return x >= target.x && x <= target.x + TILE_SIZE && y >= target.y && y <= target.y + TILE_SIZE;
  }

  private pickTopClickableTile(tile: TileData): TileData | undefined {
    let centerX = tile.x + TILE_SIZE / 2;
    let centerY = tile.y + TILE_SIZE / 2;
    let candidates = this.tiles
      .filter(t => !t.removed && this.isPointInside(t, centerX, centerY))
      .sort((a, b) => b.layer - a.layer);
    return candidates.find(t => !t.blocked);
  }

  build() {
    Stack() {
      ForEach(this.tiles.filter(t => !t.removed).sort((a, b) => a.layer - b.layer), (tile: TileData) => {
        Column({ space: 2 }) {
          Text(tile.type)
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1F2937');
          Text(`L${tile.layer}`)
            .fontSize(10)
            .fontColor('#6B7280');
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .width(TILE_SIZE)
        .height(TILE_SIZE)
        .backgroundColor(tile.blocked ? '#E5E7EB' : '#FFFFFF')
        .borderRadius(12)
        .border({ width: 2, color: tile.blocked ? '#9CA3AF' : '#7C3AED' })
        .opacity(tile.blocked ? 0.6 : 1)
        .shadow({ radius: 6, color: '#22000000', offsetX: 1, offsetY: 2 })
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
    .clip(true)
    .backgroundColor('#FFF8F0');
  }
}
