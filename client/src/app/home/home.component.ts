import { ChangeDetectionStrategy, Component } from "@angular/core"
import { PrivacyPolicyComponent } from "../components/privacy-policy/privacy-policy.component"
import { NavbarComponent } from "../components/navbar/navbar.component"
import { AboutComponent } from "../components/about/about.component"
import { HeaderComponent } from "../components/header/header.component"
import { FooterComponent } from "../components/footer/footer.component"

@Component ( {
  selector: "app-root",
  imports: [
    PrivacyPolicyComponent,
    HeaderComponent,
    NavbarComponent,
    AboutComponent,
    FooterComponent
  ],
  templateUrl: "./home.component.html",
  styleUrl: "./home.component.scss",
  changeDetection: ChangeDetectionStrategy.OnPush
} )
export class HomeComponent {
}
