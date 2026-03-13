export class AccountService {
  async silentLogin(): Promise<{ uid: string; name: string; avatar: string }> {
    return { uid: 'mock_uid', name: 'Harmony玩家', avatar: '' };
  }
}

export class CloudService {
  async syncProgress(_: number): Promise<void> {}
  async loadProgress(): Promise<number> {
    return 1;
  }
}

export class AdsService {
  async preloadReward(): Promise<void> {}
  async showRewardAd(): Promise<boolean> {
    return true;
  }
}

export class PayService {
  async buyProduct(_: string): Promise<boolean> {
    return true;
  }
}

export class ShareService {
  async shareText(_: string): Promise<void> {}
}
