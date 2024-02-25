import { Routes } from '@angular/router'
import { OrdoComponent } from './components/ordo/ordo.component'
import { PrayerComponent } from './components/prayers/prayer.component'
import { SettingsComponent } from './components/settings/settings.component'
import { InfoComponent } from './components/info/info.component'
import { LocaleComponent } from './components/locale/locale.component'

export const routes: Routes = [
  { path: '', redirectTo: 'ordo', pathMatch: 'full' },
  { path: 'ordo', component: OrdoComponent },
  { path: 'prayers', component: PrayerComponent },
  { path: 'settings', component: SettingsComponent },
  { path: 'info', component: InfoComponent },
  { path: 'locale', component: LocaleComponent },
  { path: 'locale/:country', component: LocaleComponent }
]
