
export class Visibility {
  private readonly hiddenClass = 'hidden';
  constructor() { }

  public switch(el_id): void {
    const el = document.getElementById(el_id);
    if (!el) {
      console.debug(`${el_id} missing from DOM`);
      return;
    }
    el.classList.contains(this.hiddenClass) ?
      el.classList.remove(this.hiddenClass) : el.classList.add(this.hiddenClass);
  }

  public rotate(el_id, deg): void {
    const el = document.getElementById(el_id);
    if (!el) {
      console.debug(`${el_id} missing from DOM`);
      return;
    }
  }
}