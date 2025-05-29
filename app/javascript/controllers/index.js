// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)
import SetCompleteController from "./set_complete_controller"
application.register("set-complete", SetCompleteController)
import SetModalController from "./modal_controller"
application.register("set-modal", SetModalController)
