import jenkins.grails.testing.WorkoutType

class BootStrap {

    def init = { servletContext ->
        new WorkoutType(name: "Swim").save()
        new WorkoutType(name: "Bike").save()
        new WorkoutType(name: "Run").save()
        new WorkoutType(name: "Strength").save()
    }
    def destroy = {
    }
}
