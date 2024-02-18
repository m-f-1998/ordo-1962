import { Component } from '@angular/core'
import { RouterOutlet, RouterModule } from '@angular/router';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';

@Component({
  selector: 'modal-text',
  standalone: true,
  imports: [
    RouterModule,
    RouterOutlet,
    FontAwesomeModule
  ],
  templateUrl: './modal-text.component.html',
  styleUrl: './modal-text.component.css'
})
export class ModalTextComponent {
  title = ""
  body = ""

  constructor (
    public activeModal: NgbActiveModal
  ) { }

  public dismiss ( ) {
    this.activeModal.close()
  }
}
