# Runs prior to every test
setup() {
    # Load our script file.
    source ./src/scripts/install.sh
}

@test '1: Greet the world' {
    # Mock environment variables or functions by exporting them (after the script has been sourced)
    export PARAM_VERSION="2.2.3"
    export PARAM_OS="macos"
    # Capture the output of our "Install" function
    result=$(Install)
    # [ "$result" == "Hello World" ]
}
