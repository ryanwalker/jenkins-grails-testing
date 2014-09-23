job {
    name('ryans-jenkins-grails-testing-job')
    displayName('Ryans Jenkins Grails Testing')
    description('Job dsl created, the automation has begun.')
    disabled(false)
    jdk('the name of the jdk to use')

    scm {
        git {
            remote {
                url('git@github.com:ryanwalker/jenkins-grails-testing.git')
            }
            branch('master')
            createTag(false)
            clean(true)

        }
    }

    steps {
        grails {
            target("test-app")
        }
    }

}



job {
    name 'DSL-Grails-Test'
    scm {
        git('https://github.com/ryanwalker/jenkins-grails-testing.git')
    }
    triggers {
        scm('*/15 * * * *')
    }
    steps {
        grails('test-app')
    }
}