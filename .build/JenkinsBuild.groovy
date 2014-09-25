job {
    name('ryans-grails-test-job')
    displayName('Ryans Grails Test Job')

    scm {
        git {
            remote {
                url('https://github.com/ryanwalker/jenkins-grails-testing.git')
            }
            branch('master')
            createTag(false)
            clean(true)

        }
    }

    steps {
        grails {
            target("test-app")
            name("Grails 2.3.11")

        }
    }

}

job {
    name('ryans-grails-war-job')
    displayName('Ryans Grails War Job')

    scm {
        git {
            remote {
                url('https://github.com/ryanwalker/jenkins-grails-testing.git')
            }
            branch('master')
            createTag(false)
            clean(true)

        }
    }

    triggers {
        scm('H/5 * * * *')
    }

    steps {
        grails {
            target("war")
            name("Grails 2.3.11")
        }
    }

}