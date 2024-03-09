import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { RouteReuseStrategy } from '@angular/router';

import { IonicModule, IonicRouteStrategy } from '@ionic/angular';

import { AppComponent } from './app.component';
import { AppRoutingModule } from './app-routing.module';
import { OrdoComponent } from './ordo/ordo.component';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { InfoComponent } from './info/info.component';
import { LocaleComponent } from './locale/locale.component';
import { ModalPropersComponent } from './modal-propers/modal-propers.component';
import { ModalTextComponent } from './modal-text/modal-text.component';
import { PrayerComponent } from './prayers/prayer.component';
import { SettingsComponent } from './settings/settings.component';
import { TabBarComponent } from './tabbar/tabbar.component';
import { FormsModule } from '@angular/forms';
import { DataService } from './data.service';

import { HttpClientModule } from "@angular/common/http"
import { HeaderComponent } from './header/header.component';

@NgModule({
  declarations: [
    AppComponent,
    OrdoComponent,
    InfoComponent,
    LocaleComponent,
    ModalPropersComponent,
    ModalTextComponent,
    PrayerComponent,
    SettingsComponent,
    TabBarComponent,
    HeaderComponent
  ],
  imports: [
    FormsModule,
    BrowserModule,
    IonicModule.forRoot(),
    AppRoutingModule,
    FontAwesomeModule,
    HttpClientModule,
  ],
  providers: [
    DataService,
    { provide: RouteReuseStrategy, useClass: IonicRouteStrategy }
  ],
  bootstrap: [
    AppComponent
  ],
})
export class AppModule {}
