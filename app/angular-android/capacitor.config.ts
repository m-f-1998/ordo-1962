import { CapacitorConfig } from '@capacitor/cli';

const config: CapacitorConfig = {
  appId: 'com.mfrankland.ordo62',
  appName: '1962 Liturgical Ordo',
  webDir: 'dist/angular-android/browser',
  server: {
    androidScheme: 'https'
  }
};

export default config;
