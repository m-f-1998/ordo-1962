import { ApplicationConfig } from '@angular/core';
import { InMemoryScrollingFeature, InMemoryScrollingOptions, provideRouter, withInMemoryScrolling } from '@angular/router';

import { routes } from './app.routes';
import { provideIonicAngular } from '@ionic/angular/standalone';

const scrollConfig: InMemoryScrollingOptions = {
  scrollPositionRestoration: 'top',
  anchorScrolling: 'enabled',
}

const inMemoryScrollingFeature: InMemoryScrollingFeature = withInMemoryScrolling ( scrollConfig )

export const appConfig: ApplicationConfig = {
  providers: [
    provideRouter ( routes, inMemoryScrollingFeature ), provideIonicAngular({})
  ]
};
