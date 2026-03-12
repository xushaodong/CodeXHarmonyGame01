export interface TileData {
  id: string;
  type: string;
  x: number;
  y: number;
  layer: number;
  blockedRatio: number;
  blocked: boolean;
  removed: boolean;
}

export interface LevelConfig {
  id: number;
  name: string;
  tileTypes: string[];
  tileCount: number;
  layers: number;
  timeLimitSec?: number;
}

export enum GameStatus {
  READY = 'READY',
  PLAYING = 'PLAYING',
  PAUSED = 'PAUSED',
  WIN = 'WIN',
  LOSE = 'LOSE'
}

export type ToolType = 'undo' | 'shuffle' | 'hint' | 'revive' | 'expand';
