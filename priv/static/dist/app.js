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
window.APP = {
  notif: new Notif()
};
