import { LevelConfig, TileData } from '../model/TileData';

export class LevelSolver {
  static createTiles(config: LevelConfig): TileData[] {
    let count = config.tileCount - (config.tileCount % 3);
    let triples = count / 3;
    let allTypes: string[] = [];

    for (let i = 0; i < triples; i++) {
      let type = config.tileTypes[i % config.tileTypes.length];
      allTypes.push(type, type, type);
    }

    this.shuffle(allTypes);

    let cols = 8;
    let rows = Math.ceil(count / cols);
    let tiles: TileData[] = [];

    allTypes.forEach((type, idx) => {
      let layer = idx % config.layers;
      let gridX = idx % cols;
      let gridY = Math.floor(idx / cols) % rows;
      tiles.push({
        id: `L${config.id}-${idx}`,
        type,
        x: 24 + gridX * 36 + (layer % 2) * 8,
        y: 24 + gridY * 34 + (layer % 3) * 8,
        layer,
        blockedRatio: 0,
        blocked: false,
        removed: false
      });
    });

    return this.recalcBlocked(tiles);
  }

  static recalcBlocked(tiles: TileData[]): TileData[] {
    let active = tiles.filter(t => !t.removed);
    active.forEach(t => {
      t.blockedRatio = 0;
      t.blocked = false;
    });

    for (let i = 0; i < active.length; i++) {
      for (let j = 0; j < active.length; j++) {
        if (i === j) {
          continue;
        }
        let a = active[i];
        let b = active[j];
        if (b.layer <= a.layer) {
          continue;
        }
        let overlap = this.overlapArea(a, b);
        if (overlap > 0) {
          a.blockedRatio += overlap / (72 * 72);
        }
      }
      active[i].blocked = active[i].blockedRatio > 0.8;
    }
    return tiles;
  }

  static overlapArea(a: TileData, b: TileData): number {
    let tileSize = 72;
    let x1 = Math.max(a.x, b.x);
    let y1 = Math.max(a.y, b.y);
    let x2 = Math.min(a.x + tileSize, b.x + tileSize);
    let y2 = Math.min(a.y + tileSize, b.y + tileSize);
    if (x2 <= x1 || y2 <= y1) {
      return 0;
    }
    return (x2 - x1) * (y2 - y1);
  }

  static shuffle<T>(arr: T[]): void {
    for (let i = arr.length - 1; i > 0; i--) {
      let j = Math.floor(Math.random() * (i + 1));
      let tmp = arr[i];
      arr[i] = arr[j];
      arr[j] = tmp;
    }
  }
}
