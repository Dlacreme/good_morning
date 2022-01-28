import { Notif } from "./notif";
import { Props } from "./props";
import { Visibility } from "./visibility";

(window as any).APP = {
  visibility: new Visibility(),
  props: new Props(),
  notif: new Notif(),
};