import { CapacitorConfig } from "@capacitor/cli"

const config: CapacitorConfig = {
  appId: "com.mfrankland.ordo_1962",
  appName: "1962 Ordo",
  webDir: "www/browser",
  loggingBehavior: "production",
  plugins: {
    SplashScreen: {
      launchAutoHide: false,
      androidScaleType: "CENTER_CROP",
      splashFullScreen: false,
      splashImmersive: false
    },
  },
}

export default config
