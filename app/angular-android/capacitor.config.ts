import { CapacitorConfig } from '@capacitor/cli';

const config: CapacitorConfig = {
  appId: "com.mfrankland.ordo62",
  appName: "1962 Ordo",
  webDir: "www/browser",
  loggingBehavior: "debug",
  plugins: {
    CapacitorSQLite: {
      androidIsEncryption: true,
      androidBiometric: {
        biometricAuth : false,
        biometricTitle : "Biometric Login for 1962 Ordo Data",
        biometricSubTitle : "Log in using your biometric"
      }
    }
  }
};

export default config;