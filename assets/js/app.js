require("bootstrap");

import "phoenix_html"
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
        let ignoreNext = false;
        let eventDefinitions = {}
        eventDefinitions["mousemove"] = {
            rateLimit: 20,
            getTarget: closestPhxBinding
        }
        eventDefinitions["mouseenter"] = {
            jsEventName: "mouseover",
            getPhxEvent: function(target, binding){
                let phxEvent = undefined
                if(!ignoreNext){
                    let boundTarget = closestPhxBinding(target, binding)
                    phxEvent = boundTarget && boundTarget.getAttribute(binding)
                } else {
                    ignoreNext = false
                }
                return phxEvent
            },
        }
        eventDefinitions["mouseleave"] = {
            jsEventName: "mouseout",
            getPhxEvent: function(target, binding){
                let phxEvent = undefined
                if(target){
                    let parent = target.parentElement || target.parentNode
                    let parentPhxEvent = closestPhxBinding(target, binding.replace("mouseleave", "mouseenter"))
                    if(parentPhxEvent){
                        ignoreNext = true
                    }
                    phxEvent = target.getAttribute(binding)
                }
                return phxEvent
            },
        }
        eventDefinitions["mouseover"] = {
        }
        eventDefinitions["mouseout"] = eventDefinitions["mouseover"]
        eventDefinitions["mousedown"] = {
            getTarget: closestPhxBinding
        }
        eventDefinitions["mouseup"] = eventDefinitions["mousedown"]
        let rateLimitedEventTiming = {"mousemove": 20}
        let events = ["mouseover", " mouseout", "mousemove", "mousedown", "mouseup"]
        let useNearestTargetEvents = ["mousemove", "mousedown", "mouseup"]
        for(let loopEventName in eventDefinitions){
            let eventName = loopEventName
            let eventOptions = eventDefinitions[eventName]
            let jsEventName = eventOptions.jsEventName || eventName
            window.addEventListener(jsEventName, e => {
                if(!eventOptions.rateLimit || !this[eventName+"_ratelocked"]){
                  let binding = this.binding(eventName)
                  let target = e.target
                  if(eventOptions.getTarget){
                    target = eventOptions.getTarget(e.target, binding)
                  }
                  let phxEvent = undefined
                  if(eventOptions.getPhxEvent){
                    phxEvent = eventOptions.getPhxEvent(target, binding)
                  } else {
                    phxEvent = target && target.getAttribute(binding)
                  }
                  if(!phxEvent){ return }
                  e.preventDefault()
                  this.owner(target, view => {
                    view.pushWithReply("event", {
                      type: eventName,
                      event: phxEvent,
                      value: {x: e.x, y: e.y}
                    })
                  })
                  if (eventOptions.rateLimit){
                      this[eventName+"_ratelocked"] = true;
                      setTimeout(_ => {
                        this[eventName+"_ratelocked"] = false;
                      }, rateLimitedEventTiming[eventName]);
                  }
                }
            }, true)
        }
    }
}

let liveSocket = new MouseLiveSocket("/live")
liveSocket.connect()
