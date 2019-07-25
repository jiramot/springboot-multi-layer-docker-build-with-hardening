FROM openjdk:8 AS BUILD

ENV APP_HOME=/app
WORKDIR $APP_HOME

COPY gradlew $APP_HOME/
COPY gradle $APP_HOME/gradle
RUN ./gradlew || return 0

COPY build.gradle.kts settings.gradle.kts $APP_HOME/
RUN ./gradlew build || return 0

COPY . .
RUN ./gradlew build


FROM openjdk:8
ENV APP_HOME=/app
WORKDIR $APP_HOME

RUN useradd -ms /bin/bash appuser
USER appuser

COPY --chown=appuser:appuser --from=BUILD $APP_HOME/build/libs/*.jar app.jar

EXPOSE 8080
CMD ["java","-jar", "app.jar"]