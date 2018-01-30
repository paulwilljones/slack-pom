* Build the image:
    ```docker build -t slack-pom:0.1 .```

* Run the container with ENV file:
    ```docker run --rm --env-file ENV -ti slack-pom:0.1```

* Run the container with ENV vatriables:
    ```docker run --rm -e SLACK_API_TOKEN=${SLACK_API_TOKEN} -e SLACK_USER=${SLACK_USER} -ti slack-pom:0.1```
