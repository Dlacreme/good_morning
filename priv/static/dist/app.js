var Type;
(function(Type2) {
  Type2["Info"] = "info";
  Type2["Warning"] = "warning";
  Type2["Error"] = "error";
})(Type || (Type = {}));
class Notif {
  constructor() {
    this.notifContainerId = "cc-notif-container";
  }
  info(content, timeout = 5e3) {
    return this.push(content, Type.Info, timeout);
  }
  warning(content, timeout = 5e3) {
    return this.push(content, Type.Warning, timeout);
  }
  error(content, timeout = 5e3) {
    return this.push(content, Type.Error, timeout);
  }
  push(content, type, timeout) {
    const el = document.createElement("div");
    const notification = {
      type,
      content,
      timeout,
      element: el
    };
    el.classList.add("cc-notif");
    el.classList.add(type.toString());
    const pContent = document.createElement("p");
    pContent.innerText = content;
    const closeBtn = document.createElement("button");
    const closeIcon = document.createElement("icon");
    closeIcon.classList.add("material-icons");
    closeIcon.innerText = "close";
    closeBtn.onclick = () => {
      this.clear(notification);
    };
    closeBtn.appendChild(closeIcon);
    el.appendChild(pContent);
    el.appendChild(closeBtn);
    this.addToDOM(notification);
    if (notification.timeout) {
      window.setTimeout(() => {
        this.clear(notification);
      }, notification.timeout);
    }
    return notification;
  }
  clear(notif) {
    this.getContainer().removeChild(notif.element);
  }
  addToDOM(notif) {
    this.getContainer().appendChild(notif.element);
  }
  getContainer() {
    return document.getElementById(this.notifContainerId);
  }
}
class Props {
  constructor() {
  }
  add(el_id, classname) {
    const el = document.getElementById(el_id);
    if (!el) {
      console.debug(`${el_id} missing from DOM`);
      return;
    }
    el.classList.add(classname);
  }
  remove(el_id, classname) {
    const el = document.getElementById(el_id);
    if (!el) {
      console.debug(`${el_id} missing from DOM`);
      return;
    }
    el.classList.remove(classname);
  }
  switch(el_id, classname) {
    const el = document.getElementById(el_id);
    if (!el) {
      console.debug(`${el_id} missing from DOM`);
      return;
    }
    el.classList.contains(classname) ? el.classList.remove(classname) : el.classList.add(classname);
  }
}
class Visibility {
  constructor() {
    this.hiddenClass = "hidden";
  }
  switch(el_id) {
    const el = document.getElementById(el_id);
    if (!el) {
      console.debug(`${el_id} missing from DOM`);
      return;
    }
    el.classList.contains(this.hiddenClass) ? el.classList.remove(this.hiddenClass) : el.classList.add(this.hiddenClass);
  }
  rotate(el_id, deg) {
    const el = document.getElementById(el_id);
    if (!el) {
      console.debug(`${el_id} missing from DOM`);
      return;
    }
  }
}
window.APP = {
  visibility: new Visibility(),
  props: new Props(),
  notif: new Notif()
};
