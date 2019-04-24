
import LiveSocket from "phoenix_live_view"

let closestPhxBinding = (el, binding) => {
  do {
    if(el.matches(`[${binding}]`)){ return el }
    el = el.parentElement || el.parentNode
  } while(el !== null && el.nodeType === 1 && !el.matches("[data-phx-view]"))
  return null
}
export default class MouseLiveSocket extends LiveSocket {
    bindTopLevelEvents(){
        super.bindTopLevelEvents()
        let events = ["mouseenter", " mouseleave", "mousemove"]
        for(var eventIndex in events){
            let eventName = events[eventIndex]
            window.addEventListener(eventName, e => {
                if(!this[eventName+"_locked"]){
                  let binding = this.binding(eventName)
                  let target = closestPhxBinding(e.target, binding)
                  let phxEvent = target && target.getAttribute(binding)
                  if(!phxEvent){ return }
                  e.preventDefault()
                  this.owner(target, view => {
                    view.pushWithReply("event", {
                      type: eventName,
                      event: phxEvent,
                      value: {x: e.x, y: e.y}
                    })
                  })
                  this[eventName+"_locked"] = true;
                  setTimeout(_ => {
                    this[eventName+"_locked"] = false;
                  }, 20);
                }
            }, true)
        }
    }
}

let liveSocket = new MouseLiveSocket("/live")
liveSocket.connect()