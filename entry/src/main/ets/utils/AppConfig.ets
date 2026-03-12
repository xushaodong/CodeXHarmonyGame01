import { LevelConfig } from '../model/TileData';

export const APP_NAME = '叠叠消 HarmonyOS';

export const LEVELS: LevelConfig[] = [
  { id: 1, name: '新手 1', tileTypes: ['A', 'B', 'C', 'D'], tileCount: 60, layers: 3 },
  { id: 2, name: '新手 2', tileTypes: ['E', 'F', 'G', 'H', 'I'], tileCount: 72, layers: 3 },
  { id: 3, name: '成长 1', tileTypes: ['J', 'K', 'L', 'M', 'N', 'O'], tileCount: 90, layers: 4 },
  { id: 4, name: '成长 2', tileTypes: ['P', 'Q', 'R', 'S', 'T', 'U', 'V'], tileCount: 108, layers: 5 }
];

export const BREAKPOINTS = {
  compact: 0,
  medium: 600,
  expanded: 840
};
