import { Component } from '@angular/core'
import { RouterOutlet, RouterModule } from '@angular/router';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';
import { faCheck } from '@fortawesome/free-solid-svg-icons';

@Component({
  selector: 'modal-propers',
  standalone: true,
  imports: [
    RouterModule,
    RouterOutlet,
    FontAwesomeModule
  ],
  templateUrl: './modal-propers.component.html',
  styleUrl: './modal-propers.component.css'
})
export class ModalPropersComponent {
  title = 'angular-android';
  celebrations: any[] = []
  language: string = "English"

  faCheck = faCheck;

  celebrationTitle = ""

  constructor (
    public activeModal: NgbActiveModal
  ) {
    
  }

  public UpdateCelebrations ( title: string ) {
    this.celebrationTitle = title
  }
  
  public dismiss ( ) {
    this.activeModal.close()
  }
}
