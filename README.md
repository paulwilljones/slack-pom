
  docker build -t slack-pom:0.1 .
  docker run --rm --env-file ENV -ti slack-pom:0.1

