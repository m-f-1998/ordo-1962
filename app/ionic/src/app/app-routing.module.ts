import { NgModule } from "@angular/core"
import { PreloadAllModules, RouterModule, Routes } from "@angular/router"
import { OrdoComponent } from "./ordo/ordo.component"
import { PrayerComponent } from "./prayers/prayer.component"
import { SettingsComponent } from "./settings/settings.component"
import { InfoComponent } from "./info/info.component"
import { LocaleComponent } from "./locale/locale.component"

const routes: Routes = [
  {
    path: "",
    redirectTo: "ordo",
    pathMatch: "full",
  },
  { path: "ordo", component: OrdoComponent },
  { path: "prayers", component: PrayerComponent },
  { path: "settings", component: SettingsComponent },
  { path: "info", component: InfoComponent },
  { path: "locale", component: LocaleComponent },
  { path: "locale/:country", component: LocaleComponent },
]

@NgModule({
  imports: [RouterModule.forRoot(routes, { preloadingStrategy: PreloadAllModules })],
  exports: [RouterModule],
})
export class AppRoutingModule {}
