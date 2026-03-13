import { GameStatus, TileData, ToolType } from './TileData';

@Observed
export class GameState {
  levelId: number = 1;
  score: number = 0;
  progress: number = 0;
  status: GameStatus = GameStatus.READY;

  boardTiles: TileData[] = [];
  slotCapacity: number = 7;
  slots: TileData[] = [];
  stash: TileData[] = [];

  tools: Map<ToolType, number> = new Map<ToolType, number>([
    ['undo', 3],
    ['shuffle', 2],
    ['hint', 3],
    ['revive', 1],
    ['expand', 1]
  ]);

  removedCount: number = 0;
  totalCount: number = 0;

  resetSlots(capacity?: number): void {
    this.slotCapacity = capacity ?? this.slotCapacity;
    this.slots = [];
    this.stash = [];
  }

  get emptySlotCount(): number {
    return this.slotCapacity - this.slots.length;
  }

  useTool(tool: ToolType): boolean {
    let count = this.tools.get(tool) ?? 0;
    if (count <= 0) {
      return false;
    }
    this.tools.set(tool, count - 1);
    return true;
  }
}
