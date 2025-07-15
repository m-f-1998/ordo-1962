import { CapacitorConfig } from "@capacitor/cli"

const config: CapacitorConfig = {
  appId: "com.mfrankland.ordo_1962",
  appName: "1962 Ordo",
  webDir: "dist/browser",
  loggingBehavior: "production",
  plugins: {
    SplashScreen: {
      launchAutoHide: false,
      androidScaleType: "CENTER_CROP",
      splashFullScreen: true,
      splashImmersive: true,
      backgroundColor: "#FFFFFF",
      androidSplashResourceName: "splash",
      showSpinner: true,
      androidSpinnerStyle: "large",
    },
  },
}

export default config
